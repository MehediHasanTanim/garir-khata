import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Resolves durable app directories used by files, backups, and the SQLite DB.
abstract final class AppStoragePaths {
  static Future<Directory> appSupportDir() => getApplicationSupportDirectory();

  static Future<Directory> filesRoot() async {
    final support = await appSupportDir();
    return Directory(p.join(support.path, 'garir_khata_data'));
  }

  /// Matches drift_flutter default naming for `driftDatabase(name: 'garir_khata')`.
  static Future<File> databaseFile() async {
    final support = await appSupportDir();
    return File(p.join(support.path, 'garir_khata.sqlite'));
  }

  static Future<File> snapshotDatabaseTo(Directory tempDir) async {
    final source = await databaseFile();
    final dest = File(p.join(tempDir.path, 'database.sqlite'));
    if (!await source.exists()) {
      throw StateError('Database file not found at ${source.path}');
    }
    // Also copy WAL/SHM if present after checkpoint.
    await source.copy(dest.path);
    for (final suffix in ['.wal', '-wal', '.shm', '-shm']) {
      final side = File('${source.path}$suffix');
      if (await side.exists()) {
        await side.copy('${dest.path}$suffix');
      }
    }
    return dest;
  }
}
