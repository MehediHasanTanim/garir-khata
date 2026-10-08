import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

abstract final class FuelMapper {
  static FuelEntry toDomain(FuelEntryRow row) {
    return FuelEntry(
      id: row.id,
      vehicleId: row.vehicleId,
      dateTime: row.entryDateTime,
      odometer: row.odometer,
      fuelType: FuelType.values.byName(row.fuelType),
      quantityMl: row.quantityMl,
      pricePerUnitPaisa: row.pricePerUnitPaisa,
      totalCostPaisa: row.totalCostPaisa,
      isFullTank: row.isFullTank,
      vendorId: row.vendorId,
      stationName: row.stationName,
      locationText: row.locationText,
      paymentMethod: row.paymentMethod == null
          ? null
          : PaymentMethod.values.byName(row.paymentMethod!),
      note: row.note,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static FuelEntriesCompanion toCompanion(FuelEntry entry) {
    return FuelEntriesCompanion.insert(
      id: entry.id,
      vehicleId: entry.vehicleId,
      entryDateTime: entry.dateTime,
      odometer: entry.odometer,
      fuelType: entry.fuelType.name,
      quantityMl: entry.quantityMl,
      pricePerUnitPaisa: Value(entry.pricePerUnitPaisa),
      totalCostPaisa: entry.totalCostPaisa,
      isFullTank: Value(entry.isFullTank),
      vendorId: Value(entry.vendorId),
      stationName: Value(entry.stationName),
      locationText: Value(entry.locationText),
      paymentMethod: Value(entry.paymentMethod?.name),
      note: Value(entry.note),
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }
}
