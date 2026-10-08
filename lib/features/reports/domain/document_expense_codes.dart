import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';

/// Expense category codes treated as "Documents" in monthly/yearly reports.
abstract final class DocumentExpenseCodes {
  static const List<String> all = [
    ExpenseCategoryCodes.taxToken,
    ExpenseCategoryCodes.fitness,
    ExpenseCategoryCodes.insurance,
    ExpenseCategoryCodes.registration,
  ];

  static String sqlInList() => all.map((c) => "'$c'").join(',');
}
