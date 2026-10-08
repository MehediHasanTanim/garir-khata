import 'package:drift/drift.dart';

@DataClassName('AttachmentRow')
@TableIndex(
  name: 'idx_attachments_owner',
  columns: {#ownerType, #ownerId},
)
class Attachments extends Table {
  TextColumn get id => text()();
  TextColumn get ownerType => text()();
  TextColumn get ownerId => text()();
  TextColumn get originalFileName => text()();
  TextColumn get storedFileName => text()();
  TextColumn get mimeType => text()();
  IntColumn get fileSizeBytes => integer()();
  TextColumn get relativePath => text()();
  TextColumn get thumbnailRelativePath => text().nullable()();
  TextColumn get checksumSha256 => text()();
  TextColumn get displayLabel => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
