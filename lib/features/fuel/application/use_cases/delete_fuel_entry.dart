import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/fuel/domain/repositories/fuel_repository.dart';

class DeleteFuelEntry {
  const DeleteFuelEntry({
    required this.fuelRepository,
    required this.expenseLink,
  });

  final FuelRepository fuelRepository;
  final FuelExpenseLinkService expenseLink;

  Future<Result<void>> call(String id) async {
    final Result<void> result = await fuelRepository.delete(id);
    if (result.isSuccess) {
      await expenseLink.deleteLinkedExpense(id);
    }
    return result;
  }
}
