import 'package:drift/drift.dart';

import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/features/documents/domain/entities/vehicle_document.dart';

abstract final class DocumentMapper {
  static VehicleDocument toDomain(VehicleDocumentRow row) {
    return VehicleDocument(
      id: row.id,
      vehicleId: row.vehicleId,
      documentType: row.documentType,
      documentNumber: row.documentNumber,
      issueDate: row.issueDate,
      expiryDate: row.expiryDate,
      feePaisa: row.feePaisa,
      issuingAuthority: row.issuingAuthority,
      providerName: row.providerName,
      policyNumber: row.policyNumber,
      coverageType: row.coverageType,
      ownerName: row.ownerName,
      note: row.note,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static VehicleDocumentsCompanion toCompanion(VehicleDocument doc) {
    return VehicleDocumentsCompanion(
      id: Value(doc.id),
      vehicleId: Value(doc.vehicleId),
      documentType: Value(doc.documentType),
      documentNumber: Value(doc.documentNumber),
      issueDate: Value(doc.issueDate),
      expiryDate: Value(doc.expiryDate),
      feePaisa: Value(doc.feePaisa),
      issuingAuthority: Value(doc.issuingAuthority),
      providerName: Value(doc.providerName),
      policyNumber: Value(doc.policyNumber),
      coverageType: Value(doc.coverageType),
      ownerName: Value(doc.ownerName),
      note: Value(doc.note),
      createdAt: Value(doc.createdAt),
      updatedAt: Value(doc.updatedAt),
    );
  }
}
