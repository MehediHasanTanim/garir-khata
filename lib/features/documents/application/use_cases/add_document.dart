import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/formatting/precision.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/clock.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:garir_khata/features/documents/domain/document_types.dart';
import 'package:garir_khata/features/documents/domain/entities/vehicle_document.dart';
import 'package:garir_khata/features/documents/domain/repositories/document_repository.dart';
import 'package:garir_khata/features/reminders/application/reminder_engine.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/domain/repositories/reminder_repository.dart';

class DocumentInput {
  const DocumentInput({
    required this.vehicleId,
    required this.documentType,
    this.documentNumber,
    this.issueDate,
    this.expiryDate,
    this.feeMajor,
    this.issuingAuthority,
    this.providerName,
    this.policyNumber,
    this.coverageType,
    this.ownerName,
    this.note,
    this.createExpiryReminder = true,
    this.advanceDays = 30,
  });

  final String vehicleId;
  final String documentType;
  final String? documentNumber;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final double? feeMajor;
  final String? issuingAuthority;
  final String? providerName;
  final String? policyNumber;
  final String? coverageType;
  final String? ownerName;
  final String? note;
  final bool createExpiryReminder;
  final int advanceDays;
}

class AddDocument {
  const AddDocument({
    required this.documentRepository,
    required this.reminderRepository,
    required this.reminderEngine,
    required this.uuidGenerator,
    required this.clock,
  });

  final DocumentRepository documentRepository;
  final ReminderRepository reminderRepository;
  final ReminderEngine reminderEngine;
  final UuidGenerator uuidGenerator;
  final Clock clock;

  Future<Result<VehicleDocument>> call(DocumentInput input) async {
    if (input.vehicleId.trim().isEmpty) {
      return const Failure(
        ValidationError(message: 'Vehicle is required', field: 'vehicleId'),
      );
    }
    if (DocumentTypes.byCode(input.documentType) == null) {
      return const Failure(
        ValidationError(message: 'Invalid document type', field: 'type'),
      );
    }

    final DateTime now = clock.now();
    final VehicleDocument document = VehicleDocument(
      id: uuidGenerator.v4(),
      vehicleId: input.vehicleId,
      documentType: input.documentType,
      documentNumber: _trim(input.documentNumber),
      issueDate: input.issueDate,
      expiryDate: input.expiryDate,
      feePaisa: MoneyPrecision.toPaisa(input.feeMajor ?? 0),
      issuingAuthority: _trim(input.issuingAuthority),
      providerName: _trim(input.providerName),
      policyNumber: _trim(input.policyNumber),
      coverageType: _trim(input.coverageType),
      ownerName: _trim(input.ownerName),
      note: _trim(input.note),
      createdAt: now,
      updatedAt: now,
    );

    final Result<VehicleDocument> saved =
        await documentRepository.create(document);
    if (saved case Failure(:final error)) {
      return Failure(error);
    }

    if (input.createExpiryReminder && input.expiryDate != null) {
      final typeName =
          DocumentTypes.byCode(input.documentType)?.nameEn ?? 'Document';
      final Reminder reminder = Reminder(
        id: uuidGenerator.v4(),
        vehicleId: input.vehicleId,
        relatedEntityType: ReminderEntityType.document,
        relatedEntityId: document.id,
        reminderType: ReminderKind.date,
        title: '$typeName expiry',
        description: document.documentNumber,
        dueDate: input.expiryDate,
        advanceDays: input.advanceDays,
        advanceKm: 500,
        recurrenceType: ReminderRecurrence.none,
        status: ReminderStatus.upcoming,
        notificationEnabled: true,
        createdAt: now,
        updatedAt: now,
      );
      await reminderRepository.create(reminder);
      await reminderEngine.evaluateForVehicle(input.vehicleId);
    }

    return Success(document);
  }

  static String? _trim(String? value) {
    final String? trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
