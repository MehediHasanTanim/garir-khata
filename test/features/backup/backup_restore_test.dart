import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/backup/backup_encryption.dart';
import 'package:garir_khata/core/backup/backup_models.dart';
import 'package:garir_khata/core/backup/backup_service.dart';
import 'package:garir_khata/core/backup/restore_service.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/attachments/application/attachment_service.dart';
import 'package:garir_khata/features/attachments/data/repositories/drift_attachment_repository.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/data/repositories/drift_vehicle_repository.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

void main() {
  late Directory temp;
  late File dbFile;
  late AppDatabase db;
  late FileStorageService storage;
  late BackupService backup;
  late RestoreService restore;

  Future<AppDatabase> openDb() async {
    return AppDatabase(NativeDatabase(dbFile));
  }

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('gk_backup_');
    dbFile = File(p.join(temp.path, 'live.sqlite'));
    db = AppDatabase(NativeDatabase(dbFile));
    storage = FileStorageService(
      rootDirectory: Directory(p.join(temp.path, 'data')),
      uuidGenerator: const DefaultUuidGenerator(),
    );
    await storage.ensureReady();

    await AddVehicle(
      repository: DriftVehicleRepository(db),
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    )(
      const VehicleInput(
        nickname: 'Backup Bike',
        vehicleType: VehicleType.motorcycle,
        fuelType: FuelType.petrol,
        currentOdometer: 5000,
      ),
    );

    final attachments = AttachmentService(
      repository: DriftAttachmentRepository(db),
      storage: storage,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
    );
    final image = img.Image(width: 16, height: 16);
    img.fill(image, color: img.ColorRgb8(1, 2, 3));
    await attachments.addBytes(
      ownerType: AttachmentOwnerType.fuel,
      ownerId: 'fuel-x',
      bytes: Uint8List.fromList(img.encodePng(image)),
      originalFileName: 'r.png',
    );

    backup = BackupService(
      db: db,
      storage: storage,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
      snapshotDatabase: (dir) async {
        await db.customStatement('PRAGMA wal_checkpoint(FULL)');
        final dest = File(p.join(dir.path, 'database.sqlite'));
        await dbFile.copy(dest.path);
        return dest;
      },
    );

    restore = RestoreService(
      db: db,
      storage: storage,
      backupService: backup,
      uuidGenerator: const DefaultUuidGenerator(),
      clock: const SystemClock(),
      replaceDatabase: (restored) async {
        await db.close();
        await restored.copy(dbFile.path);
        db = await openDb();
        backup = BackupService(
          db: db,
          storage: storage,
          uuidGenerator: const DefaultUuidGenerator(),
          clock: const SystemClock(),
          snapshotDatabase: (dir) async {
            final dest = File(p.join(dir.path, 'database.sqlite'));
            await dbFile.copy(dest.path);
            return dest;
          },
        );
        restore = RestoreService(
          db: db,
          storage: storage,
          backupService: backup,
          uuidGenerator: const DefaultUuidGenerator(),
          clock: const SystemClock(),
          replaceDatabase: (f) async {},
        );
      },
    );
  });

  tearDown(() async {
    await db.close();
    if (await temp.exists()) {
      await temp.delete(recursive: true);
    }
  });

  test('create and restore backup round-trip', () async {
    final created = await backup.createBackup(
      includeAttachments: true,
      outputDirectory: Directory(p.join(temp.path, 'out')),
    );
    expect(created.isSuccess, isTrue);
    final envelope = await File(created.dataOrNull!.filePath).readAsBytes();

    final inspected = await restore.inspect(envelope: envelope);
    expect(inspected.isSuccess, isTrue);
    expect(inspected.dataOrNull!.manifest.vehicleCount, 1);
    expect(inspected.dataOrNull!.manifest.attachmentCount, greaterThan(0));

    // Wipe attachments then restore.
    await storage.filesRoot.delete(recursive: true);
    final outcome = await restore.restore(
      envelope: envelope,
      createSafetyBackup: false,
    );
    expect(outcome.dataOrNull!.phase, RestorePhase.success);
    expect(await storage.filesRoot.exists(), isTrue);
  });

  test('encrypted backup rejects wrong password', () async {
    final created = await backup.createBackup(
      password: 'secret',
      outputDirectory: Directory(p.join(temp.path, 'out2')),
    );
    final envelope = await File(created.dataOrNull!.filePath).readAsBytes();
    expect(BackupEncryption.isEncrypted(envelope), isTrue);

    final wrong = await restore.inspect(
      envelope: envelope,
      password: 'nope',
    );
    expect(wrong.isFailure, isTrue);
    expect(wrong.errorOrNull!.message.toLowerCase(), contains('password'));
  });

  test('corrupt backup is detected', () async {
    final created = await backup.createBackup(
      outputDirectory: Directory(p.join(temp.path, 'out3')),
    );
    final bytes = await File(created.dataOrNull!.filePath).readAsBytes();
    // Truncate payload so zip/manifest cannot be read.
    final corrupt = Uint8List.fromList(bytes.sublist(0, 8));
    final result = await restore.inspect(envelope: corrupt);
    expect(result.isFailure, isTrue);
  });

  test('unsupported format version fails', () async {
    final created = await backup.createBackup(
      outputDirectory: Directory(p.join(temp.path, 'out4')),
    );
    // Tamper magic to unsupported.
    final bytes = await File(created.dataOrNull!.filePath).readAsBytes();
    bytes[0] = 0x00;
    final result = await restore.inspect(envelope: Uint8List.fromList(bytes));
    expect(result.isFailure, isTrue);
  });
}
