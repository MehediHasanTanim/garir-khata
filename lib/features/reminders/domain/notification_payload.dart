import 'dart:convert';

class ReminderNotificationPayload {
  const ReminderNotificationPayload({
    required this.reminderId,
    required this.vehicleId,
    this.entityType,
    this.entityId,
  });

  final String reminderId;
  final String vehicleId;
  final String? entityType;
  final String? entityId;

  Map<String, dynamic> toJson() => {
        'reminderId': reminderId,
        'vehicleId': vehicleId,
        if (entityType != null) 'entityType': entityType,
        if (entityId != null) 'entityId': entityId,
      };

  String encode() => jsonEncode(toJson());

  static ReminderNotificationPayload? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return null;
      }
      final Map<String, dynamic> map = Map<String, dynamic>.from(decoded);
      final String? reminderId = map['reminderId'] as String?;
      final String? vehicleId = map['vehicleId'] as String?;
      if (reminderId == null || vehicleId == null) {
        return null;
      }
      return ReminderNotificationPayload(
        reminderId: reminderId,
        vehicleId: vehicleId,
        entityType: map['entityType'] as String?,
        entityId: map['entityId'] as String?,
      );
    } on Object {
      return null;
    }
  }

  /// Deterministic 31-bit notification id from reminder UUID.
  static int notificationIdFor(String reminderId) {
    var hash = 0;
    for (final int unit in reminderId.codeUnits) {
      hash = 0x1fffffff & (hash + unit);
      hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
      hash ^= hash >> 6;
    }
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash ^= hash >> 11;
    hash = 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
    return hash.abs() % 2147483647;
  }

  String deepLinkPath() => '/reminders/$reminderId';
}
