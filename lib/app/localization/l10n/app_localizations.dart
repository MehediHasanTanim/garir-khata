import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Garir Khata'**
  String get appName;

  /// No description provided for @appNameBangla.
  ///
  /// In en, this message translates to:
  /// **'গাড়ির খাতা'**
  String get appNameBangla;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get navAdd;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonError;

  /// No description provided for @commonSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get commonSuccess;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @vehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get vehicles;

  /// No description provided for @fuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get fuel;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageBangla.
  ///
  /// In en, this message translates to:
  /// **'Bangla'**
  String get languageBangla;

  /// No description provided for @languageEnglishHint.
  ///
  /// In en, this message translates to:
  /// **'Continue in English'**
  String get languageEnglishHint;

  /// No description provided for @languageBanglaHint.
  ///
  /// In en, this message translates to:
  /// **'বাংলায় চালিয়ে যান'**
  String get languageBanglaHint;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Dashboard insights will grow as you add fuel, service, and expenses.'**
  String get homePlaceholder;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Unified vehicle history will appear here.'**
  String get historyPlaceholder;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @reportsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Cost, mileage, and trend reports will appear here.'**
  String get reportsPlaceholder;

  /// No description provided for @moreTitle.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreTitle;

  /// No description provided for @addSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get addSheetTitle;

  /// No description provided for @addFuel.
  ///
  /// In en, this message translates to:
  /// **'Add Fuel'**
  String get addFuel;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @addService.
  ///
  /// In en, this message translates to:
  /// **'Add Service'**
  String get addService;

  /// No description provided for @addRepair.
  ///
  /// In en, this message translates to:
  /// **'Add Repair'**
  String get addRepair;

  /// No description provided for @updateOdometer.
  ///
  /// In en, this message translates to:
  /// **'Update Odometer'**
  String get updateOdometer;

  /// No description provided for @addDocument.
  ///
  /// In en, this message translates to:
  /// **'Add Document'**
  String get addDocument;

  /// No description provided for @routeNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get routeNotFoundTitle;

  /// No description provided for @routeNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'This screen is not available.'**
  String get routeNotFoundMessage;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goHome;

  /// No description provided for @selectedVehicleNone.
  ///
  /// In en, this message translates to:
  /// **'No vehicle selected'**
  String get selectedVehicleNone;

  /// No description provided for @vehiclesExampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get vehiclesExampleTitle;

  /// No description provided for @vehiclesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No vehicles yet'**
  String get vehiclesEmpty;

  /// No description provided for @vehiclesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add a vehicle to start tracking fuel and expenses.'**
  String get vehiclesEmptyHint;

  /// No description provided for @preparingRecords.
  ///
  /// In en, this message translates to:
  /// **'Preparing your vehicle records…'**
  String get preparingRecords;

  /// No description provided for @mileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get mileage;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @repairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get repairs;

  /// No description provided for @chooseLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguageTitle;

  /// No description provided for @chooseLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ভাষা নির্বাচন করুন'**
  String get chooseLanguageSubtitle;

  /// No description provided for @chooseLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language for a better experience.'**
  String get chooseLanguageHint;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Garir Khata'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your vehicle records, all in one place'**
  String get welcomeHeadline;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Track fuel, mileage, service, repairs and document dates — easily and hassle-free.'**
  String get welcomeBody;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicle;

  /// No description provided for @addVehicleBasicTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicleBasicTitle;

  /// No description provided for @whatDoYouDrive.
  ///
  /// In en, this message translates to:
  /// **'What do you drive?'**
  String get whatDoYouDrive;

  /// No description provided for @vehicleDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Basic info'**
  String get vehicleDetailsSubtitle;

  /// No description provided for @currentOdometerTitle.
  ///
  /// In en, this message translates to:
  /// **'Current odometer'**
  String get currentOdometerTitle;

  /// No description provided for @currentOdometerHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the current reading shown on your vehicle.'**
  String get currentOdometerHint;

  /// No description provided for @finishSetup.
  ///
  /// In en, this message translates to:
  /// **'Finish Setup'**
  String get finishSetup;

  /// No description provided for @setupCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup complete'**
  String get setupCompleteTitle;

  /// No description provided for @setupCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re ready'**
  String get setupCompleteSubtitle;

  /// No description provided for @setupCompleteHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your vehicle is ready'**
  String get setupCompleteHeadline;

  /// No description provided for @goToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Go to Dashboard'**
  String get goToDashboard;

  /// No description provided for @myVehicles.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get myVehicles;

  /// No description provided for @vehicleProfile.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Profile'**
  String get vehicleProfile;

  /// No description provided for @editVehicle.
  ///
  /// In en, this message translates to:
  /// **'Edit Vehicle'**
  String get editVehicle;

  /// No description provided for @addNewVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add New Vehicle'**
  String get addNewVehicle;

  /// No description provided for @selectVehicle.
  ///
  /// In en, this message translates to:
  /// **'Select Vehicle'**
  String get selectVehicle;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @archiveVehicle.
  ///
  /// In en, this message translates to:
  /// **'Archive vehicle'**
  String get archiveVehicle;

  /// No description provided for @archiveVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive this vehicle?'**
  String get archiveVehicleTitle;

  /// No description provided for @archiveVehicleMessage.
  ///
  /// In en, this message translates to:
  /// **'History will remain available, but the vehicle will no longer appear in active lists.'**
  String get archiveVehicleMessage;

  /// No description provided for @overviewSection.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewSection;

  /// No description provided for @technicalSection.
  ///
  /// In en, this message translates to:
  /// **'Technical'**
  String get technicalSection;

  /// No description provided for @ownershipSection.
  ///
  /// In en, this message translates to:
  /// **'Ownership'**
  String get ownershipSection;

  /// No description provided for @registrationSection.
  ///
  /// In en, this message translates to:
  /// **'Registration & technical'**
  String get registrationSection;

  /// No description provided for @sensitiveDataNote.
  ///
  /// In en, this message translates to:
  /// **'Sensitive details are stored on your device.'**
  String get sensitiveDataNote;

  /// No description provided for @fieldNickname.
  ///
  /// In en, this message translates to:
  /// **'Vehicle nickname'**
  String get fieldNickname;

  /// No description provided for @fieldNicknameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. My Hornet'**
  String get fieldNicknameHint;

  /// No description provided for @fieldBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get fieldBrand;

  /// No description provided for @fieldModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get fieldModel;

  /// No description provided for @fieldVariant.
  ///
  /// In en, this message translates to:
  /// **'Variant'**
  String get fieldVariant;

  /// No description provided for @fieldModelYear.
  ///
  /// In en, this message translates to:
  /// **'Model year'**
  String get fieldModelYear;

  /// No description provided for @fieldFuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel type'**
  String get fieldFuelType;

  /// No description provided for @fieldColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get fieldColor;

  /// No description provided for @fieldRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration number'**
  String get fieldRegistration;

  /// No description provided for @fieldEngineCapacity.
  ///
  /// In en, this message translates to:
  /// **'Engine capacity'**
  String get fieldEngineCapacity;

  /// No description provided for @fieldEngineNumber.
  ///
  /// In en, this message translates to:
  /// **'Engine number'**
  String get fieldEngineNumber;

  /// No description provided for @fieldChassisNumber.
  ///
  /// In en, this message translates to:
  /// **'Chassis number'**
  String get fieldChassisNumber;

  /// No description provided for @fieldOwnership.
  ///
  /// In en, this message translates to:
  /// **'Ownership type'**
  String get fieldOwnership;

  /// No description provided for @fieldPurchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase price'**
  String get fieldPurchasePrice;

  /// No description provided for @fieldPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get fieldPurchaseDate;

  /// No description provided for @fieldCurrentOdometer.
  ///
  /// In en, this message translates to:
  /// **'Current odometer'**
  String get fieldCurrentOdometer;

  /// No description provided for @fieldVehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get fieldVehicleType;

  /// No description provided for @fieldBrandModel.
  ///
  /// In en, this message translates to:
  /// **'Brand / model'**
  String get fieldBrandModel;

  /// No description provided for @optionalNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get optionalNotSet;

  /// No description provided for @validationNicknameOrModel.
  ///
  /// In en, this message translates to:
  /// **'Enter a nickname or model'**
  String get validationNicknameOrModel;

  /// No description provided for @validationOdometer.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid odometer reading (0 or greater)'**
  String get validationOdometer;

  /// No description provided for @vehicleTypeMotorcycle.
  ///
  /// In en, this message translates to:
  /// **'Motorcycle'**
  String get vehicleTypeMotorcycle;

  /// No description provided for @vehicleTypeScooter.
  ///
  /// In en, this message translates to:
  /// **'Scooter'**
  String get vehicleTypeScooter;

  /// No description provided for @vehicleTypeCar.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get vehicleTypeCar;

  /// No description provided for @vehicleTypeSuv.
  ///
  /// In en, this message translates to:
  /// **'SUV'**
  String get vehicleTypeSuv;

  /// No description provided for @vehicleTypeCng.
  ///
  /// In en, this message translates to:
  /// **'CNG'**
  String get vehicleTypeCng;

  /// No description provided for @vehicleTypeMicrobus.
  ///
  /// In en, this message translates to:
  /// **'Microbus'**
  String get vehicleTypeMicrobus;

  /// No description provided for @vehicleTypePickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get vehicleTypePickup;

  /// No description provided for @vehicleTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get vehicleTypeOther;

  /// No description provided for @fuelTypePetrol.
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get fuelTypePetrol;

  /// No description provided for @fuelTypeOctane.
  ///
  /// In en, this message translates to:
  /// **'Octane'**
  String get fuelTypeOctane;

  /// No description provided for @fuelTypeDiesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get fuelTypeDiesel;

  /// No description provided for @fuelTypeCng.
  ///
  /// In en, this message translates to:
  /// **'CNG'**
  String get fuelTypeCng;

  /// No description provided for @fuelTypeLpg.
  ///
  /// In en, this message translates to:
  /// **'LPG'**
  String get fuelTypeLpg;

  /// No description provided for @fuelTypeElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get fuelTypeElectric;

  /// No description provided for @fuelTypeHybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get fuelTypeHybrid;

  /// No description provided for @fuelTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get fuelTypeOther;

  /// No description provided for @ownershipPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get ownershipPersonal;

  /// No description provided for @ownershipFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get ownershipFamily;

  /// No description provided for @ownershipCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get ownershipCompany;

  /// No description provided for @ownershipOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get ownershipOther;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
