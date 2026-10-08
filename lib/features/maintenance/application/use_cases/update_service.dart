import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/maintenance/data/service_expense_link.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/maintenance/domain/repositories/service_repository.dart';
import 'package:garir_khata/features/maintenance/domain/validation/service_validator.dart';

class UpdateService {
  const UpdateService({
    required this.repository,
    required this.expenseLink,
    required this.uuidGenerator,
    required this.clock,
  });

  final ServiceRepository repository;
  final ServiceExpenseLink expenseLink;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<ServiceRecord>> call({
    required String id,
    required ServiceInput input,
  }) async {
    final Result<ServiceRecord?> existing = await repository.getById(id);
    if (existing case Failure(:final error)) {
      return Failure(error);
    }
    if ((existing as Success<ServiceRecord?>).data == null) {
      return const Failure(
        ValidationError(message: 'Service not found', field: 'id'),
      );
    }
    final ServiceRecord previous = existing.data!;
    final Result<ValidatedServiceInput> validated =
        ServiceValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedServiceInput clean =
        (validated as Success<ValidatedServiceInput>).data;
    final List<ServiceItem> items = clean.items
        .map(
          (item) => ServiceItem(
            id: uuidGenerator.v4(),
            serviceRecordId: id,
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
      id: id,
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
      createdAt: previous.createdAt,
      updatedAt: clock.now(),
      items: items,
    );
    final Result<ServiceRecord> saved =
        await repository.updateWithItems(record);
    if (saved case Success()) {
      await expenseLink.upsertForService(record);
    }
    return saved;
  }
}
