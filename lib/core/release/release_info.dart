import 'package:garir_khata/core/backup/backup_models.dart';
import 'package:garir_khata/core/database/app_database.dart';

/// Canonical release metadata for checklist / About / store submissions.
/// Keep [appVersion] + [buildNumber] aligned with `pubspec.yaml`.
abstract final class ReleaseInfo {
  static const String appName = 'Garir Khata';
  static const String appNameBangla = 'গাড়ির খাতা';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 11;
  static const String versionLabel = '$appVersion+$buildNumber';

  static const String androidApplicationId = 'bd.garirkhata.garir_khata';
  static const String iosBundleId = 'bd.garirkhata.garirKhata';

  static const String privacyPolicyPath = 'docs/release/PRIVACY_POLICY.md';
  static const String changelogPath = 'docs/release/CHANGELOG.md';

  /// Prefer probing a live [AppDatabase] in tests; this mirrors schemaVersion.
  static const int databaseSchemaVersion = 7;

  static int get backupFormatVersion => BackupManifest.currentFormatVersion;

  static Map<String, Object?> checklistSnapshot({AppDatabase? db}) => {
        'appVersion': appVersion,
        'buildNumber': buildNumber,
        'databaseSchemaVersion': db?.schemaVersion ?? databaseSchemaVersion,
        'backupFormatVersion': backupFormatVersion,
        'androidApplicationId': androidApplicationId,
        'iosBundleId': iosBundleId,
      };
}
