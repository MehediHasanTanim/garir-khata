import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/tables/vehicles_table.dart';

@DataClassName('VehicleDocumentRow')
@TableIndex(
  name: 'idx_vehicle_documents_vehicle_type',
  columns: {#vehicleId, #documentType},
)
@TableIndex(
  name: 'idx_vehicle_documents_expiry',
  columns: {#vehicleId, #expiryDate},
)
class VehicleDocuments extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();

  /// registration | tax_token | fitness | insurance | route_permit |
  /// driving_license | ownership_transfer | loan | other
  TextColumn get documentType => text()();
  TextColumn get documentNumber => text().nullable()();
  DateTimeColumn get issueDate => dateTime().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  IntColumn get feePaisa => integer().withDefault(const Constant(0))();
  TextColumn get issuingAuthority => text().nullable()();
  TextColumn get providerName => text().nullable()();
  TextColumn get policyNumber => text().nullable()();
  TextColumn get coverageType => text().nullable()();
  TextColumn get ownerName => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
