class DocumentTypeDef {
  const DocumentTypeDef({
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

abstract final class DocumentTypes {
  static const registration = 'registration';
  static const taxToken = 'tax_token';
  static const fitness = 'fitness';
  static const insurance = 'insurance';
  static const routePermit = 'route_permit';
  static const drivingLicense = 'driving_license';
  static const ownershipTransfer = 'ownership_transfer';
  static const loan = 'loan';
  static const other = 'other';

  static const List<DocumentTypeDef> all = [
    DocumentTypeDef(
      code: registration,
      nameEn: 'Registration',
      nameBn: 'রেজিস্ট্রেশন',
    ),
    DocumentTypeDef(
      code: taxToken,
      nameEn: 'Tax token',
      nameBn: 'ট্যাক্স টোকেন',
    ),
    DocumentTypeDef(
      code: fitness,
      nameEn: 'Fitness',
      nameBn: 'ফিটনেস',
    ),
    DocumentTypeDef(
      code: insurance,
      nameEn: 'Insurance',
      nameBn: 'ইনস্যুরেন্স',
    ),
    DocumentTypeDef(
      code: routePermit,
      nameEn: 'Route permit',
      nameBn: 'রুট পারমিট',
    ),
    DocumentTypeDef(
      code: drivingLicense,
      nameEn: 'Driving license',
      nameBn: 'ড্রাইভিং লাইসেন্স',
    ),
    DocumentTypeDef(
      code: ownershipTransfer,
      nameEn: 'Ownership transfer',
      nameBn: 'মালিকানা হস্তান্তর',
    ),
    DocumentTypeDef(
      code: loan,
      nameEn: 'Loan document',
      nameBn: 'ঋণের কাগজ',
    ),
    DocumentTypeDef(code: other, nameEn: 'Other', nameBn: 'অন্যান্য'),
  ];

  static DocumentTypeDef? byCode(String code) {
    for (final t in all) {
      if (t.code == code) {
        return t;
      }
    }
    return null;
  }

  static bool showsPolicyFields(String code) => code == insurance;

  static bool showsOwnerField(String code) => code == registration;
}
