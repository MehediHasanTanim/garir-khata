enum BackupHistoryStatus { success, failed, interrupted }

class BackupManifest {
  const BackupManifest({
    required this.formatVersion,
    required this.appVersion,
    required this.createdAt,
    required this.vehicleCount,
    required this.databaseSchemaVersion,
    required this.encrypted,
    required this.attachmentCount,
    required this.databaseChecksum,
    required this.archiveChecksum,
    this.includeAttachments = true,
  });

  final int formatVersion;
  final String appVersion;
  final DateTime createdAt;
  final int vehicleCount;
  final int databaseSchemaVersion;
  final bool encrypted;
  final int attachmentCount;
  final String databaseChecksum;
  final String archiveChecksum;
  final bool includeAttachments;

  static const int currentFormatVersion = 1;
  static const int minSupportedFormatVersion = 1;

  Map<String, Object?> toJson() => {
        'formatVersion': formatVersion,
        'appVersion': appVersion,
        'createdAt': createdAt.toIso8601String(),
        'vehicleCount': vehicleCount,
        'databaseSchemaVersion': databaseSchemaVersion,
        'encrypted': encrypted,
        'attachmentCount': attachmentCount,
        'databaseChecksum': databaseChecksum,
        'archiveChecksum': archiveChecksum,
        'includeAttachments': includeAttachments,
      };

  factory BackupManifest.fromJson(Map<String, Object?> json) {
    return BackupManifest(
      formatVersion: json['formatVersion'] as int? ?? 0,
      appVersion: json['appVersion'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      vehicleCount: json['vehicleCount'] as int? ?? 0,
      databaseSchemaVersion: json['databaseSchemaVersion'] as int? ?? 0,
      encrypted: json['encrypted'] as bool? ?? false,
      attachmentCount: json['attachmentCount'] as int? ?? 0,
      databaseChecksum: json['databaseChecksum'] as String? ?? '',
      archiveChecksum: json['archiveChecksum'] as String? ?? '',
      includeAttachments: json['includeAttachments'] as bool? ?? true,
    );
  }
}

class BackupMetadata {
  const BackupMetadata({
    required this.createdAt,
    required this.vehicleNicknames,
    required this.recordCounts,
  });

  final DateTime createdAt;
  final List<String> vehicleNicknames;
  final Map<String, int> recordCounts;

  Map<String, Object?> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'vehicleNicknames': vehicleNicknames,
        'recordCounts': recordCounts,
      };

  factory BackupMetadata.fromJson(Map<String, Object?> json) {
    final counts = <String, int>{};
    final raw = json['recordCounts'];
    if (raw is Map) {
      for (final entry in raw.entries) {
        counts['${entry.key}'] = entry.value as int? ?? 0;
      }
    }
    final names = <String>[];
    final rawNames = json['vehicleNicknames'];
    if (rawNames is List) {
      names.addAll(rawNames.map((e) => '$e'));
    }
    return BackupMetadata(
      createdAt: DateTime.parse(json['createdAt'] as String),
      vehicleNicknames: names,
      recordCounts: counts,
    );
  }
}

class BackupHistoryEntry {
  const BackupHistoryEntry({
    required this.id,
    required this.createdAt,
    required this.pathOrUri,
    required this.sizeBytes,
    required this.vehicleCount,
    required this.schemaVersion,
    required this.status,
    required this.includeAttachments,
    this.errorMessage,
  });

  final String id;
  final DateTime createdAt;
  final String pathOrUri;
  final int sizeBytes;
  final int vehicleCount;
  final int schemaVersion;
  final BackupHistoryStatus status;
  final bool includeAttachments;
  final String? errorMessage;
}

class BackupCreateResult {
  const BackupCreateResult({
    required this.filePath,
    required this.sizeBytes,
    required this.manifest,
    required this.historyId,
  });

  final String filePath;
  final int sizeBytes;
  final BackupManifest manifest;
  final String historyId;
}

class RestoreSummary {
  const RestoreSummary({
    required this.manifest,
    required this.metadata,
    required this.requiresPassword,
    this.warnings = const [],
  });

  final BackupManifest manifest;
  final BackupMetadata metadata;
  final bool requiresPassword;
  final List<String> warnings;
}

enum RestorePhase {
  reading,
  validating,
  summary,
  confirm,
  restoring,
  success,
  failed,
  corrupt,
  unsupportedVersion,
}

class RestoreOutcome {
  const RestoreOutcome({
    required this.phase,
    this.summary,
    this.message,
  });

  final RestorePhase phase;
  final RestoreSummary? summary;
  final String? message;
}
