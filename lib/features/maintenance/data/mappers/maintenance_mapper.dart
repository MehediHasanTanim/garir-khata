import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/maintenance/domain/entities/maintenance_template.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';

abstract final class MaintenanceMapper {
  static MaintenanceTemplate templateToDomain(MaintenanceTemplateRow row) {
    return MaintenanceTemplate(
      id: row.id,
      code: row.code,
      nameEn: row.nameEn,
      nameBn: row.nameBn,
      vehicleType: row.vehicleType,
      defaultKmInterval: row.defaultKmInterval,
      defaultDayInterval: row.defaultDayInterval,
      iconKey: row.iconKey,
      isSystem: row.isSystem,
      isActive: row.isActive,
      sortOrder: row.sortOrder,
      createdAt: row.createdAt,
    );
  }

  static ServiceItem itemToDomain(ServiceItemRow row) {
    return ServiceItem(
      id: row.id,
      serviceRecordId: row.serviceRecordId,
      templateId: row.templateId,
      maintenanceType: row.maintenanceType,
      title: row.title,
      costPaisa: row.costPaisa,
      quantity: row.quantity,
      note: row.note,
    );
  }

  static ServiceRecord recordToDomain(
    ServiceRecordRow row, {
    List<ServiceItem> items = const [],
  }) {
    return ServiceRecord(
      id: row.id,
      vehicleId: row.vehicleId,
      serviceDate: row.serviceDate,
      odometer: row.odometer,
      vendorName: row.vendorName,
      laborCostPaisa: row.laborCostPaisa,
      partsCostPaisa: row.partsCostPaisa,
      totalCostPaisa: row.totalCostPaisa,
      nextDueDate: row.nextDueDate,
      nextDueOdometer: row.nextDueOdometer,
      note: row.note,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      items: items,
    );
  }

  static ServiceRecordsCompanion recordCompanion(ServiceRecord record) {
    return ServiceRecordsCompanion.insert(
      id: record.id,
      vehicleId: record.vehicleId,
      serviceDate: record.serviceDate,
      odometer: record.odometer,
      vendorName: Value(record.vendorName),
      laborCostPaisa: Value(record.laborCostPaisa),
      partsCostPaisa: Value(record.partsCostPaisa),
      totalCostPaisa: Value(record.totalCostPaisa),
      nextDueDate: Value(record.nextDueDate),
      nextDueOdometer: Value(record.nextDueOdometer),
      note: Value(record.note),
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    );
  }

  static ServiceItemsCompanion itemCompanion(ServiceItem item) {
    return ServiceItemsCompanion.insert(
      id: item.id,
      serviceRecordId: item.serviceRecordId,
      templateId: Value(item.templateId),
      maintenanceType: item.maintenanceType,
      title: item.title,
      costPaisa: Value(item.costPaisa),
      quantity: Value(item.quantity),
      note: Value(item.note),
    );
  }

  static OilChange oilToDomain(OilChangeRow row) {
    return OilChange(
      id: row.id,
      vehicleId: row.vehicleId,
      occurredOn: row.occurredOn,
      odometer: row.odometer,
      brand: row.brand,
      productName: row.productName,
      viscosity: row.viscosity,
      quantityMl: row.quantityMl,
      costPaisa: row.costPaisa,
      filterChanged: row.filterChanged,
      vendorName: row.vendorName,
      nextDueDate: row.nextDueDate,
      nextDueOdometer: row.nextDueOdometer,
      note: row.note,
      serviceRecordId: row.serviceRecordId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static OilChangesCompanion oilCompanion(OilChange oil) {
    return OilChangesCompanion.insert(
      id: oil.id,
      vehicleId: oil.vehicleId,
      occurredOn: oil.occurredOn,
      odometer: oil.odometer,
      brand: Value(oil.brand),
      productName: Value(oil.productName),
      viscosity: Value(oil.viscosity),
      quantityMl: Value(oil.quantityMl),
      costPaisa: Value(oil.costPaisa),
      filterChanged: Value(oil.filterChanged),
      vendorName: Value(oil.vendorName),
      nextDueDate: Value(oil.nextDueDate),
      nextDueOdometer: Value(oil.nextDueOdometer),
      note: Value(oil.note),
      serviceRecordId: Value(oil.serviceRecordId),
      createdAt: oil.createdAt,
      updatedAt: oil.updatedAt,
    );
  }
}
