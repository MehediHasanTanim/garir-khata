import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/errors/file_error.dart';
import 'package:garir_khata/core/files/file_storage_service.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

enum CsvExportKind { fuel, expenses, service, repairs, odometer, documents }

class CsvExportRequest {
  const CsvExportRequest({
    required this.kind,
    required this.vehicleId,
    this.from,
    this.to,
  });

  final CsvExportKind kind;
  final String vehicleId;
  final DateTime? from;
  final DateTime? to;
}

class CsvExportResult {
  const CsvExportResult({
    required this.filePath,
    required this.rowCount,
    required this.bytes,
  });

  final String filePath;
  final int rowCount;
  final List<int> bytes;
}

/// CSV exporter with UTF-8 BOM for Bangla-safe Excel import.
class CsvExportService {
  CsvExportService({
    required this.db,
    required this.storage,
    required this.uuidGenerator,
    required this.clock,
  });

  final AppDatabase db;
  final FileStorageService storage;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  static const List<int> utf8Bom = [0xEF, 0xBB, 0xBF];

  Future<Result<CsvExportResult>> export(CsvExportRequest request) async {
    try {
      await storage.ensureReady();
      final (headers, rows) = await _rowsFor(request);
      final buffer = StringBuffer();
      buffer.writeln(headers.map(_escape).join(','));
      for (final row in rows) {
        buffer.writeln(row.map(_escape).join(','));
      }
      final content = utf8.encode(buffer.toString());
      final bytes = <int>[...utf8Bom, ...content];

      final stamp = DateFormat('yyyyMMdd_HHmm').format(clock.now());
      final name = '${request.kind.name}_$stamp.csv';
      final out = File(p.join(storage.tempRoot.path, name));
      await out.parent.create(recursive: true);
      await out.writeAsBytes(bytes, flush: true);

      return Success(
        CsvExportResult(
          filePath: out.path,
          rowCount: rows.length,
          bytes: bytes,
        ),
      );
    } on Object catch (error) {
      return Failure(
        FileError(message: 'CSV export failed', cause: error),
      );
    }
  }

  Future<(List<String>, List<List<String>>)> _rowsFor(
    CsvExportRequest request,
  ) async {
    final from = request.from;
    final to = request.to;
    switch (request.kind) {
      case CsvExportKind.fuel:
        final q = db.select(db.fuelEntries)
          ..where((t) => t.vehicleId.equals(request.vehicleId))
          ..orderBy([(t) => OrderingTerm.asc(t.entryDateTime)]);
        if (from != null) {
          q.where((t) => t.entryDateTime.isBiggerOrEqualValue(from));
        }
        if (to != null) {
          q.where((t) => t.entryDateTime.isSmallerThanValue(to));
        }
        final rows = await q.get();
        return (
          [
            'id',
            'date_time',
            'odometer',
            'fuel_type',
            'quantity_liters',
            'total_cost',
            'station',
            'full_tank',
            'note',
          ],
          rows
              .map(
                (r) => [
                  r.id,
                  r.entryDateTime.toIso8601String(),
                  '${r.odometer}',
                  r.fuelType,
                  (r.quantityMl / 1000.0).toStringAsFixed(3),
                  (r.totalCostPaisa / 100.0).toStringAsFixed(2),
                  r.stationName ?? '',
                  r.isFullTank ? '1' : '0',
                  r.note ?? '',
                ],
              )
              .toList(),
        );
      case CsvExportKind.expenses:
        final q = db.select(db.expenses)
          ..where((t) => t.vehicleId.equals(request.vehicleId))
          ..orderBy([(t) => OrderingTerm.asc(t.occurredOn)]);
        if (from != null) {
          q.where((t) => t.occurredOn.isBiggerOrEqualValue(from));
        }
        if (to != null) {
          q.where((t) => t.occurredOn.isSmallerThanValue(to));
        }
        final rows = await q.get();
        return (
          [
            'id',
            'occurred_on',
            'category_id',
            'amount',
            'vendor',
            'description',
            'note',
          ],
          rows
              .map(
                (r) => [
                  r.id,
                  r.occurredOn.toIso8601String(),
                  r.categoryId,
                  (r.amountPaisa / 100.0).toStringAsFixed(2),
                  r.vendorName ?? '',
                  r.description ?? '',
                  r.note ?? '',
                ],
              )
              .toList(),
        );
      case CsvExportKind.service:
        final q = db.select(db.serviceRecords)
          ..where((t) => t.vehicleId.equals(request.vehicleId))
          ..orderBy([(t) => OrderingTerm.asc(t.serviceDate)]);
        if (from != null) {
          q.where((t) => t.serviceDate.isBiggerOrEqualValue(from));
        }
        if (to != null) {
          q.where((t) => t.serviceDate.isSmallerThanValue(to));
        }
        final rows = await q.get();
        return (
          ['id', 'service_date', 'odometer', 'vendor', 'total_cost', 'note'],
          rows
              .map(
                (r) => [
                  r.id,
                  r.serviceDate.toIso8601String(),
                  '${r.odometer}',
                  r.vendorName ?? '',
                  (r.totalCostPaisa / 100.0).toStringAsFixed(2),
                  r.note ?? '',
                ],
              )
              .toList(),
        );
      case CsvExportKind.repairs:
        final q = db.select(db.repairs)
          ..where((t) => t.vehicleId.equals(request.vehicleId))
          ..orderBy([(t) => OrderingTerm.asc(t.repairDate)]);
        if (from != null) {
          q.where((t) => t.repairDate.isBiggerOrEqualValue(from));
        }
        if (to != null) {
          q.where((t) => t.repairDate.isSmallerThanValue(to));
        }
        final rows = await q.get();
        return (
          [
            'id',
            'repair_date',
            'odometer',
            'category',
            'problem',
            'total_cost',
            'note',
          ],
          rows
              .map(
                (r) => [
                  r.id,
                  r.repairDate.toIso8601String(),
                  '${r.odometer}',
                  r.category,
                  r.problemDescription,
                  (r.totalCostPaisa / 100.0).toStringAsFixed(2),
                  r.note ?? '',
                ],
              )
              .toList(),
        );
      case CsvExportKind.odometer:
        final q = db.select(db.odometerEntries)
          ..where((t) => t.vehicleId.equals(request.vehicleId))
          ..orderBy([(t) => OrderingTerm.asc(t.recordedAt)]);
        if (from != null) {
          q.where((t) => t.recordedAt.isBiggerOrEqualValue(from));
        }
        if (to != null) {
          q.where((t) => t.recordedAt.isSmallerThanValue(to));
        }
        final rows = await q.get();
        return (
          ['id', 'recorded_at', 'odometer', 'source_type', 'note'],
          rows
              .map(
                (r) => [
                  r.id,
                  r.recordedAt.toIso8601String(),
                  '${r.odometer}',
                  r.sourceType,
                  r.note ?? '',
                ],
              )
              .toList(),
        );
      case CsvExportKind.documents:
        final q = db.select(db.vehicleDocuments)
          ..where((t) => t.vehicleId.equals(request.vehicleId))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
        final rows = await q.get();
        final filtered = rows.where((r) {
          if (from != null && r.createdAt.isBefore(from)) {
            return false;
          }
          if (to != null && !r.createdAt.isBefore(to)) {
            return false;
          }
          return true;
        });
        return (
          [
            'id',
            'document_type',
            'document_number',
            'issue_date',
            'expiry_date',
            'fee',
            'note',
          ],
          filtered
              .map(
                (r) => [
                  r.id,
                  r.documentType,
                  r.documentNumber ?? '',
                  r.issueDate?.toIso8601String() ?? '',
                  r.expiryDate?.toIso8601String() ?? '',
                  (r.feePaisa / 100.0).toStringAsFixed(2),
                  r.note ?? '',
                ],
              )
              .toList(),
        );
    }
  }

  String _escape(String value) {
    final needsQuotes =
        value.contains(',') || value.contains('"') || value.contains('\n');
    final escaped = value.replaceAll('"', '""');
    return needsQuotes ? '"$escaped"' : escaped;
  }
}
