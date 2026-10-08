class MaintenanceTemplate {
  const MaintenanceTemplate({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.vehicleType,
    required this.isSystem,
    required this.isActive,
    required this.sortOrder,
    required this.iconKey,
    required this.createdAt,
    this.defaultKmInterval,
    this.defaultDayInterval,
  });

  final String id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String vehicleType;
  final int? defaultKmInterval;
  final int? defaultDayInterval;
  final String iconKey;
  final bool isSystem;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;

  String localizedName(String languageCode) =>
      languageCode == 'bn' ? nameBn : nameEn;
}
