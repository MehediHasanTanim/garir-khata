import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/database_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/history/domain/repositories/timeline_repository.dart';
import 'package:garir_khata/features/history/domain/timeline_item.dart';

class DriftTimelineRepository implements TimelineRepository {
  DriftTimelineRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<TimelinePage>> getPage({
    required String vehicleId,
    int limit = 50,
    int offset = 0,
    Set<TimelineItemType>? types,
    String? search,
  }) async {
    try {
      final Set<TimelineItemType> filter = types == null || types.isEmpty
          ? TimelineItemType.values.toSet()
          : types;
      final String? needle =
          search == null || search.trim().isEmpty ? null : search.trim();

      final List<String> unions = <String>[];
      final List<Variable<Object>> vars = <Variable<Object>>[];

      void addUnion({
        required TimelineItemType type,
        required String sql,
        required List<Variable<Object>> variables,
      }) {
        if (!filter.contains(type)) {
          return;
        }
        unions.add(sql);
        vars.addAll(variables);
      }

      addUnion(
        type: TimelineItemType.fuel,
        sql: '''
SELECT id, vehicle_id, 'fuel' AS type, entry_date_time AS occurred_at,
  COALESCE(station_name, 'Fuel') AS title,
  printf('%.1f L', quantity_ml / 1000.0) AS subtitle,
  total_cost_paisa AS amount_paisa, odometer,
  '/fuel/' || id AS route_path,
  lower(COALESCE(station_name,'') || ' ' || COALESCE(note,'')) AS search_text
FROM fuel_entries WHERE vehicle_id = ?''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.expense,
        sql: '''
SELECT e.id, e.vehicle_id, 'expense' AS type, e.occurred_on AS occurred_at,
  COALESCE(c.name_en, COALESCE(e.description, 'Expense')) AS title,
  e.vendor_name AS subtitle, e.amount_paisa, e.odometer,
  '/expenses/' || e.id AS route_path,
  lower(COALESCE(c.name_en,'') || ' ' || COALESCE(e.description,'') || ' ' ||
    COALESCE(e.vendor_name,'') || ' ' || COALESCE(e.note,'')) AS search_text
FROM expenses e
LEFT JOIN expense_categories c ON c.id = e.category_id
WHERE e.vehicle_id = ? AND e.source_type = 'manual' ''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.service,
        sql: '''
SELECT id, vehicle_id, 'service' AS type, service_date AS occurred_at,
  'Service' AS title, vendor_name AS subtitle, total_cost_paisa AS amount_paisa,
  odometer, '/services/' || id AS route_path,
  lower(COALESCE(vendor_name,'') || ' ' || COALESCE(note,'')) AS search_text
FROM service_records WHERE vehicle_id = ?''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.repair,
        sql: '''
SELECT id, vehicle_id, 'repair' AS type, repair_date AS occurred_at,
  problem_description AS title, category AS subtitle,
  total_cost_paisa AS amount_paisa, odometer,
  '/repairs/' || id AS route_path,
  lower(problem_description || ' ' || category || ' ' || COALESCE(note,'')) AS search_text
FROM repairs WHERE vehicle_id = ?''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.oil,
        sql: '''
SELECT id, vehicle_id, 'oil' AS type, occurred_on AS occurred_at,
  COALESCE(brand, 'Oil change') AS title,
  COALESCE(product_name, viscosity) AS subtitle,
  cost_paisa AS amount_paisa, odometer,
  '/oil/' || id AS route_path,
  lower(COALESCE(brand,'') || ' ' || COALESCE(product_name,'') || ' ' ||
    COALESCE(note,'')) AS search_text
FROM oil_changes WHERE vehicle_id = ?''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.tyre,
        sql: '''
SELECT id, vehicle_id, 'tyre' AS type, install_date AS occurred_at,
  COALESCE(brand, 'Tyre') AS title, position AS subtitle,
  cost_paisa AS amount_paisa, install_odometer AS odometer,
  '/tyres/' || id AS route_path,
  lower(COALESCE(brand,'') || ' ' || COALESCE(model,'') || ' ' ||
    COALESCE(note,'')) AS search_text
FROM tyres WHERE vehicle_id = ?''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.battery,
        sql: '''
SELECT id, vehicle_id, 'battery' AS type, install_date AS occurred_at,
  COALESCE(brand, 'Battery') AS title, model AS subtitle,
  cost_paisa AS amount_paisa, install_odometer AS odometer,
  '/batteries/' || id AS route_path,
  lower(COALESCE(brand,'') || ' ' || COALESCE(model,'') || ' ' ||
    COALESCE(note,'')) AS search_text
FROM batteries WHERE vehicle_id = ?''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.document,
        sql: '''
SELECT id, vehicle_id, 'document' AS type,
  COALESCE(issue_date, created_at) AS occurred_at,
  document_type AS title, document_number AS subtitle,
  fee_paisa AS amount_paisa, NULL AS odometer,
  '/documents/' || id AS route_path,
  lower(document_type || ' ' || COALESCE(document_number,'') || ' ' ||
    COALESCE(note,'')) AS search_text
FROM vehicle_documents WHERE vehicle_id = ?''',
        variables: [Variable.withString(vehicleId)],
      );

      addUnion(
        type: TimelineItemType.odometer,
        sql: '''
SELECT id, vehicle_id, 'odometer' AS type, recorded_at AS occurred_at,
  'Odometer' AS title, printf('%d km', odometer) AS subtitle,
  NULL AS amount_paisa, odometer,
  '/odometer/history' AS route_path,
  lower(COALESCE(note,'')) AS search_text
FROM odometer_entries
WHERE vehicle_id = ? AND source_type = 'manual' ''',
        variables: [Variable.withString(vehicleId)],
      );

      if (unions.isEmpty) {
        return const Success(
          TimelinePage(items: [], hasMore: false, nextOffset: 0),
        );
      }

      final String searchClause =
          needle == null ? '' : 'WHERE search_text LIKE ? ';
      if (needle != null) {
        vars.add(Variable.withString('%${needle.toLowerCase()}%'));
      }

      final String sql = '''
SELECT * FROM (
  ${unions.join('\nUNION ALL\n')}
) $searchClause
ORDER BY occurred_at DESC
LIMIT ? OFFSET ?''';
      vars
        ..add(Variable.withInt(limit + 1))
        ..add(Variable.withInt(offset));

      final rows = await _db
          .customSelect(
            sql,
            variables: vars,
            readsFrom: {
              _db.fuelEntries,
              _db.expenses,
              _db.expenseCategories,
              _db.serviceRecords,
              _db.repairs,
              _db.oilChanges,
              _db.tyres,
              _db.batteries,
              _db.vehicleDocuments,
              _db.odometerEntries,
            },
          )
          .get();

      final bool hasMore = rows.length > limit;
      final List<QueryRow> pageRows =
          hasMore ? rows.sublist(0, limit) : rows;
      final items = pageRows.map(_mapRow).toList();
      return Success(
        TimelinePage(
          items: items,
          hasMore: hasMore,
          nextOffset: offset + items.length,
        ),
      );
    } on Object catch (error) {
      return Failure(
        DatabaseError(message: 'Failed to load timeline', cause: error),
      );
    }
  }

  TimelineItem _mapRow(QueryRow row) {
    final String typeRaw = row.read<String>('type');
    return TimelineItem(
      id: row.read<String>('id'),
      vehicleId: row.read<String>('vehicle_id'),
      type: TimelineItem.parseType(typeRaw) ?? TimelineItemType.expense,
      occurredAt: row.read<DateTime>('occurred_at'),
      title: row.read<String>('title'),
      subtitle: row.readNullable<String>('subtitle'),
      amountPaisa: row.readNullable<int>('amount_paisa'),
      odometer: row.readNullable<int>('odometer'),
      routePath: row.read<String>('route_path'),
      searchText: row.readNullable<String>('search_text'),
    );
  }
}
