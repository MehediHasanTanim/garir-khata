class ExpenseCategory {
  const ExpenseCategory({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.dashboardGroup,
    required this.iconKey,
    required this.isSystem,
    required this.sortOrder,
    required this.isArchived,
    required this.createdAt,
  });

  final String id;
  final String code;
  final String nameEn;
  final String nameBn;
  final String dashboardGroup;
  final String iconKey;
  final bool isSystem;
  final int sortOrder;
  final bool isArchived;
  final DateTime createdAt;

  String localizedName(String languageCode) =>
      languageCode == 'bn' ? nameBn : nameEn;
}
