class RepairCategoryDef {
  const RepairCategoryDef({
    required this.code,
    required this.nameEn,
    required this.nameBn,
  });

  final String code;
  final String nameEn;
  final String nameBn;

  String localizedName(String languageCode) =>
      languageCode == 'bn' ? nameBn : nameEn;
}

abstract final class RepairCategories {
  static const List<RepairCategoryDef> all = [
    RepairCategoryDef(code: 'engine', nameEn: 'Engine', nameBn: 'ইঞ্জিন'),
    RepairCategoryDef(
      code: 'electrical',
      nameEn: 'Electrical',
      nameBn: 'ইলেকট্রিক্যাল',
    ),
    RepairCategoryDef(code: 'brake', nameEn: 'Brake', nameBn: 'ব্রেক'),
    RepairCategoryDef(
      code: 'suspension',
      nameEn: 'Suspension',
      nameBn: 'সাসপেনশন',
    ),
    RepairCategoryDef(
      code: 'transmission',
      nameEn: 'Transmission',
      nameBn: 'ট্রান্সমিশন',
    ),
    RepairCategoryDef(code: 'clutch', nameEn: 'Clutch', nameBn: 'ক্লাচ'),
    RepairCategoryDef(
      code: 'tyre_wheel',
      nameEn: 'Tyre/wheel',
      nameBn: 'টায়ার/চাকা',
    ),
    RepairCategoryDef(code: 'body', nameEn: 'Body', nameBn: 'বডি'),
    RepairCategoryDef(code: 'ac', nameEn: 'AC', nameBn: 'এসি'),
    RepairCategoryDef(
      code: 'fuel_system',
      nameEn: 'Fuel system',
      nameBn: 'ফুয়েল সিস্টেম',
    ),
    RepairCategoryDef(code: 'cooling', nameEn: 'Cooling', nameBn: 'কুলিং'),
    RepairCategoryDef(code: 'other', nameEn: 'Other', nameBn: 'অন্যান্য'),
  ];

  static RepairCategoryDef? byCode(String code) {
    for (final c in all) {
      if (c.code == code) {
        return c;
      }
    }
    return null;
  }
}
