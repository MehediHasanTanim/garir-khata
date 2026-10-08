/// Cross-sprint §17.5 — analytics must never receive PII / private content.
///
/// No analytics SDK is shipped in MVP. Use [NoOpAnalytics] (default) or wrap
/// a future SDK with [PrivacySafeAnalytics].
abstract interface class Analytics {
  void track(String event, [Map<String, Object?> properties = const {}]);
}

final class NoOpAnalytics implements Analytics {
  const NoOpAnalytics();

  @override
  void track(String event, [Map<String, Object?> properties = const {}]) {}
}

/// Property keys that must never be sent (exact match, case-insensitive).
abstract final class AnalyticsPrivacy {
  static const blockedKeys = <String>{
    'registrationnumber',
    'registration_number',
    'regno',
    'documentnumber',
    'document_number',
    'policynumber',
    'policy_number',
    'note',
    'notes',
    'privatenote',
    'private_note',
    'attachment',
    'attachmentpath',
    'attachment_path',
    'filename',
    'file_name',
    'filepath',
    'file_path',
    'pin',
    'password',
    'backuppassword',
    'backup_password',
  };

  /// Drops blocked keys and string values that look like plate / doc IDs.
  static Map<String, Object?> scrub(Map<String, Object?> raw) {
    final out = <String, Object?>{};
    for (final entry in raw.entries) {
      final key = entry.key.trim();
      final normalized = key
          .replaceAllMapped(
            RegExp(r'[A-Z]'),
            (m) => '_${m.group(0)!.toLowerCase()}',
          )
          .toLowerCase()
          .replaceAll('-', '_')
          .replaceAll(RegExp(r'^_'), '');
      if (blockedKeys.contains(normalized) ||
          blockedKeys.contains(key.toLowerCase())) {
        continue;
      }
      final value = entry.value;
      if (value is String && _looksSensitive(value)) {
        continue;
      }
      out[key] = value;
    }
    return out;
  }

  static bool _looksSensitive(String value) {
    final v = value.trim();
    if (v.isEmpty) {
      return false;
    }
    // Bangladesh-style registration fragments / long opaque IDs.
    if (RegExp(r'[A-Za-z]{2,}-\d{2}-').hasMatch(v)) {
      return true;
    }
    if (v.length >= 12 && RegExp(r'^[A-Za-z0-9._/-]+$').hasMatch(v)) {
      // Likely file path / storage key
      if (v.contains('/') || v.contains('.jpg') || v.contains('.png')) {
        return true;
      }
    }
    return false;
  }
}

/// Decorator that scrubbs properties before forwarding.
final class PrivacySafeAnalytics implements Analytics {
  const PrivacySafeAnalytics(this._inner);

  final Analytics _inner;

  @override
  void track(String event, [Map<String, Object?> properties = const {}]) {
    _inner.track(event, AnalyticsPrivacy.scrub(properties));
  }
}
