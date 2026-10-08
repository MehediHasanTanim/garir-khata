import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/seeds/expense_category_seeds.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/fuel/data/mappers/fuel_mapper.dart';
import 'package:garir_khata/features/fuel/domain/entities/fuel_entry.dart';
import 'package:garir_khata/features/mileage/domain/cost_per_km_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';
import 'package:garir_khata/features/reports/domain/document_expense_codes.dart';
import 'package:garir_khata/features/reports/domain/report_models.dart';
import 'package:garir_khata/features/reports/domain/repositories/report_repository.dart';

class DriftReportRepository implements ReportRepository {
  DriftReportRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<MonthlyExpenseReport>> monthlyExpenses({
    required String vehicleId,
    required DateTime monthStart,
  }) async {
    try {
      final DateTime from = DateTime(monthStart.year, monthStart.month);
      final DateTime to = DateTime(monthStart.year, monthStart.month + 1);
      final groups = await _groupSums(vehicleId, from, to);
      final int documents = await _sumDocumentCategories(vehicleId, from, to);
      final int otherGroup = groups[ExpenseDashboardGroups.other] ?? 0;
      return Success(
        MonthlyExpenseReport(
          monthStart: from,
          fuelPaisa: groups[ExpenseDashboardGroups.fuel] ?? 0,
          maintenancePaisa: groups[ExpenseDashboardGroups.maintenance] ?? 0,
          repairPaisa: groups[ExpenseDashboardGroups.repair] ?? 0,
          documentsPaisa: documents,
          otherPaisa: otherGroup - documents < 0 ? 0 : otherGroup - documents,
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed monthly expense report', cause: error),
      );
    }
  }

  @override
  Future<Result<YearlyExpenseReport>> yearlyExpenses({
    required String vehicleId,
    required int year,
  }) async {
    try {
      final DateTime from = DateTime(year);
      final DateTime to = DateTime(year + 1);
      final List<int> monthly = List<int>.filled(12, 0);
      final rows = await _db
          .customSelect(
            'SELECT CAST(strftime(\'%m\', occurred_on, \'unixepoch\') AS INTEGER) AS month, '
            'COALESCE(SUM(amount_paisa), 0) AS total '
            'FROM expenses '
            'WHERE vehicle_id = ? AND occurred_on >= ? AND occurred_on < ? '
            'GROUP BY month',
            variables: [
              Variable.withString(vehicleId),
              Variable.withDateTime(from),
              Variable.withDateTime(to),
            ],
            readsFrom: {_db.expenses},
          )
          .get();
      for (final row in rows) {
        final int month = row.read<int>('month');
        monthly[month - 1] = row.read<int>('total');
      }
      final int annual = monthly.fold<int>(0, (s, v) => s + v);
      int highestMonth = 1;
      int highest = 0;
      for (int i = 0; i < monthly.length; i++) {
        if (monthly[i] > highest) {
          highest = monthly[i];
          highestMonth = i + 1;
        }
      }
      final categories = await _categoryTotals(vehicleId, from, to);
      return Success(
        YearlyExpenseReport(
          year: year,
          annualTotalPaisa: annual,
          monthlyAveragePaisa: annual / 12.0,
          highestMonth: highestMonth,
          highestMonthPaisa: highest,
          monthlyTotalsPaisa: monthly,
          categoryBreakdown: categories,
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed yearly expense report', cause: error),
      );
    }
  }

  @override
  Future<Result<FuelReport>> fuelReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final fuelRows = await (_db.select(_db.fuelEntries)
            ..where(
              (t) =>
                  t.vehicleId.equals(vehicleId) &
                  t.entryDateTime.isBiggerOrEqualValue(from) &
                  t.entryDateTime.isSmallerThanValue(to),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.entryDateTime)]))
          .get();
      final List<FuelEntry> entries =
          fuelRows.map(FuelMapper.toDomain).toList();
      final int totalMl =
          entries.fold<int>(0, (s, e) => s + e.quantityMl);
      final int totalSpend =
          entries.fold<int>(0, (s, e) => s + e.totalCostPaisa);
      final double liters = totalMl / 1000.0;
      final double? avgPrice =
          liters <= 0 ? null : totalSpend / liters;

      final int distance = await _distanceKmInternal(vehicleId, from, to);
      final MileageAggregate mileage = MileageCalculator.aggregate(entries);
      final CostPerKmResult fuelCostPerKm = CostPerKmCalculator.calculate(
        totalExpensePaisa: totalSpend,
        distanceKm: distance,
      );

      final monthlyCost = await _monthlyFuelCost(vehicleId, from, to);
      final priceTrend = await _monthlyFuelPrice(vehicleId, from, to);

      return Success(
        FuelReport(
          from: from,
          to: to,
          totalLiters: liters,
          totalSpendPaisa: totalSpend,
          averagePricePerLiterPaisa: avgPrice,
          distanceKm: distance,
          averageMileageKmPerLiter: mileage.averageMileageKmPerLiter,
          fuelCostPerKm: fuelCostPerKm,
          monthlyFuelCostPaisa: monthlyCost,
          priceTrendPaisaPerLiter: priceTrend,
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed fuel report', cause: error),
      );
    }
  }

  @override
  Future<Result<MileageReport>> mileageReport({
    required String vehicleId,
    DateTime? now,
  }) async {
    try {
      final DateTime anchor = now ?? DateTime.now();
      final allRows = await (_db.select(_db.fuelEntries)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.asc(t.odometer)]))
          .get();
      final List<FuelEntry> all = allRows.map(FuelMapper.toDomain).toList();
      final lifetime = MileageCalculator.aggregate(all);
      final latest = MileageCalculator.latestAvailable(all);

      final List<FuelEntry> last30 = all
          .where(
            (e) => !e.dateTime.isBefore(
              anchor.subtract(const Duration(days: 30)),
            ),
          )
          .toList();
      final List<FuelEntry> last90 = all
          .where(
            (e) => !e.dateTime.isBefore(
              anchor.subtract(const Duration(days: 90)),
            ),
          )
          .toList();

      final valid = lifetime.intervals.where((i) => i.isAvailable).toList();
      double? best;
      double? lowest;
      for (final i in valid) {
        final double? m = i.mileageKmPerLiter;
        if (m == null) {
          continue;
        }
        best = best == null ? m : (m > best ? m : best);
        lowest = lowest == null ? m : (m < lowest ? m : lowest);
      }

      return Success(
        MileageReport(
          latest: latest,
          last30Days: MileageCalculator.aggregate(last30),
          last90Days: MileageCalculator.aggregate(last90),
          lifetime: lifetime,
          bestKmPerLiter: best,
          lowestKmPerLiter: lowest,
          intervals: valid,
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed mileage report', cause: error),
      );
    }
  }

  @override
  Future<Result<CostPerKmReport>> costPerKmReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
    required CostPerKmMode mode,
    List<String> categoryCodes = const [],
  }) async {
    try {
      final int distance = await _distanceKmInternal(vehicleId, from, to);
      late final int expensePaisa;
      late final String formula;
      late final List<String> codes;

      switch (mode) {
        case CostPerKmMode.fuelOnly:
          codes = const [ExpenseCategoryCodes.fuel];
          expensePaisa = await _sumByCodes(vehicleId, from, to, codes);
          formula =
              'Fuel cost ÷ distance (km). Requires positive distance in the period.';
        case CostPerKmMode.operating:
          codes = const [];
          expensePaisa = await _sumAllExpenses(vehicleId, from, to);
          formula =
              'All operating expenses ÷ distance (km). Distance must be > 0.';
        case CostPerKmMode.custom:
          codes = categoryCodes;
          expensePaisa = codes.isEmpty
              ? 0
              : await _sumByCodes(vehicleId, from, to, codes);
          formula =
              'Selected category expenses ÷ distance (km). Pick categories and ensure distance > 0.';
      }

      return Success(
        CostPerKmReport(
          mode: mode,
          result: CostPerKmCalculator.calculate(
            totalExpensePaisa: expensePaisa,
            distanceKm: distance,
          ),
          formulaExplanation: formula,
          selectedCategoryCodes: codes,
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed cost/km report', cause: error),
      );
    }
  }

  @override
  Future<Result<MaintenanceReport>> maintenanceReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final summary = await _db
          .customSelect(
            'SELECT COUNT(*) AS cnt, COALESCE(SUM(total_cost_paisa), 0) AS total '
            'FROM service_records '
            'WHERE vehicle_id = ? AND service_date >= ? AND service_date < ?',
            variables: [
              Variable.withString(vehicleId),
              Variable.withDateTime(from),
              Variable.withDateTime(to),
            ],
            readsFrom: {_db.serviceRecords},
          )
          .getSingle();
      final int count = summary.read<int>('cnt');
      final int total = summary.read<int>('total');

      final catRows = await _db
          .customSelect(
            'SELECT si.maintenance_type AS code, si.title AS name, '
            'COUNT(*) AS cnt, COALESCE(SUM(si.cost_paisa), 0) AS total '
            'FROM service_items si '
            'INNER JOIN service_records sr ON sr.id = si.service_record_id '
            'WHERE sr.vehicle_id = ? AND sr.service_date >= ? AND sr.service_date < ? '
            'GROUP BY si.maintenance_type, si.title '
            'ORDER BY total DESC LIMIT 10',
            variables: [
              Variable.withString(vehicleId),
              Variable.withDateTime(from),
              Variable.withDateTime(to),
            ],
            readsFrom: {_db.serviceItems, _db.serviceRecords},
          )
          .get();

      return Success(
        MaintenanceReport(
          totalServiceCostPaisa: total,
          serviceCount: count,
          averageServiceCostPaisa: count == 0 ? 0 : total / count,
          commonCategories: catRows
              .map(
                (r) => CategoryAmount(
                  code: r.read<String>('code'),
                  nameEn: r.read<String>('name'),
                  amountPaisa: r.read<int>('total'),
                  count: r.read<int>('cnt'),
                ),
              )
              .toList(),
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed maintenance report', cause: error),
      );
    }
  }

  @override
  Future<Result<RepairReport>> repairReport({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
    int repeatThreshold = 2,
  }) async {
    try {
      final summary = await _db
          .customSelect(
            'SELECT COUNT(*) AS cnt, COALESCE(SUM(total_cost_paisa), 0) AS total '
            'FROM repairs '
            'WHERE vehicle_id = ? AND repair_date >= ? AND repair_date < ?',
            variables: [
              Variable.withString(vehicleId),
              Variable.withDateTime(from),
              Variable.withDateTime(to),
            ],
            readsFrom: {_db.repairs},
          )
          .getSingle();
      final int count = summary.read<int>('cnt');
      final int total = summary.read<int>('total');

      final catRows = await _db
          .customSelect(
            'SELECT category AS code, COUNT(*) AS cnt, '
            'COALESCE(SUM(total_cost_paisa), 0) AS total '
            'FROM repairs '
            'WHERE vehicle_id = ? AND repair_date >= ? AND repair_date < ? '
            'GROUP BY category ORDER BY total DESC',
            variables: [
              Variable.withString(vehicleId),
              Variable.withDateTime(from),
              Variable.withDateTime(to),
            ],
            readsFrom: {_db.repairs},
          )
          .get();

      final categories = catRows
          .map(
            (r) => CategoryAmount(
              code: r.read<String>('code'),
              nameEn: r.read<String>('code'),
              amountPaisa: r.read<int>('total'),
              count: r.read<int>('cnt'),
            ),
          )
          .toList();

      return Success(
        RepairReport(
          totalRepairCostPaisa: total,
          repairCount: count,
          topCategories: categories.take(5).toList(),
          repeatedCategories: categories
              .where((c) => c.count >= repeatThreshold)
              .toList(),
          repeatThreshold: repeatThreshold,
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed repair report', cause: error),
      );
    }
  }

  @override
  Future<Result<int>> documentFeesPaisa({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final row = await _db
          .customSelect(
            'SELECT COALESCE(SUM(fee_paisa), 0) AS total '
            'FROM vehicle_documents '
            'WHERE vehicle_id = ? AND created_at >= ? AND created_at < ?',
            variables: [
              Variable.withString(vehicleId),
              Variable.withDateTime(from),
              Variable.withDateTime(to),
            ],
            readsFrom: {_db.vehicleDocuments},
          )
          .getSingle();
      return Success(row.read<int>('total'));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed document fees sum', cause: error),
      );
    }
  }

  @override
  Future<Result<int>> distanceKm({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      return Success(await _distanceKmInternal(vehicleId, from, to));
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed distance query', cause: error),
      );
    }
  }

  Future<Map<String, int>> _groupSums(
    String vehicleId,
    DateTime from,
    DateTime to,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT c.dashboard_group AS grp, COALESCE(SUM(e.amount_paisa), 0) AS total '
          'FROM expenses e '
          'INNER JOIN expense_categories c ON c.id = e.category_id '
          'WHERE e.vehicle_id = ? AND e.occurred_on >= ? AND e.occurred_on < ? '
          'GROUP BY c.dashboard_group',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
          ],
          readsFrom: {_db.expenses, _db.expenseCategories},
        )
        .get();
    return {
      for (final row in rows)
        row.read<String>('grp'): row.read<int>('total'),
    };
  }

  Future<int> _sumDocumentCategories(
    String vehicleId,
    DateTime from,
    DateTime to,
  ) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(e.amount_paisa), 0) AS total '
          'FROM expenses e '
          'INNER JOIN expense_categories c ON c.id = e.category_id '
          'WHERE e.vehicle_id = ? AND e.occurred_on >= ? AND e.occurred_on < ? '
          'AND c.code IN (${DocumentExpenseCodes.sqlInList()})',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
          ],
          readsFrom: {_db.expenses, _db.expenseCategories},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<List<CategoryAmount>> _categoryTotals(
    String vehicleId,
    DateTime from,
    DateTime to,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT c.code AS code, c.name_en AS name, '
          'COALESCE(SUM(e.amount_paisa), 0) AS total, COUNT(*) AS cnt '
          'FROM expenses e '
          'INNER JOIN expense_categories c ON c.id = e.category_id '
          'WHERE e.vehicle_id = ? AND e.occurred_on >= ? AND e.occurred_on < ? '
          'GROUP BY c.code, c.name_en ORDER BY total DESC',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
          ],
          readsFrom: {_db.expenses, _db.expenseCategories},
        )
        .get();
    return rows
        .map(
          (r) => CategoryAmount(
            code: r.read<String>('code'),
            nameEn: r.read<String>('name'),
            amountPaisa: r.read<int>('total'),
            count: r.read<int>('cnt'),
          ),
        )
        .toList();
  }

  Future<int> _sumAllExpenses(
    String vehicleId,
    DateTime from,
    DateTime to,
  ) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(amount_paisa), 0) AS total '
          'FROM expenses WHERE vehicle_id = ? AND occurred_on >= ? AND occurred_on < ?',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
          ],
          readsFrom: {_db.expenses},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> _sumByCodes(
    String vehicleId,
    DateTime from,
    DateTime to,
    List<String> codes,
  ) async {
    if (codes.isEmpty) {
      return 0;
    }
    final placeholders = List.filled(codes.length, '?').join(',');
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(e.amount_paisa), 0) AS total '
          'FROM expenses e '
          'INNER JOIN expense_categories c ON c.id = e.category_id '
          'WHERE e.vehicle_id = ? AND e.occurred_on >= ? AND e.occurred_on < ? '
          'AND c.code IN ($placeholders)',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
            ...codes.map(Variable.withString),
          ],
          readsFrom: {_db.expenses, _db.expenseCategories},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> _distanceKmInternal(
    String vehicleId,
    DateTime from,
    DateTime to,
  ) async {
    final row = await _db
        .customSelect(
          'SELECT MIN(odometer) AS min_odo, MAX(odometer) AS max_odo FROM ('
          '  SELECT odometer FROM odometer_entries '
          '  WHERE vehicle_id = ? AND recorded_at >= ? AND recorded_at < ? '
          '    AND is_discontinuity = 0 '
          '  UNION ALL '
          '  SELECT odometer FROM fuel_entries '
          '  WHERE vehicle_id = ? AND entry_date_time >= ? AND entry_date_time < ?'
          ')',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
          ],
          readsFrom: {_db.odometerEntries, _db.fuelEntries},
        )
        .getSingle();
    final int? minOdo = row.readNullable<int>('min_odo');
    final int? maxOdo = row.readNullable<int>('max_odo');
    if (minOdo == null || maxOdo == null) {
      return 0;
    }
    final int distance = maxOdo - minOdo;
    return distance > 0 ? distance : 0;
  }

  Future<List<MonthlyPoint>> _monthlyFuelCost(
    String vehicleId,
    DateTime from,
    DateTime to,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT strftime(\'%Y-%m-01\', entry_date_time, \'unixepoch\') AS month, '
          'COALESCE(SUM(total_cost_paisa), 0) AS total '
          'FROM fuel_entries '
          'WHERE vehicle_id = ? AND entry_date_time >= ? AND entry_date_time < ? '
          'GROUP BY month ORDER BY month',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
          ],
          readsFrom: {_db.fuelEntries},
        )
        .get();
    return rows
        .map(
          (r) => MonthlyPoint(
            monthStart: DateTime.parse(r.read<String>('month')),
            value: r.read<int>('total').toDouble(),
          ),
        )
        .toList();
  }

  Future<List<MonthlyPoint>> _monthlyFuelPrice(
    String vehicleId,
    DateTime from,
    DateTime to,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT strftime(\'%Y-%m-01\', entry_date_time, \'unixepoch\') AS month, '
          'CASE WHEN SUM(quantity_ml) = 0 THEN 0 '
          'ELSE CAST(SUM(total_cost_paisa) AS REAL) / (SUM(quantity_ml) / 1000.0) END AS avg_price '
          'FROM fuel_entries '
          'WHERE vehicle_id = ? AND entry_date_time >= ? AND entry_date_time < ? '
          'GROUP BY month ORDER BY month',
          variables: [
            Variable.withString(vehicleId),
            Variable.withDateTime(from),
            Variable.withDateTime(to),
          ],
          readsFrom: {_db.fuelEntries},
        )
        .get();
    return rows
        .map(
          (r) => MonthlyPoint(
            monthStart: DateTime.parse(r.read<String>('month')),
            value: r.read<double>('avg_price'),
          ),
        )
        .toList();
  }
}
