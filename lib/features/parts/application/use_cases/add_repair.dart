import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/parts/data/repair_expense_link.dart';
import 'package:garir_khata/features/parts/domain/entities/repair.dart';
import 'package:garir_khata/features/parts/domain/repositories/repair_repository.dart';
import 'package:garir_khata/features/parts/domain/validation/repair_validator.dart';

class AddRepair {
  const AddRepair({
    required this.repository,
    required this.expenseLink,
    required this.uuidGenerator,
    required this.clock,
  });

  final RepairRepository repository;
  final RepairExpenseLink expenseLink;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<Repair>> call(RepairInput input) async {
    final Result<ValidatedRepairInput> validated =
        RepairValidator.validate(input);
    if (validated case Failure(:final error)) {
      return Failure(error);
    }
    final ValidatedRepairInput clean =
        (validated as Success<ValidatedRepairInput>).data;
    final DateTime now = clock.now();
    final String repairId = uuidGenerator.v4();
    final Repair repair = Repair(
      id: repairId,
      vehicleId: clean.vehicleId,
      repairDate: clean.repairDate,
      odometer: clean.odometer,
      category: clean.category,
      problemDescription: clean.problemDescription,
      diagnosis: clean.diagnosis,
      workPerformed: clean.workPerformed,
      vendorName: clean.vendorName,
      laborCostPaisa: clean.laborCostPaisa,
      partsCostPaisa: clean.partsCostPaisa,
      totalCostPaisa: clean.totalCostPaisa,
      warrantyEndDate: clean.warrantyEndDate,
      followUpDate: clean.followUpDate,
      note: clean.note,
      createdAt: now,
      updatedAt: now,
      parts: clean.parts
          .map(
            (p) => RepairPart(
              id: uuidGenerator.v4(),
              repairId: repairId,
              partName: p.partName,
              brand: p.brand,
              partNumber: p.partNumber,
              quantity: p.quantity,
              unitCostPaisa: p.unitCostPaisa,
              totalCostPaisa: p.totalCostPaisa,
              warrantyEndDate: p.warrantyEndDate,
              note: p.note,
            ),
          )
          .toList(),
    );
    final Result<Repair> saved = await repository.createWithParts(repair);
    if (saved case Success()) {
      await expenseLink.upsert(repair);
    }
    return saved;
  }
}
