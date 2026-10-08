import 'package:drift/drift.dart';

@DataClassName('VehicleRow')
class Vehicles extends Table {
  TextColumn get id => text()();
  TextColumn get nickname => text()();
  TextColumn get vehicleType => text()();
  TextColumn get brand => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get variant => text().nullable()();
  IntColumn get modelYear => integer().nullable()();
  TextColumn get registrationNumber => text().nullable()();
  TextColumn get fuelType => text()();
  IntColumn get currentOdometer => integer().withDefault(const Constant(0))();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  IntColumn get purchasePricePaisa => integer().nullable()();
  TextColumn get engineCapacity => text().nullable()();
  TextColumn get engineNumber => text().nullable()();
  TextColumn get chassisNumber => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get ownershipType => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
