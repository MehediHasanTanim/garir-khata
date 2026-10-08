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

  /// No description provided for @fuelHistory.
  ///
  /// In en, this message translates to:
  /// **'Fuel History'**
  String get fuelHistory;

  /// No description provided for @fuelDetails.
  ///
  /// In en, this message translates to:
  /// **'Fuel Details'**
  String get fuelDetails;

  /// No description provided for @editFuel.
  ///
  /// In en, this message translates to:
  /// **'Edit Fuel'**
  String get editFuel;

  /// No description provided for @fuelHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No fuel records yet'**
  String get fuelHistoryEmpty;

  /// No description provided for @fuelHistoryEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add your first refill to start tracking mileage.'**
  String get fuelHistoryEmptyHint;

  /// No description provided for @saveFuelEntry.
  ///
  /// In en, this message translates to:
  /// **'Save Fuel Entry'**
  String get saveFuelEntry;

  /// No description provided for @fullTankLabel.
  ///
  /// In en, this message translates to:
  /// **'Filled to full tank?'**
  String get fullTankLabel;

  /// No description provided for @fullTankHelper.
  ///
  /// In en, this message translates to:
  /// **'Use full-tank entries for more accurate mileage.'**
  String get fullTankHelper;

  /// No description provided for @fullTankBadge.
  ///
  /// In en, this message translates to:
  /// **'Full tank'**
  String get fullTankBadge;

  /// No description provided for @moreDetails.
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get moreDetails;

  /// No description provided for @fieldDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & time'**
  String get fieldDateTime;

  /// No description provided for @fieldLiters.
  ///
  /// In en, this message translates to:
  /// **'Fuel quantity'**
  String get fieldLiters;

  /// No description provided for @fieldTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get fieldTotalAmount;

  /// No description provided for @fieldPricePerLiter.
  ///
  /// In en, this message translates to:
  /// **'Price per liter'**
  String get fieldPricePerLiter;

  /// No description provided for @fieldStation.
  ///
  /// In en, this message translates to:
  /// **'Fuel station'**
  String get fieldStation;

  /// No description provided for @fieldLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get fieldLocation;

  /// No description provided for @fieldPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get fieldPayment;

  /// No description provided for @fieldNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get fieldNotesOptional;

  /// No description provided for @fieldNewOdometer.
  ///
  /// In en, this message translates to:
  /// **'New reading'**
  String get fieldNewOdometer;

  /// No description provided for @calculated.
  ///
  /// In en, this message translates to:
  /// **'Calculated'**
  String get calculated;

  /// No description provided for @totalFuelSpend.
  ///
  /// In en, this message translates to:
  /// **'Total fuel spend'**
  String get totalFuelSpend;

  /// No description provided for @totalLiters.
  ///
  /// In en, this message translates to:
  /// **'Total liters'**
  String get totalLiters;

  /// No description provided for @paymentCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentCash;

  /// No description provided for @paymentCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get paymentCard;

  /// No description provided for @paymentMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile banking'**
  String get paymentMobile;

  /// No description provided for @paymentOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get paymentOther;

  /// No description provided for @duplicateFuelTitle.
  ///
  /// In en, this message translates to:
  /// **'Similar entry found'**
  String get duplicateFuelTitle;

  /// No description provided for @duplicateFuelMessage.
  ///
  /// In en, this message translates to:
  /// **'A similar fuel entry already exists. Save anyway?'**
  String get duplicateFuelMessage;

  /// No description provided for @saveAnyway.
  ///
  /// In en, this message translates to:
  /// **'Save anyway'**
  String get saveAnyway;

  /// No description provided for @deleteFuelTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this fuel entry?'**
  String get deleteFuelTitle;

  /// No description provided for @deleteFuelMessage.
  ///
  /// In en, this message translates to:
  /// **'This will also update odometer and mileage calculations.'**
  String get deleteFuelMessage;

  /// No description provided for @odometerHistory.
  ///
  /// In en, this message translates to:
  /// **'Odometer History'**
  String get odometerHistory;

  /// No description provided for @odometerHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No odometer readings yet'**
  String get odometerHistoryEmpty;

  /// No description provided for @odometerLowerTitle.
  ///
  /// In en, this message translates to:
  /// **'This reading is lower than the previous reading'**
  String get odometerLowerTitle;

  /// No description provided for @odometerLowerMessage.
  ///
  /// In en, this message translates to:
  /// **'Previous: {previous} km\nEntered: {entered} km'**
  String odometerLowerMessage(String previous, String entered);

  /// No description provided for @odometerCorrectValue.
  ///
  /// In en, this message translates to:
  /// **'Correct value'**
  String get odometerCorrectValue;

  /// No description provided for @odometerWasReset.
  ///
  /// In en, this message translates to:
  /// **'Odometer was reset/replaced'**
  String get odometerWasReset;

  /// No description provided for @odometerSourceManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get odometerSourceManual;

  /// No description provided for @odometerSourceFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get odometerSourceFuel;

  /// No description provided for @odometerSourceService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get odometerSourceService;

  /// No description provided for @odometerSourceRepair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get odometerSourceRepair;

  /// No description provided for @odometerSourceOil.
  ///
  /// In en, this message translates to:
  /// **'Oil change'**
  String get odometerSourceOil;

  /// No description provided for @odometerSourceReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get odometerSourceReset;

  /// No description provided for @odometerSourceImport.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get odometerSourceImport;

  /// No description provided for @currentOdometer.
  ///
  /// In en, this message translates to:
  /// **'Current odometer'**
  String get currentOdometer;

  /// No description provided for @thisMonthExpenses.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonthExpenses;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @totalExpense.
  ///
  /// In en, this message translates to:
  /// **'Total Expense'**
  String get totalExpense;

  /// No description provided for @drivingSummary.
  ///
  /// In en, this message translates to:
  /// **'Driving Summary'**
  String get drivingSummary;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @fuelUsed.
  ///
  /// In en, this message translates to:
  /// **'Fuel used'**
  String get fuelUsed;

  /// No description provided for @costPerKm.
  ///
  /// In en, this message translates to:
  /// **'Cost/km'**
  String get costPerKm;

  /// No description provided for @notEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data'**
  String get notEnoughData;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @upcomingPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Reminders for oil, service, and documents will appear here.'**
  String get upcomingPlaceholder;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @recentActivityEmpty.
  ///
  /// In en, this message translates to:
  /// **'No recent activity yet'**
  String get recentActivityEmpty;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @dashboardEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Start tracking this vehicle'**
  String get dashboardEmptyTitle;

  /// No description provided for @dashboardEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add your first fuel entry to unlock mileage and monthly insight.'**
  String get dashboardEmptyHint;

  /// No description provided for @expenseHistory.
  ///
  /// In en, this message translates to:
  /// **'Expense History'**
  String get expenseHistory;

  /// No description provided for @expenseDetails.
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expenseDetails;

  /// No description provided for @editExpense.
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpense;

  /// No description provided for @expenseHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet'**
  String get expenseHistoryEmpty;

  /// No description provided for @expenseHistoryEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Log fuel, service, and other costs to see monthly totals.'**
  String get expenseHistoryEmptyHint;

  /// No description provided for @expenseCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get expenseCategory;

  /// No description provided for @expenseCategoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get expenseCategoryRequired;

  /// No description provided for @fieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get fieldDate;

  /// No description provided for @fieldOdometer.
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get fieldOdometer;

  /// No description provided for @fieldOdometerOptional.
  ///
  /// In en, this message translates to:
  /// **'Odometer (optional)'**
  String get fieldOdometerOptional;

  /// No description provided for @fieldExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense title'**
  String get fieldExpenseTitle;

  /// No description provided for @fieldAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get fieldAmount;

  /// No description provided for @fieldVendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get fieldVendor;

  /// No description provided for @fieldVendorOptional.
  ///
  /// In en, this message translates to:
  /// **'Vendor / service center (optional)'**
  String get fieldVendorOptional;

  /// No description provided for @fieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get fieldNotes;

  /// No description provided for @expenseLinkedFuelHint.
  ///
  /// In en, this message translates to:
  /// **'This expense is linked to a fuel entry. Edit or delete it from Fuel.'**
  String get expenseLinkedFuelHint;

  /// No description provided for @deleteExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this expense?'**
  String get deleteExpenseTitle;

  /// No description provided for @deleteExpenseMessage.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get deleteExpenseMessage;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @serviceHistory.
  ///
  /// In en, this message translates to:
  /// **'Service History'**
  String get serviceHistory;

  /// No description provided for @serviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceDetails;

  /// No description provided for @editService.
  ///
  /// In en, this message translates to:
  /// **'Edit Service'**
  String get editService;

  /// No description provided for @saveService.
  ///
  /// In en, this message translates to:
  /// **'Save Service'**
  String get saveService;

  /// No description provided for @serviceHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No service history yet'**
  String get serviceHistoryEmpty;

  /// No description provided for @serviceHistoryEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Log your first service to track next due dates.'**
  String get serviceHistoryEmptyHint;

  /// No description provided for @serviceItems.
  ///
  /// In en, this message translates to:
  /// **'Service items'**
  String get serviceItems;

  /// No description provided for @serviceItemsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No service items selected'**
  String get serviceItemsEmpty;

  /// No description provided for @addServiceItem.
  ///
  /// In en, this message translates to:
  /// **'Add service item'**
  String get addServiceItem;

  /// No description provided for @fieldWorkshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop / service center'**
  String get fieldWorkshop;

  /// No description provided for @fieldLaborCost.
  ///
  /// In en, this message translates to:
  /// **'Labor cost'**
  String get fieldLaborCost;

  /// No description provided for @fieldPartsCost.
  ///
  /// In en, this message translates to:
  /// **'Parts cost'**
  String get fieldPartsCost;

  /// No description provided for @fieldTotalCost.
  ///
  /// In en, this message translates to:
  /// **'Total cost'**
  String get fieldTotalCost;

  /// No description provided for @fieldNextDueDate.
  ///
  /// In en, this message translates to:
  /// **'Next due date'**
  String get fieldNextDueDate;

  /// No description provided for @fieldNextDueOdometer.
  ///
  /// In en, this message translates to:
  /// **'Next due odometer'**
  String get fieldNextDueOdometer;

  /// No description provided for @serviceCostUpdateWarning.
  ///
  /// In en, this message translates to:
  /// **'Updating cost will also update the linked expense.'**
  String get serviceCostUpdateWarning;

  /// No description provided for @totalServices.
  ///
  /// In en, this message translates to:
  /// **'Total services'**
  String get totalServices;

  /// No description provided for @totalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total spent'**
  String get totalSpent;

  /// No description provided for @deleteServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this service?'**
  String get deleteServiceTitle;

  /// No description provided for @deleteServiceMessage.
  ///
  /// In en, this message translates to:
  /// **'Linked expense and odometer entries will also be removed.'**
  String get deleteServiceMessage;

  /// No description provided for @addOilChange.
  ///
  /// In en, this message translates to:
  /// **'Add Oil Change'**
  String get addOilChange;

  /// No description provided for @saveOilChange.
  ///
  /// In en, this message translates to:
  /// **'Save Oil Change'**
  String get saveOilChange;

  /// No description provided for @oilHistory.
  ///
  /// In en, this message translates to:
  /// **'Oil Change History'**
  String get oilHistory;

  /// No description provided for @oilDetails.
  ///
  /// In en, this message translates to:
  /// **'Oil Change Details'**
  String get oilDetails;

  /// No description provided for @oilHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No oil change recorded'**
  String get oilHistoryEmpty;

  /// No description provided for @oilHistoryEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Record oil changes to track intervals and next due.'**
  String get oilHistoryEmptyHint;

  /// No description provided for @fieldOilBrand.
  ///
  /// In en, this message translates to:
  /// **'Oil brand'**
  String get fieldOilBrand;

  /// No description provided for @fieldOilProduct.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get fieldOilProduct;

  /// No description provided for @fieldViscosity.
  ///
  /// In en, this message translates to:
  /// **'Viscosity'**
  String get fieldViscosity;

  /// No description provided for @fieldOilQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity (L)'**
  String get fieldOilQuantity;

  /// No description provided for @oilFilterChanged.
  ///
  /// In en, this message translates to:
  /// **'Oil filter changed?'**
  String get oilFilterChanged;

  /// No description provided for @autoSuggestHint.
  ///
  /// In en, this message translates to:
  /// **'Auto from template if empty'**
  String get autoSuggestHint;

  /// No description provided for @totalOilChanges.
  ///
  /// In en, this message translates to:
  /// **'Oil changes'**
  String get totalOilChanges;

  /// No description provided for @avgOilInterval.
  ///
  /// In en, this message translates to:
  /// **'Avg interval'**
  String get avgOilInterval;

  /// No description provided for @avgOilCost.
  ///
  /// In en, this message translates to:
  /// **'Avg cost'**
  String get avgOilCost;

  /// No description provided for @latestOilBrand.
  ///
  /// In en, this message translates to:
  /// **'Latest brand'**
  String get latestOilBrand;

  /// No description provided for @deleteOilTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this oil change?'**
  String get deleteOilTitle;

  /// No description provided for @deleteOilMessage.
  ///
  /// In en, this message translates to:
  /// **'Linked service and expense records will also be removed.'**
  String get deleteOilMessage;

  /// No description provided for @noMaintenanceDue.
  ///
  /// In en, this message translates to:
  /// **'No maintenance due yet'**
  String get noMaintenanceDue;

  /// No description provided for @dueSoon.
  ///
  /// In en, this message translates to:
  /// **'Due soon'**
  String get dueSoon;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @repairHistory.
  ///
  /// In en, this message translates to:
  /// **'Repair History'**
  String get repairHistory;

  /// No description provided for @repairDetails.
  ///
  /// In en, this message translates to:
  /// **'Repair Details'**
  String get repairDetails;

  /// No description provided for @saveRepair.
  ///
  /// In en, this message translates to:
  /// **'Save Repair'**
  String get saveRepair;

  /// No description provided for @repairHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No repairs recorded yet'**
  String get repairHistoryEmpty;

  /// No description provided for @repairHistoryEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Log repairs to track parts, warranty and costs.'**
  String get repairHistoryEmptyHint;

  /// No description provided for @repairCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get repairCategory;

  /// No description provided for @repairParts.
  ///
  /// In en, this message translates to:
  /// **'Parts used'**
  String get repairParts;

  /// No description provided for @addRepairPart.
  ///
  /// In en, this message translates to:
  /// **'Add part'**
  String get addRepairPart;

  /// No description provided for @fieldProblem.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get fieldProblem;

  /// No description provided for @fieldDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis'**
  String get fieldDiagnosis;

  /// No description provided for @fieldWorkPerformed.
  ///
  /// In en, this message translates to:
  /// **'Work performed'**
  String get fieldWorkPerformed;

  /// No description provided for @fieldWarrantyEnd.
  ///
  /// In en, this message translates to:
  /// **'Warranty end date'**
  String get fieldWarrantyEnd;

  /// No description provided for @fieldFollowUpDate.
  ///
  /// In en, this message translates to:
  /// **'Follow-up date'**
  String get fieldFollowUpDate;

  /// No description provided for @fieldPartName.
  ///
  /// In en, this message translates to:
  /// **'Part name'**
  String get fieldPartName;

  /// No description provided for @fieldPartNumber.
  ///
  /// In en, this message translates to:
  /// **'Part number'**
  String get fieldPartNumber;

  /// No description provided for @fieldQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get fieldQuantity;

  /// No description provided for @fieldUnitCost.
  ///
  /// In en, this message translates to:
  /// **'Unit cost'**
  String get fieldUnitCost;

  /// No description provided for @fieldCost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get fieldCost;

  /// No description provided for @fieldInstalledDate.
  ///
  /// In en, this message translates to:
  /// **'Installed date'**
  String get fieldInstalledDate;

  /// No description provided for @fieldIntervalKm.
  ///
  /// In en, this message translates to:
  /// **'Replacement interval (km)'**
  String get fieldIntervalKm;

  /// No description provided for @fieldIntervalDays.
  ///
  /// In en, this message translates to:
  /// **'Replacement interval (days)'**
  String get fieldIntervalDays;

  /// No description provided for @fieldSpecification.
  ///
  /// In en, this message translates to:
  /// **'Specification'**
  String get fieldSpecification;

  /// No description provided for @fieldStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get fieldStatus;

  /// No description provided for @fieldTyreSize.
  ///
  /// In en, this message translates to:
  /// **'Tyre size'**
  String get fieldTyreSize;

  /// No description provided for @totalRepairs.
  ///
  /// In en, this message translates to:
  /// **'Total repairs'**
  String get totalRepairs;

  /// No description provided for @deleteRepairTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this repair?'**
  String get deleteRepairTitle;

  /// No description provided for @deleteRepairMessage.
  ///
  /// In en, this message translates to:
  /// **'Linked expense will also be removed.'**
  String get deleteRepairMessage;

  /// No description provided for @vehicleParts.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Parts'**
  String get vehicleParts;

  /// No description provided for @vehiclePartDetails.
  ///
  /// In en, this message translates to:
  /// **'Part Details'**
  String get vehiclePartDetails;

  /// No description provided for @addVehiclePart.
  ///
  /// In en, this message translates to:
  /// **'Add Part'**
  String get addVehiclePart;

  /// No description provided for @saveVehiclePart.
  ///
  /// In en, this message translates to:
  /// **'Save Part'**
  String get saveVehiclePart;

  /// No description provided for @vehiclePartsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No parts tracked yet'**
  String get vehiclePartsEmpty;

  /// No description provided for @vehiclePartsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Track standalone part replacements and intervals.'**
  String get vehiclePartsEmptyHint;

  /// No description provided for @invalidReplacementInterval.
  ///
  /// In en, this message translates to:
  /// **'Replacement interval must be positive.'**
  String get invalidReplacementInterval;

  /// No description provided for @nextDue.
  ///
  /// In en, this message translates to:
  /// **'Next due'**
  String get nextDue;

  /// No description provided for @tyresTitle.
  ///
  /// In en, this message translates to:
  /// **'Tyres'**
  String get tyresTitle;

  /// No description provided for @tyreDetails.
  ///
  /// In en, this message translates to:
  /// **'Tyre Details'**
  String get tyreDetails;

  /// No description provided for @addTyre.
  ///
  /// In en, this message translates to:
  /// **'Add Tyre'**
  String get addTyre;

  /// No description provided for @saveTyre.
  ///
  /// In en, this message translates to:
  /// **'Save Tyre'**
  String get saveTyre;

  /// No description provided for @tyresEmpty.
  ///
  /// In en, this message translates to:
  /// **'No tyres recorded'**
  String get tyresEmpty;

  /// No description provided for @tyresEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add tyres by position to track lifecycle events.'**
  String get tyresEmptyHint;

  /// No description provided for @tyrePositions.
  ///
  /// In en, this message translates to:
  /// **'Positions'**
  String get tyrePositions;

  /// No description provided for @tyrePosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get tyrePosition;

  /// No description provided for @activeTyres.
  ///
  /// In en, this message translates to:
  /// **'Active tyres'**
  String get activeTyres;

  /// No description provided for @selectTyrePosition.
  ///
  /// In en, this message translates to:
  /// **'Select a tyre position'**
  String get selectTyrePosition;

  /// No description provided for @tyreEvents.
  ///
  /// In en, this message translates to:
  /// **'Lifecycle events'**
  String get tyreEvents;

  /// No description provided for @tyreEventInstalled.
  ///
  /// In en, this message translates to:
  /// **'Installed'**
  String get tyreEventInstalled;

  /// No description provided for @tyreEventRotated.
  ///
  /// In en, this message translates to:
  /// **'Rotated'**
  String get tyreEventRotated;

  /// No description provided for @tyreEventInspected.
  ///
  /// In en, this message translates to:
  /// **'Inspected'**
  String get tyreEventInspected;

  /// No description provided for @tyreEventRepaired.
  ///
  /// In en, this message translates to:
  /// **'Repaired'**
  String get tyreEventRepaired;

  /// No description provided for @tyreEventReplaced.
  ///
  /// In en, this message translates to:
  /// **'Replaced'**
  String get tyreEventReplaced;

  /// No description provided for @tyreEventRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get tyreEventRemoved;

  /// No description provided for @tyreActionInspect.
  ///
  /// In en, this message translates to:
  /// **'Inspect'**
  String get tyreActionInspect;

  /// No description provided for @tyreActionRepair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get tyreActionRepair;

  /// No description provided for @tyreActionRotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get tyreActionRotate;

  /// No description provided for @tyreActionReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get tyreActionReplace;

  /// No description provided for @batteryTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get batteryTitle;

  /// No description provided for @batteryDetails.
  ///
  /// In en, this message translates to:
  /// **'Battery Details'**
  String get batteryDetails;

  /// No description provided for @addBattery.
  ///
  /// In en, this message translates to:
  /// **'Add Battery'**
  String get addBattery;

  /// No description provided for @replaceBattery.
  ///
  /// In en, this message translates to:
  /// **'Replace Battery'**
  String get replaceBattery;

  /// No description provided for @saveBattery.
  ///
  /// In en, this message translates to:
  /// **'Save Battery'**
  String get saveBattery;

  /// No description provided for @activeBattery.
  ///
  /// In en, this message translates to:
  /// **'Active battery'**
  String get activeBattery;

  /// No description provided for @batteryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No active battery'**
  String get batteryEmpty;

  /// No description provided for @batteryHistory.
  ///
  /// In en, this message translates to:
  /// **'Battery history'**
  String get batteryHistory;

  /// No description provided for @batteryHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No previous batteries'**
  String get batteryHistoryEmpty;

  /// No description provided for @markBatteryRemoved.
  ///
  /// In en, this message translates to:
  /// **'Mark removed'**
  String get markBatteryRemoved;

  /// No description provided for @warrantyActive.
  ///
  /// In en, this message translates to:
  /// **'Warranty active'**
  String get warrantyActive;

  /// No description provided for @warrantyExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring soon'**
  String get warrantyExpiringSoon;

  /// No description provided for @warrantyExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get warrantyExpired;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @documentDetails.
  ///
  /// In en, this message translates to:
  /// **'Document Details'**
  String get documentDetails;

  /// No description provided for @saveDocument.
  ///
  /// In en, this message translates to:
  /// **'Save Document'**
  String get saveDocument;

  /// No description provided for @documentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No documents yet'**
  String get documentsEmpty;

  /// No description provided for @documentsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Track tax token, fitness, insurance and more.'**
  String get documentsEmptyHint;

  /// No description provided for @documentType.
  ///
  /// In en, this message translates to:
  /// **'Document type'**
  String get documentType;

  /// No description provided for @fieldDocumentNumber.
  ///
  /// In en, this message translates to:
  /// **'Number / reference'**
  String get fieldDocumentNumber;

  /// No description provided for @fieldIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue date'**
  String get fieldIssueDate;

  /// No description provided for @fieldExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get fieldExpiryDate;

  /// No description provided for @fieldFee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fieldFee;

  /// No description provided for @fieldAuthority.
  ///
  /// In en, this message translates to:
  /// **'Authority / issuer'**
  String get fieldAuthority;

  /// No description provided for @fieldProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get fieldProvider;

  /// No description provided for @fieldPolicyNumber.
  ///
  /// In en, this message translates to:
  /// **'Policy number'**
  String get fieldPolicyNumber;

  /// No description provided for @fieldCoverageType.
  ///
  /// In en, this message translates to:
  /// **'Coverage type'**
  String get fieldCoverageType;

  /// No description provided for @fieldOwnerName.
  ///
  /// In en, this message translates to:
  /// **'Owner name'**
  String get fieldOwnerName;

  /// No description provided for @createExpiryReminder.
  ///
  /// In en, this message translates to:
  /// **'Create expiry reminder'**
  String get createExpiryReminder;

  /// No description provided for @remindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersTitle;

  /// No description provided for @reminderDetails.
  ///
  /// In en, this message translates to:
  /// **'Reminder Details'**
  String get reminderDetails;

  /// No description provided for @addReminder.
  ///
  /// In en, this message translates to:
  /// **'Add Reminder'**
  String get addReminder;

  /// No description provided for @editReminder.
  ///
  /// In en, this message translates to:
  /// **'Edit Reminder'**
  String get editReminder;

  /// No description provided for @saveReminder.
  ///
  /// In en, this message translates to:
  /// **'Save Reminder'**
  String get saveReminder;

  /// No description provided for @remindersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No reminders'**
  String get remindersEmpty;

  /// No description provided for @reminderFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get reminderFilterAll;

  /// No description provided for @reminderUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get reminderUpcoming;

  /// No description provided for @reminderDue.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get reminderDue;

  /// No description provided for @reminderSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get reminderSkipped;

  /// No description provided for @completedReminders.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedReminders;

  /// No description provided for @reminderType.
  ///
  /// In en, this message translates to:
  /// **'Reminder type'**
  String get reminderType;

  /// No description provided for @reminderTypeDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reminderTypeDate;

  /// No description provided for @reminderTypeOdometer.
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get reminderTypeOdometer;

  /// No description provided for @reminderTypeCombined.
  ///
  /// In en, this message translates to:
  /// **'Combined'**
  String get reminderTypeCombined;

  /// No description provided for @fieldReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get fieldReminderTitle;

  /// No description provided for @fieldDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get fieldDueDate;

  /// No description provided for @fieldDueOdometer.
  ///
  /// In en, this message translates to:
  /// **'Due odometer'**
  String get fieldDueOdometer;

  /// No description provided for @fieldAdvanceDays.
  ///
  /// In en, this message translates to:
  /// **'Advance days'**
  String get fieldAdvanceDays;

  /// No description provided for @fieldAdvanceKm.
  ///
  /// In en, this message translates to:
  /// **'Advance km'**
  String get fieldAdvanceKm;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get enableNotifications;

  /// No description provided for @snoozeReminder.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get snoozeReminder;

  /// No description provided for @snoozedUntil.
  ///
  /// In en, this message translates to:
  /// **'Snoozed until'**
  String get snoozedUntil;

  /// No description provided for @completeReminder.
  ///
  /// In en, this message translates to:
  /// **'Mark complete'**
  String get completeReminder;

  /// No description provided for @skipReminder.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipReminder;

  /// No description provided for @snoozeOneHour.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get snoozeOneHour;

  /// No description provided for @snoozeFourHours.
  ///
  /// In en, this message translates to:
  /// **'4 hours'**
  String get snoozeFourHours;

  /// No description provided for @snoozeOneDay.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get snoozeOneDay;

  /// No description provided for @snoozeThreeDays.
  ///
  /// In en, this message translates to:
  /// **'3 days'**
  String get snoozeThreeDays;

  /// No description provided for @snoozeOneWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get snoozeOneWeek;

  /// No description provided for @oil.
  ///
  /// In en, this message translates to:
  /// **'Oil'**
  String get oil;

  /// No description provided for @tyres.
  ///
  /// In en, this message translates to:
  /// **'Tyres'**
  String get tyres;

  /// No description provided for @odometer.
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get odometer;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get commonApply;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get historyEmpty;

  /// No description provided for @historyFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get historyFilters;

  /// No description provided for @reportEmpty.
  ///
  /// In en, this message translates to:
  /// **'No data for this period'**
  String get reportEmpty;

  /// No description provided for @monthlyExpenseReport.
  ///
  /// In en, this message translates to:
  /// **'Monthly Expense'**
  String get monthlyExpenseReport;

  /// No description provided for @yearlyExpenseReport.
  ///
  /// In en, this message translates to:
  /// **'Yearly Expense'**
  String get yearlyExpenseReport;

  /// No description provided for @fuelReport.
  ///
  /// In en, this message translates to:
  /// **'Fuel Report'**
  String get fuelReport;

  /// No description provided for @mileageReport.
  ///
  /// In en, this message translates to:
  /// **'Mileage Report'**
  String get mileageReport;

  /// No description provided for @costPerKmReport.
  ///
  /// In en, this message translates to:
  /// **'Cost per km'**
  String get costPerKmReport;

  /// No description provided for @maintenanceReport.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Report'**
  String get maintenanceReport;

  /// No description provided for @repairReport.
  ///
  /// In en, this message translates to:
  /// **'Repair Report'**
  String get repairReport;

  /// No description provided for @annualTotal.
  ///
  /// In en, this message translates to:
  /// **'Annual total'**
  String get annualTotal;

  /// No description provided for @monthlyAverage.
  ///
  /// In en, this message translates to:
  /// **'Monthly average'**
  String get monthlyAverage;

  /// No description provided for @highestMonth.
  ///
  /// In en, this message translates to:
  /// **'Highest month'**
  String get highestMonth;

  /// No description provided for @monthlyBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Monthly breakdown'**
  String get monthlyBreakdown;

  /// No description provided for @categoryBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Category breakdown'**
  String get categoryBreakdown;

  /// No description provided for @averagePricePerLiter.
  ///
  /// In en, this message translates to:
  /// **'Avg price/L'**
  String get averagePricePerLiter;

  /// No description provided for @averageMileage.
  ///
  /// In en, this message translates to:
  /// **'Avg mileage'**
  String get averageMileage;

  /// No description provided for @fuelCostPerKm.
  ///
  /// In en, this message translates to:
  /// **'Fuel cost/km'**
  String get fuelCostPerKm;

  /// No description provided for @monthlyFuelCost.
  ///
  /// In en, this message translates to:
  /// **'Monthly fuel cost'**
  String get monthlyFuelCost;

  /// No description provided for @fuelPriceTrend.
  ///
  /// In en, this message translates to:
  /// **'Fuel price trend'**
  String get fuelPriceTrend;

  /// No description provided for @latestMileage.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latestMileage;

  /// No description provided for @mileageLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get mileageLast30Days;

  /// No description provided for @mileageLast90Days.
  ///
  /// In en, this message translates to:
  /// **'Last 90 days'**
  String get mileageLast90Days;

  /// No description provided for @lifetimeMileage.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get lifetimeMileage;

  /// No description provided for @bestMileage.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get bestMileage;

  /// No description provided for @lowestMileage.
  ///
  /// In en, this message translates to:
  /// **'Lowest'**
  String get lowestMileage;

  /// No description provided for @mileageByRefill.
  ///
  /// In en, this message translates to:
  /// **'Mileage by refill'**
  String get mileageByRefill;

  /// No description provided for @costPerKmFuelOnly.
  ///
  /// In en, this message translates to:
  /// **'Fuel only'**
  String get costPerKmFuelOnly;

  /// No description provided for @costPerKmOperating.
  ///
  /// In en, this message translates to:
  /// **'Operating'**
  String get costPerKmOperating;

  /// No description provided for @costPerKmCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get costPerKmCustom;

  /// No description provided for @selectCategories.
  ///
  /// In en, this message translates to:
  /// **'Select categories'**
  String get selectCategories;

  /// No description provided for @howCalculated.
  ///
  /// In en, this message translates to:
  /// **'How this is calculated'**
  String get howCalculated;

  /// No description provided for @totalServiceCost.
  ///
  /// In en, this message translates to:
  /// **'Total service cost'**
  String get totalServiceCost;

  /// No description provided for @serviceCount.
  ///
  /// In en, this message translates to:
  /// **'Service count'**
  String get serviceCount;

  /// No description provided for @averageServiceCost.
  ///
  /// In en, this message translates to:
  /// **'Average service cost'**
  String get averageServiceCost;

  /// No description provided for @commonServiceCategories.
  ///
  /// In en, this message translates to:
  /// **'Common categories'**
  String get commonServiceCategories;

  /// No description provided for @totalRepairCost.
  ///
  /// In en, this message translates to:
  /// **'Total repair cost'**
  String get totalRepairCost;

  /// No description provided for @repairCount.
  ///
  /// In en, this message translates to:
  /// **'Repair count'**
  String get repairCount;

  /// No description provided for @topRepairCategories.
  ///
  /// In en, this message translates to:
  /// **'Top categories'**
  String get topRepairCategories;

  /// No description provided for @repeatedIssues.
  ///
  /// In en, this message translates to:
  /// **'Repeated issues'**
  String get repeatedIssues;

  /// No description provided for @repeatedIssuesHint.
  ///
  /// In en, this message translates to:
  /// **'Same category ≥ {count} times in this period'**
  String repeatedIssuesHint(int count);

  /// No description provided for @attachmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachmentsTitle;

  /// No description provided for @attachmentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No attachments yet'**
  String get attachmentsEmpty;

  /// No description provided for @addAttachment.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addAttachment;

  /// No description provided for @attachmentMissing.
  ///
  /// In en, this message translates to:
  /// **'File missing'**
  String get attachmentMissing;

  /// No description provided for @attachmentPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get attachmentPreview;

  /// No description provided for @attachmentRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get attachmentRename;

  /// No description provided for @attachmentPreviewUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Preview not available for this file type'**
  String get attachmentPreviewUnavailable;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose image'**
  String get chooseImage;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get chooseFile;

  /// No description provided for @exportDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportDataTitle;

  /// No description provided for @exportKind.
  ///
  /// In en, this message translates to:
  /// **'Data type'**
  String get exportKind;

  /// No description provided for @exportDateRange.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get exportDateRange;

  /// No description provided for @exportAllDates.
  ///
  /// In en, this message translates to:
  /// **'All dates'**
  String get exportAllDates;

  /// No description provided for @exportAction.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportAction;

  /// No description provided for @backupRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backupRestoreTitle;

  /// No description provided for @createBackup.
  ///
  /// In en, this message translates to:
  /// **'Create Backup'**
  String get createBackup;

  /// No description provided for @createBackupHint.
  ///
  /// In en, this message translates to:
  /// **'Save an encrypted local backup package'**
  String get createBackupHint;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get restoreBackup;

  /// No description provided for @restoreBackupHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a .gkbackup file'**
  String get restoreBackupHint;

  /// No description provided for @backupHistory.
  ///
  /// In en, this message translates to:
  /// **'Backup History'**
  String get backupHistory;

  /// No description provided for @backupHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No backups yet'**
  String get backupHistoryEmpty;

  /// No description provided for @includeAttachments.
  ///
  /// In en, this message translates to:
  /// **'Include attachments'**
  String get includeAttachments;

  /// No description provided for @backupPasswordOptional.
  ///
  /// In en, this message translates to:
  /// **'Password (optional)'**
  String get backupPasswordOptional;

  /// No description provided for @backupPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for an unencrypted backup'**
  String get backupPasswordHint;

  /// No description provided for @backupPassword.
  ///
  /// In en, this message translates to:
  /// **'Backup password'**
  String get backupPassword;

  /// No description provided for @backupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup created'**
  String get backupSuccess;

  /// No description provided for @chooseBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Choose backup file'**
  String get chooseBackupFile;

  /// No description provided for @validateBackup.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validateBackup;

  /// No description provided for @backupDate.
  ///
  /// In en, this message translates to:
  /// **'Backup date'**
  String get backupDate;

  /// No description provided for @schemaVersion.
  ///
  /// In en, this message translates to:
  /// **'Schema version'**
  String get schemaVersion;

  /// No description provided for @restoreUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand this may replace current local data'**
  String get restoreUnderstand;

  /// No description provided for @restoreAction.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreAction;

  /// No description provided for @restorePhaseReading.
  ///
  /// In en, this message translates to:
  /// **'Reading backup…'**
  String get restorePhaseReading;

  /// No description provided for @restorePhaseValidating.
  ///
  /// In en, this message translates to:
  /// **'Validating…'**
  String get restorePhaseValidating;

  /// No description provided for @restorePhaseSummary.
  ///
  /// In en, this message translates to:
  /// **'Backup summary'**
  String get restorePhaseSummary;

  /// No description provided for @restorePhaseConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm restore'**
  String get restorePhaseConfirm;

  /// No description provided for @restorePhaseRestoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring…'**
  String get restorePhaseRestoring;

  /// No description provided for @restorePhaseSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restore successful'**
  String get restorePhaseSuccess;

  /// No description provided for @restorePhaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed'**
  String get restorePhaseFailed;

  /// No description provided for @restorePhaseCorrupt.
  ///
  /// In en, this message translates to:
  /// **'Corrupt backup'**
  String get restorePhaseCorrupt;

  /// No description provided for @restorePhaseUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Unsupported backup version'**
  String get restorePhaseUnsupported;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneral;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsNotifications;

  /// No description provided for @settingsDataBackup.
  ///
  /// In en, this message translates to:
  /// **'Data & backup'**
  String get settingsDataBackup;

  /// No description provided for @settingsSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurity;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @distanceUnit.
  ///
  /// In en, this message translates to:
  /// **'Distance unit'**
  String get distanceUnit;

  /// No description provided for @fuelUnit.
  ///
  /// In en, this message translates to:
  /// **'Fuel unit'**
  String get fuelUnit;

  /// No description provided for @unitKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get unitKm;

  /// No description provided for @unitMile.
  ///
  /// In en, this message translates to:
  /// **'mile'**
  String get unitMile;

  /// No description provided for @unitLiter.
  ///
  /// In en, this message translates to:
  /// **'liter'**
  String get unitLiter;

  /// No description provided for @unitGallon.
  ///
  /// In en, this message translates to:
  /// **'gallon'**
  String get unitGallon;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'Date format'**
  String get dateFormat;

  /// No description provided for @dateFormatShort.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get dateFormatShort;

  /// No description provided for @dateFormatMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get dateFormatMedium;

  /// No description provided for @dateFormatLong.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get dateFormatLong;

  /// No description provided for @largerText.
  ///
  /// In en, this message translates to:
  /// **'Larger text'**
  String get largerText;

  /// No description provided for @largerTextHint.
  ///
  /// In en, this message translates to:
  /// **'Increase text size across the app'**
  String get largerTextHint;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'High contrast'**
  String get highContrast;

  /// No description provided for @highContrastHint.
  ///
  /// In en, this message translates to:
  /// **'Stronger contrast for readability'**
  String get highContrastHint;

  /// No description provided for @appearancePreviewSample.
  ///
  /// In en, this message translates to:
  /// **'Sample English text for readability check'**
  String get appearancePreviewSample;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are disabled for this app'**
  String get notificationPermissionDenied;

  /// No description provided for @openSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSystemSettings;

  /// No description provided for @notifMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance reminders'**
  String get notifMaintenance;

  /// No description provided for @notifDocuments.
  ///
  /// In en, this message translates to:
  /// **'Document expiry reminders'**
  String get notifDocuments;

  /// No description provided for @notifBackupReminder.
  ///
  /// In en, this message translates to:
  /// **'Backup reminder'**
  String get notifBackupReminder;

  /// No description provided for @commonDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get commonDecrease;

  /// No description provided for @commonIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get commonIncrease;

  /// No description provided for @appLockPin.
  ///
  /// In en, this message translates to:
  /// **'App lock (PIN)'**
  String get appLockPin;

  /// No description provided for @appLockEnabled.
  ///
  /// In en, this message translates to:
  /// **'PIN lock is on'**
  String get appLockEnabled;

  /// No description provided for @appLockDisabled.
  ///
  /// In en, this message translates to:
  /// **'PIN lock is off'**
  String get appLockDisabled;

  /// No description provided for @verifyPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter current PIN'**
  String get verifyPinTitle;

  /// No description provided for @changePin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get changePin;

  /// No description provided for @setPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Set PIN'**
  String get setPinTitle;

  /// No description provided for @currentPin.
  ///
  /// In en, this message translates to:
  /// **'Current PIN'**
  String get currentPin;

  /// No description provided for @newPin.
  ///
  /// In en, this message translates to:
  /// **'New PIN'**
  String get newPin;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPin;

  /// No description provided for @pinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match'**
  String get pinMismatch;

  /// No description provided for @pinTooShort.
  ///
  /// In en, this message translates to:
  /// **'PIN must be at least 4 digits'**
  String get pinTooShort;

  /// No description provided for @biometrics.
  ///
  /// In en, this message translates to:
  /// **'Biometrics'**
  String get biometrics;

  /// No description provided for @biometricsHint.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Face ID / fingerprint'**
  String get biometricsHint;

  /// No description provided for @biometricsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometrics not available on this device'**
  String get biometricsUnavailable;

  /// No description provided for @autoLock.
  ///
  /// In en, this message translates to:
  /// **'Auto-lock'**
  String get autoLock;

  /// No description provided for @autoLockImmediately.
  ///
  /// In en, this message translates to:
  /// **'Immediately'**
  String get autoLockImmediately;

  /// No description provided for @autoLockThirtySeconds.
  ///
  /// In en, this message translates to:
  /// **'After 30 seconds'**
  String get autoLockThirtySeconds;

  /// No description provided for @autoLockOneMinute.
  ///
  /// In en, this message translates to:
  /// **'After 1 minute'**
  String get autoLockOneMinute;

  /// No description provided for @autoLockFiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'After 5 minutes'**
  String get autoLockFiveMinutes;

  /// No description provided for @autoLockNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get autoLockNever;

  /// No description provided for @hideSensitivePreview.
  ///
  /// In en, this message translates to:
  /// **'Hide app preview'**
  String get hideSensitivePreview;

  /// No description provided for @hideSensitivePreviewHint.
  ///
  /// In en, this message translates to:
  /// **'Cover the screen when switching apps'**
  String get hideSensitivePreviewHint;

  /// No description provided for @lockNow.
  ///
  /// In en, this message translates to:
  /// **'Lock now'**
  String get lockNow;

  /// No description provided for @unlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get unlockTitle;

  /// No description provided for @unlockWithBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Unlock with biometrics'**
  String get unlockWithBiometrics;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'Your vehicle data stays on this device. Backups you create are encrypted when you set a password.'**
  String get privacyBody;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicyLink;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpTitle;

  /// No description provided for @helpBody.
  ///
  /// In en, this message translates to:
  /// **'Use More → Settings to change language, appearance, reminders, and security.'**
  String get helpBody;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get openSourceLicenses;

  /// No description provided for @databaseSize.
  ///
  /// In en, this message translates to:
  /// **'Database size'**
  String get databaseSize;

  /// No description provided for @attachmentsSize.
  ///
  /// In en, this message translates to:
  /// **'Attachments size'**
  String get attachmentsSize;

  /// No description provided for @clearTempFiles.
  ///
  /// In en, this message translates to:
  /// **'Clear temporary files'**
  String get clearTempFiles;

  /// No description provided for @tempFilesCleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared {count} temporary file(s)'**
  String tempFilesCleared(int count);
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
