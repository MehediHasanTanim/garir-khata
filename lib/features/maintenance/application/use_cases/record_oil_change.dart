import 'package:garir_khata/core/database/seeds/maintenance_template_seeds.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/entities/maintenance_template.dart';
import 'package:garir_khata/features/maintenance/domain/entities/oil_change.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/maintenance/domain/next_due_calculator.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/oil_repository.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/service_repository.dart';
import 'package:garir_khata/features/maintenance/domain/validation/oil_validator.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';

class RecordOilChange {
  const RecordOilChange({
    required this.oilRepository,
    required this.serviceRepository,
    required this.expenseLink,
    required this.uuidGenerator,
    required this.clock,
  });

  final OilRepository oilRepository;
  final ServiceRepository serviceRepository;
  final ServiceExpenseLink expenseLink;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<OilChange>> call({
    required OilChangeInput input,
    required VehicleType vehicleType,
  }) async {
    final Result<ValidatedOilChangeInput> validated =
        OilValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedOilChangeInput clean =
        (validated as Success<ValidatedOilChangeInput>).data;
    final DateTime now = clock.now();
    final String oilId = uuidGenerator.v4();

    final Result<MaintenanceTemplate?> templateResult =
        await serviceRepository.getTemplateByCode(
      code: MaintenanceTemplateCodes.engineOil,
      vehicleType: _mapVehicleType(vehicleType),
    );
    final MaintenanceTemplate? template =
        templateResult is Success<MaintenanceTemplate?>
            ? templateResult.data
            : null;

    final NextDueSuggestion suggested = NextDueCalculator.suggest(
      performedOdometer: clean.odometer,
      performedAt: clean.occurredOn,
      kmInterval: template?.defaultKmInterval ?? 2000,
      dayInterval: template?.defaultDayInterval ?? 90,
    );

    final DateTime? nextDueDate = clean.nextDueDate ?? suggested.nextDueDate;
    final int? nextDueOdometer =
        clean.nextDueOdometer ?? suggested.nextDueOdometer;

    ServiceRecord? serviceRecord;
    String? serviceId;
    if (clean.createServiceRecord) {
      serviceId = uuidGenerator.v4();
      final String itemId = uuidGenerator.v4();
      serviceRecord = ServiceRecord(
        id: serviceId,
        vehicleId: clean.vehicleId,
        serviceDate: clean.occurredOn,
        odometer: clean.odometer,
        vendorName: clean.vendorName,
        laborCostPaisa: 0,
        partsCostPaisa: clean.costPaisa,
        totalCostPaisa: clean.costPaisa,
        nextDueDate: nextDueDate,
        nextDueOdometer: nextDueOdometer,
        note: clean.note,
        createdAt: now,
        updatedAt: now,
        items: [
          ServiceItem(
            id: itemId,
            serviceRecordId: serviceId,
            templateId: template?.id,
            maintenanceType: MaintenanceTemplateCodes.engineOil,
            title: template?.nameEn ?? 'Engine oil',
            costPaisa: clean.costPaisa,
            quantity: 1,
            note: clean.filterChanged ? 'Oil filter changed' : null,
          ),
          if (clean.filterChanged)
            ServiceItem(
              id: uuidGenerator.v4(),
              serviceRecordId: serviceId,
              templateId: null,
              maintenanceType: MaintenanceTemplateCodes.oilFilter,
              title: 'Oil filter',
              costPaisa: 0,
              quantity: 1,
            ),
        ],
      );
    }

    final OilChange oil = OilChange(
      id: oilId,
      vehicleId: clean.vehicleId,
      occurredOn: clean.occurredOn,
      odometer: clean.odometer,
      brand: clean.brand,
      productName: clean.productName,
      viscosity: clean.viscosity,
      quantityMl: clean.quantityMl,
      costPaisa: clean.costPaisa,
      filterChanged: clean.filterChanged,
      vendorName: clean.vendorName,
      nextDueDate: nextDueDate,
      nextDueOdometer: nextDueOdometer,
      note: clean.note,
      serviceRecordId: serviceId,
      createdAt: now,
      updatedAt: now,
    );

    final OdometerEntry odometerEntry = OdometerEntry(
      id: uuidGenerator.v4(),
      vehicleId: clean.vehicleId,
      recordedAt: clean.occurredOn,
      odometer: clean.odometer,
      sourceType: OdometerSourceType.oilChange,
      sourceRecordId: oilId,
      isManualCorrection: false,
      isDiscontinuity: false,
      createdAt: now,
    );

    final Result<OilChange> saved = await oilRepository.createBundle(
      OilChangeBundle(
        oilChange: oil,
        serviceRecord: serviceRecord,
        odometerEntry: odometerEntry,
      ),
    );
    if (saved case Failure(:final error)) {
      return Failure(error);
    }

    if (clean.createExpense) {
      if (serviceRecord != null) {
        await expenseLink.upsertForService(serviceRecord);
      } else {
        await expenseLink.upsertForOil(oil);
      }
    }

    return Success(oil);
  }

  String _mapVehicleType(VehicleType type) {
    return switch (type) {
      VehicleType.motorcycle || VehicleType.scooter => 'motorcycle',
      VehicleType.car ||
      VehicleType.suv ||
      VehicleType.microbus ||
      VehicleType.pickup =>
        'car',
      _ => 'motorcycle',
    };
  }
}
