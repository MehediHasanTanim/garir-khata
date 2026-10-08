import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/maintenance/data/repositories/drift_service_repository.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/service_repository.dart';
import 'package:garir_khata/features/maintenance/domain/validation/service_validator.dart';
import 'package:garir_khata/features/odometer/domain/entities/odometer_entry.dart';

class AddService {
  const AddService({
    required this.repository,
    required this.expenseLink,
    required this.uuidGenerator,
    required this.clock,
  });

  final ServiceRepository repository;
  final ServiceExpenseLink expenseLink;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<ServiceRecord>> call(ServiceInput input) async {
    final Result<ValidatedServiceInput> validated =
        ServiceValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedServiceInput clean =
        (validated as Success<ValidatedServiceInput>).data;
    final DateTime now = clock.now();
    final String serviceId = uuidGenerator.v4();
    final List<ServiceItem> items = clean.items
        .map(
          (item) => ServiceItem(
            id: uuidGenerator.v4(),
            serviceRecordId: serviceId,
            templateId: item.templateId,
            maintenanceType: item.maintenanceType,
            title: item.title,
            costPaisa: item.costPaisa,
            quantity: item.quantity,
            note: item.note,
          ),
        )
        .toList();
    final ServiceRecord record = ServiceRecord(
      id: serviceId,
      vehicleId: clean.vehicleId,
      serviceDate: clean.serviceDate,
      odometer: clean.odometer,
      vendorName: clean.vendorName,
      laborCostPaisa: clean.laborCostPaisa,
      partsCostPaisa: clean.partsCostPaisa,
      totalCostPaisa: clean.totalCostPaisa,
      nextDueDate: clean.nextDueDate,
      nextDueOdometer: clean.nextDueOdometer,
      note: clean.note,
      createdAt: now,
      updatedAt: now,
      items: items,
    );

    final Result<ServiceRecord> saved =
        await repository.createWithItems(record);
    if (saved case Failure(:final error)) {
      return Failure(error);
    }

    if (repository is DriftServiceRepository) {
      await (repository as DriftServiceRepository).insertOdometer(
        OdometerEntry(
          id: uuidGenerator.v4(),
          vehicleId: clean.vehicleId,
          recordedAt: clean.serviceDate,
          odometer: clean.odometer,
          sourceType: OdometerSourceType.service,
          sourceRecordId: serviceId,
          isManualCorrection: false,
          isDiscontinuity: false,
          createdAt: now,
        ),
      );
    }

    await expenseLink.upsertForService(record);
    return Success(record);
  }
}
