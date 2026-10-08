import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/parts/domain/entities/battery.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';
import 'package:garir_khata/features/parts/domain/entities/vehicle_part.dart';
import 'package:garir_khata/features/parts/domain/tyre_positions.dart';

abstract final class PartsMapper {
  static RepairPart repairPartToDomain(RepairPartRow row) {
    return RepairPart(
      id: row.id,
      repairId: row.repairId,
      partName: row.partName,
      brand: row.brand,
      partNumber: row.partNumber,
      quantity: row.quantity,
      unitCostPaisa: row.unitCostPaisa,
      totalCostPaisa: row.totalCostPaisa,
      warrantyEndDate: row.warrantyEndDate,
      note: row.note,
    );
  }

  static Repair repairToDomain(RepairRow row, {List<RepairPart> parts = const []}) {
    return Repair(
      id: row.id,
      vehicleId: row.vehicleId,
      repairDate: row.repairDate,
      odometer: row.odometer,
      category: row.category,
      problemDescription: row.problemDescription,
      diagnosis: row.diagnosis,
      workPerformed: row.workPerformed,
      vendorName: row.vendorName,
      laborCostPaisa: row.laborCostPaisa,
      partsCostPaisa: row.partsCostPaisa,
      totalCostPaisa: row.totalCostPaisa,
      warrantyEndDate: row.warrantyEndDate,
      followUpDate: row.followUpDate,
      note: row.note,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      parts: parts,
    );
  }

  static RepairsCompanion repairCompanion(Repair repair) {
    return RepairsCompanion.insert(
      id: repair.id,
      vehicleId: repair.vehicleId,
      repairDate: repair.repairDate,
      odometer: repair.odometer,
      category: repair.category,
      problemDescription: repair.problemDescription,
      diagnosis: Value(repair.diagnosis),
      workPerformed: Value(repair.workPerformed),
      vendorName: Value(repair.vendorName),
      laborCostPaisa: Value(repair.laborCostPaisa),
      partsCostPaisa: Value(repair.partsCostPaisa),
      totalCostPaisa: Value(repair.totalCostPaisa),
      warrantyEndDate: Value(repair.warrantyEndDate),
      followUpDate: Value(repair.followUpDate),
      note: Value(repair.note),
      createdAt: repair.createdAt,
      updatedAt: repair.updatedAt,
    );
  }

  static RepairPartsCompanion repairPartCompanion(RepairPart part) {
    return RepairPartsCompanion.insert(
      id: part.id,
      repairId: part.repairId,
      partName: part.partName,
      brand: Value(part.brand),
      partNumber: Value(part.partNumber),
      quantity: Value(part.quantity),
      unitCostPaisa: Value(part.unitCostPaisa),
      totalCostPaisa: Value(part.totalCostPaisa),
      warrantyEndDate: Value(part.warrantyEndDate),
      note: Value(part.note),
    );
  }

  static VehiclePart vehiclePartToDomain(VehiclePartRow row) {
    return VehiclePart(
      id: row.id,
      vehicleId: row.vehicleId,
      category: row.category,
      name: row.name,
      brand: row.brand,
      partNumber: row.partNumber,
      installedDate: row.installedDate,
      installedOdometer: row.installedOdometer,
      costPaisa: row.costPaisa,
      vendorName: row.vendorName,
      warrantyEndDate: row.warrantyEndDate,
      replacementIntervalKm: row.replacementIntervalKm,
      replacementIntervalDays: row.replacementIntervalDays,
      note: row.note,
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static VehiclePartsCompanion vehiclePartCompanion(VehiclePart part) {
    return VehiclePartsCompanion.insert(
      id: part.id,
      vehicleId: part.vehicleId,
      category: part.category,
      name: part.name,
      brand: Value(part.brand),
      partNumber: Value(part.partNumber),
      installedDate: part.installedDate,
      installedOdometer: Value(part.installedOdometer),
      costPaisa: Value(part.costPaisa),
      vendorName: Value(part.vendorName),
      warrantyEndDate: Value(part.warrantyEndDate),
      replacementIntervalKm: Value(part.replacementIntervalKm),
      replacementIntervalDays: Value(part.replacementIntervalDays),
      note: Value(part.note),
      isActive: Value(part.isActive),
      createdAt: part.createdAt,
      updatedAt: part.updatedAt,
    );
  }

  static Tyre tyreToDomain(TyreRow row, {List<TyreEvent> events = const []}) {
    return Tyre(
      id: row.id,
      vehicleId: row.vehicleId,
      position: TyrePosition.values.byName(row.position),
      brand: row.brand,
      model: row.model,
      size: row.size,
      purchaseDate: row.purchaseDate,
      installDate: row.installDate,
      installOdometer: row.installOdometer,
      costPaisa: row.costPaisa,
      warrantyEndDate: row.warrantyEndDate,
      vendorName: row.vendorName,
      status: TyreStatus.values.byName(row.status),
      note: row.note,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      events: events,
    );
  }

  static TyresCompanion tyreCompanion(Tyre tyre) {
    return TyresCompanion.insert(
      id: tyre.id,
      vehicleId: tyre.vehicleId,
      position: tyre.position.name,
      brand: Value(tyre.brand),
      model: Value(tyre.model),
      size: Value(tyre.size),
      purchaseDate: Value(tyre.purchaseDate),
      installDate: tyre.installDate,
      installOdometer: tyre.installOdometer,
      costPaisa: Value(tyre.costPaisa),
      warrantyEndDate: Value(tyre.warrantyEndDate),
      vendorName: Value(tyre.vendorName),
      status: Value(tyre.status.name),
      note: Value(tyre.note),
      createdAt: tyre.createdAt,
      updatedAt: tyre.updatedAt,
    );
  }

  static TyreEvent eventToDomain(TyreEventRow row) {
    return TyreEvent(
      id: row.id,
      tyreId: row.tyreId,
      vehicleId: row.vehicleId,
      eventType: TyreEventType.values.byName(row.eventType),
      occurredOn: row.occurredOn,
      odometer: row.odometer,
      fromPosition: row.fromPosition == null
          ? null
          : TyrePosition.values.byName(row.fromPosition!),
      toPosition: row.toPosition == null
          ? null
          : TyrePosition.values.byName(row.toPosition!),
      inspectionResult: row.inspectionResult,
      costPaisa: row.costPaisa,
      note: row.note,
      createdAt: row.createdAt,
    );
  }

  static TyreEventsCompanion eventCompanion(TyreEvent event) {
    return TyreEventsCompanion.insert(
      id: event.id,
      tyreId: event.tyreId,
      vehicleId: event.vehicleId,
      eventType: event.eventType.name,
      occurredOn: event.occurredOn,
      odometer: Value(event.odometer),
      fromPosition: Value(event.fromPosition?.name),
      toPosition: Value(event.toPosition?.name),
      inspectionResult: Value(event.inspectionResult),
      costPaisa: Value(event.costPaisa),
      note: Value(event.note),
      createdAt: event.createdAt,
    );
  }

  static Battery batteryToDomain(BatteryRow row) {
    return Battery(
      id: row.id,
      vehicleId: row.vehicleId,
      brand: row.brand,
      model: row.model,
      specification: row.specification,
      purchaseDate: row.purchaseDate,
      installDate: row.installDate,
      installOdometer: row.installOdometer,
      costPaisa: row.costPaisa,
      warrantyEndDate: row.warrantyEndDate,
      vendorName: row.vendorName,
      status: BatteryStatus.values.byName(row.status),
      note: row.note,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static BatteriesCompanion batteryCompanion(Battery battery) {
    return BatteriesCompanion.insert(
      id: battery.id,
      vehicleId: battery.vehicleId,
      brand: Value(battery.brand),
      model: Value(battery.model),
      specification: Value(battery.specification),
      purchaseDate: Value(battery.purchaseDate),
      installDate: battery.installDate,
      installOdometer: Value(battery.installOdometer),
      costPaisa: Value(battery.costPaisa),
      warrantyEndDate: Value(battery.warrantyEndDate),
      vendorName: Value(battery.vendorName),
      status: Value(battery.status.name),
      note: Value(battery.note),
      createdAt: battery.createdAt,
      updatedAt: battery.updatedAt,
    );
  }
}
