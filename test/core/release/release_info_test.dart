import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/release/release_info.dart';

void main() {
  test('release checklist snapshot is coherent', () {
    final snap = ReleaseInfo.checklistSnapshot();
    expect(snap['appVersion'], '1.0.0');
    expect(snap['buildNumber'], 11);
    expect(snap['databaseSchemaVersion'], 7);
    expect(snap['backupFormatVersion'], 1);
    expect(ReleaseInfo.versionLabel, '1.0.0+11');
  });
}
