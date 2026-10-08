# Garir Khata — Technical Design Document
## Vehicle Expense & Maintenance Tracker

**Product:** Garir Khata — গাড়ির খাতা  
**Document Type:** Technical Design  
**Primary Platform:** Mobile  
**Primary Market:** Bangladesh  
**Primary Target:** Motorcycle owners  
**Secondary Target:** Car, CNG, SUV, microbus, pickup and other personal/light commercial vehicle owners  
**Languages:** বাংলা and English  
**Default Currency:** BDT (৳)  
**Default Distance Unit:** Kilometer  
**Default Fuel Unit:** Liter  

---

# 1. Purpose

This document defines the recommended technical architecture for **Garir Khata**, a vehicle expense, mileage, maintenance, document, and reminder tracking application.

The application should be:

- Fast for daily use
- Reliable without internet
- Privacy-friendly
- Easy to maintain
- Capable of supporting multiple vehicles
- Suitable for Bangladesh-specific vehicle records
- Extensible for advanced features later
- Optimized first for motorcycle owners

The recommended implementation is **offline-first and local-data-first**.

A backend is not required for the MVP.

---

# 2. Technical Goals

The technical design should support:

1. Fully functional offline operation.
2. Fast local database access.
3. Reliable mileage and cost calculations.
4. Date-based and odometer-based reminders.
5. Secure storage of vehicle documents.
6. Multiple vehicle support.
7. Bangla and English localization.
8. Export, backup, and restore.
9. Future cloud backup integration.
10. Future OCR, AI, and OBD integrations without major architectural rewrite.
11. Testable business logic.
12. Clear separation between UI, domain rules, and persistence.

---

# 3. Recommended Technology Stack

## 3.1 Mobile Framework

Recommended:

**Flutter**

Reasons:

- Single codebase for Android and iOS
- Good support for Bangla
- Strong offline/local-storage ecosystem
- Good performance
- Mature notification support
- Easy chart/report implementation
- Suitable for consumer mobile applications

Alternative:

- Native Android with Jetpack Compose
- Native iOS with SwiftUI

For a single team targeting both platforms, Flutter is the recommended default.

---

# 4. Recommended Flutter Stack

## 4.1 Core

- Flutter stable channel
- Dart
- Material 3
- Cupertino adaptations where appropriate

## 4.2 State Management

Recommended:

**Riverpod**

Use:

- `Provider`
- `Notifier`
- `AsyncNotifier`
- parameterized providers
- repository providers
- service providers

Avoid putting persistence or business logic directly inside widgets.

---

# 5. Local Database

Recommended:

**Drift + SQLite**

Reasons:

- Relational data fits the product well
- Strong querying
- Transactions
- Migration support
- Type-safe Dart APIs
- Good support for reports and aggregate queries
- Better suited than simple key-value storage for interconnected vehicle records

Alternative:

- Isar

However, Drift is preferred because the application contains many relational entities such as:

- Vehicles
- Fuel entries
- Expense entries
- Services
- Parts
- Tyres
- Batteries
- Documents
- Reminders
- Vendors
- Attachments

---

# 6. Supporting Local Storage

## 6.1 Preferences

Use a lightweight preferences layer for:

- Selected language
- Selected vehicle ID
- Theme
- First-launch state
- Notification preferences
- Dashboard settings
- Currency formatting preferences

Recommended:

- SharedPreferences or equivalent platform-backed preferences abstraction

Do not store primary business data in preferences.

## 6.2 Secure Storage

Use secure platform storage for:

- Encryption keys
- App PIN metadata
- Cloud-provider refresh tokens in future
- Backup encryption secrets

Recommended:

- Flutter secure storage abstraction
- Android Keystore
- iOS Keychain

---

# 7. Application Architecture

Recommended architecture:

**Feature-first Clean Architecture**

Layers:

1. Presentation
2. Application
3. Domain
4. Data
5. Infrastructure

High-level flow:

```text
UI
↓
Controller / Notifier
↓
Use Case
↓
Repository Interface
↓
Repository Implementation
↓
Local Data Source
↓
SQLite / File Storage / Secure Storage
```

---

# 8. Project Structure

Recommended structure:

```text
lib/
├── app/
│   ├── app.dart
│   ├── router/
│   ├── theme/
│   ├── localization/
│   └── bootstrap/
│
├── core/
│   ├── database/
│   ├── errors/
│   ├── result/
│   ├── logging/
│   ├── security/
│   ├── notifications/
│   ├── files/
│   ├── backup/
│   ├── export/
│   ├── formatting/
│   ├── validation/
│   └── utilities/
│
├── features/
│   ├── onboarding/
│   ├── vehicles/
│   ├── dashboard/
│   ├── fuel/
│   ├── odometer/
│   ├── expenses/
│   ├── maintenance/
│   ├── engine_oil/
│   ├── tyres/
│   ├── battery/
│   ├── repairs/
│   ├── parts/
│   ├── documents/
│   ├── reminders/
│   ├── vendors/
│   ├── reports/
│   ├── timeline/
│   ├── attachments/
│   ├── backup_restore/
│   └── settings/
│
└── main.dart
```

Each feature:

```text
feature/
├── data/
├── domain/
├── application/
└── presentation/
```

---

# 9. Domain Model Overview

Core domain entities:

- Vehicle
- FuelEntry
- OdometerEntry
- Expense
- ServiceRecord
- ServiceItem
- OilChange
- Tyre
- TyreEvent
- Battery
- Repair
- RepairPart
- Part
- VehicleDocument
- Reminder
- Vendor
- Attachment
- VehicleNote
- Budget
- BackupMetadata

---

# 10. Vehicle Entity

Suggested fields:

```text
Vehicle
- id
- nickname
- vehicleType
- brand
- model
- variant
- modelYear
- registrationNumber
- fuelType
- currentOdometer
- purchaseDate
- purchasePrice
- engineCapacity
- engineNumber
- chassisNumber
- color
- photoPath
- ownershipType
- isArchived
- createdAt
- updatedAt
```

Enums:

```text
VehicleType
- motorcycle
- scooter
- car
- suv
- cng
- microbus
- pickup
- other
```

```text
FuelType
- petrol
- octane
- diesel
- cng
- lpg
- electric
- hybrid
- other
```

---

# 11. Fuel Entry Entity

Suggested fields:

```text
FuelEntry
- id
- vehicleId
- dateTime
- odometer
- fuelType
- quantity
- pricePerUnit
- totalCost
- isFullTank
- fuelStationVendorId
- locationText
- paymentMethod
- note
- createdAt
- updatedAt
```

Derived values should normally not be stored unless required for reporting performance.

Examples:

- Distance since previous full tank
- Mileage
- Fuel cost/km

These should be calculated by domain services or reporting queries.

---

# 12. Odometer Entity

```text
OdometerEntry
- id
- vehicleId
- recordedAt
- odometer
- sourceType
- sourceRecordId
- note
- isManualCorrection
- createdAt
```

Possible source types:

- manual
- fuel
- service
- repair
- oilChange
- tyre
- battery
- document
- import

The latest valid odometer becomes the vehicle's current odometer.

---

# 13. Expense Entity

```text
Expense
- id
- vehicleId
- date
- category
- amount
- odometer
- vendorId
- paymentMethod
- description
- note
- sourceType
- sourceRecordId
- createdAt
- updatedAt
```

`sourceType` allows expense records generated automatically from:

- Fuel
- Service
- Repair
- Oil change
- Battery purchase
- Tyre purchase
- Document renewal

This prevents duplicate user entry.

---

# 14. Expense Categories

Recommended enum/reference table:

```text
fuel
maintenance
repair
engineOil
parts
tyre
battery
taxToken
fitness
insurance
registration
parking
toll
cleaning
accessories
fine
loanInstallment
other
```

Support custom categories using a database table:

```text
ExpenseCategory
- id
- name
- localizedLabel
- iconKey
- isSystem
- isActive
```

---

# 15. Service Record Entity

```text
ServiceRecord
- id
- vehicleId
- serviceDate
- odometer
- vendorId
- laborCost
- partsCost
- totalCost
- nextDueDate
- nextDueOdometer
- note
- createdAt
- updatedAt
```

A service may contain many service items.

---

# 16. Service Item Entity

```text
ServiceItem
- id
- serviceRecordId
- maintenanceType
- title
- cost
- quantity
- note
```

Examples:

- Engine oil
- Oil filter
- Chain adjustment
- Brake cleaning

---

# 17. Maintenance Template Entity

To support reusable service schedules:

```text
MaintenanceTemplate
- id
- vehicleType
- name
- defaultKmInterval
- defaultDayInterval
- isSystemTemplate
```

Example motorcycle templates:

```text
Engine Oil
Chain Lubrication
Chain Adjustment
Air Filter
Spark Plug
Brake Inspection
Front Tyre
Rear Tyre
Battery
General Service
```

Users may customize intervals.

---

# 18. Engine Oil Entity

```text
OilChange
- id
- vehicleId
- date
- odometer
- brand
- productName
- viscosity
- quantity
- cost
- filterChanged
- vendorId
- nextDueDate
- nextDueOdometer
- note
- createdAt
```

---

# 19. Tyre Entity

```text
Tyre
- id
- vehicleId
- position
- brand
- model
- size
- purchaseDate
- installDate
- installOdometer
- cost
- warrantyEndDate
- vendorId
- status
- note
```

Positions:

For motorcycle:

```text
front
rear
```

For car:

```text
frontLeft
frontRight
rearLeft
rearRight
spare
```

---

# 20. Tyre Event Entity

Useful for rotation/replacement history.

```text
TyreEvent
- id
- tyreId
- vehicleId
- eventType
- date
- odometer
- fromPosition
- toPosition
- note
```

Event types:

- installed
- rotated
- inspected
- repaired
- replaced
- removed

---

# 21. Battery Entity

```text
Battery
- id
- vehicleId
- brand
- model
- specification
- purchaseDate
- installDate
- installOdometer
- cost
- warrantyEndDate
- vendorId
- status
- note
```

---

# 22. Repair Entity

```text
Repair
- id
- vehicleId
- repairDate
- odometer
- category
- problemDescription
- diagnosis
- repairPerformed
- vendorId
- laborCost
- partsCost
- totalCost
- warrantyEndDate
- followUpDate
- note
- createdAt
```

---

# 23. Repair Part Entity

```text
RepairPart
- id
- repairId
- partName
- brand
- partNumber
- quantity
- unitCost
- totalCost
- warrantyEndDate
```

---

# 24. Standalone Part Entity

For replacement history independent of repair records:

```text
VehiclePart
- id
- vehicleId
- category
- name
- brand
- partNumber
- installedDate
- installedOdometer
- cost
- vendorId
- warrantyEndDate
- replacementKmInterval
- replacementDayInterval
- note
```

---

# 25. Vehicle Document Entity

```text
VehicleDocument
- id
- vehicleId
- documentType
- documentNumber
- issueDate
- expiryDate
- fee
- issuingAuthority
- providerName
- policyNumber
- note
- createdAt
- updatedAt
```

Document types:

```text
registration
taxToken
fitness
insurance
routePermit
drivingLicenseReference
ownershipTransfer
loanDocument
other
```

Attachments should be stored separately.

---

# 26. Reminder Entity

```text
Reminder
- id
- vehicleId
- relatedEntityType
- relatedEntityId
- reminderType
- title
- description
- dueDate
- dueOdometer
- advanceDays
- advanceKm
- recurrenceType
- recurrenceDays
- recurrenceKm
- status
- notificationEnabled
- lastTriggeredAt
- completedAt
- createdAt
- updatedAt
```

Reminder status:

```text
upcoming
dueSoon
due
overdue
completed
skipped
```

---

# 27. Vendor Entity

```text
Vendor
- id
- name
- type
- phone
- address
- contactPerson
- note
- isFavorite
- createdAt
- updatedAt
```

Vendor types:

- fuelStation
- workshop
- serviceCenter
- partsShop
- tyreShop
- batteryShop
- insurer
- other

---

# 28. Attachment Entity

```text
Attachment
- id
- ownerType
- ownerId
- originalFileName
- storedFileName
- mimeType
- fileSize
- relativePath
- thumbnailPath
- checksum
- createdAt
```

Owner types can include:

- fuel
- expense
- service
- repair
- document
- tyre
- battery
- vehicle
- note

---

# 29. File Storage Strategy

Business data:

- SQLite database

Attachments:

- App-private file directory

Do not store image binary data directly in SQLite.

Recommended structure:

```text
/files/
├── vehicles/
│   └── <vehicle_id>/
│       ├── documents/
│       ├── receipts/
│       ├── service/
│       ├── repairs/
│       └── photos/
└── backups/
```

Store relative file paths in the database.

---

# 30. File Naming

Use generated UUID filenames.

Example:

```text
bd7a6300-f512-4b85-aab7-ff44fa0ee451.jpg
```

Do not use sensitive document numbers as physical filenames.

---

# 31. Database Relationships

Important relationships:

```text
Vehicle 1 → N FuelEntry
Vehicle 1 → N Expense
Vehicle 1 → N OdometerEntry
Vehicle 1 → N ServiceRecord
ServiceRecord 1 → N ServiceItem

Vehicle 1 → N OilChange
Vehicle 1 → N Tyre
Vehicle 1 → N Battery
Vehicle 1 → N Repair
Repair 1 → N RepairPart

Vehicle 1 → N VehicleDocument
Vehicle 1 → N Reminder
Vehicle 1 → N VehiclePart

Vendor 1 → N ServiceRecord
Vendor 1 → N Repair
Vendor 1 → N FuelEntry

Any supported entity 1 → N Attachment
```

Use foreign keys where appropriate.

---

# 32. Database Indexes

Recommended indexes:

```text
FuelEntry(vehicleId, dateTime)
FuelEntry(vehicleId, odometer)

Expense(vehicleId, date)
Expense(vehicleId, category, date)

ServiceRecord(vehicleId, serviceDate)
ServiceRecord(vehicleId, odometer)

Repair(vehicleId, repairDate)
Repair(vehicleId, category)

VehicleDocument(vehicleId, expiryDate)

Reminder(vehicleId, dueDate)
Reminder(vehicleId, dueOdometer)
Reminder(status)

OdometerEntry(vehicleId, odometer)
```

These support dashboard and reporting queries efficiently.

---

# 33. Database Transactions

Use transactions for operations affecting multiple tables.

Example: adding fuel:

```text
BEGIN

1. Insert FuelEntry
2. Insert/update OdometerEntry
3. Update Vehicle.currentOdometer
4. Insert linked Expense
5. Recalculate relevant reminder states

COMMIT
```

If any step fails:

```text
ROLLBACK
```

---

# 34. Repository Interfaces

Recommended repositories:

```text
VehicleRepository
FuelRepository
ExpenseRepository
OdometerRepository
MaintenanceRepository
OilRepository
TyreRepository
BatteryRepository
RepairRepository
PartRepository
DocumentRepository
ReminderRepository
VendorRepository
AttachmentRepository
ReportRepository
BackupRepository
SettingsRepository
```

Domain/application layers should depend on interfaces, not SQLite directly.

---

# 35. Core Use Cases

Examples:

```text
AddVehicle
UpdateVehicle
ArchiveVehicle

AddFuelEntry
UpdateFuelEntry
DeleteFuelEntry
CalculateMileage

AddExpense
UpdateExpense

RecordService
ScheduleNextService

RecordOilChange
ScheduleOilChange

AddRepair
DetectRepeatedRepair

AddVehicleDocument
RenewVehicleDocument

CreateReminder
CompleteReminder
SnoozeReminder

GetDashboardSummary
GetMonthlyExpenseReport
GetMileageTrend
GetCostPerKm

CreateBackup
RestoreBackup
ExportVehicleHistory
```

---

# 36. Mileage Calculation Design

Mileage calculation is a core business rule and must be isolated in a domain service.

Recommended:

```text
MileageCalculator
```

## 36.1 Full Tank Calculation

Given:

- Previous full-tank odometer
- Current full-tank odometer
- Fuel added between valid interval

Formula:

```text
distance = currentOdometer - previousFullTankOdometer

mileage = distance / fuelQuantity
```

Important:

The implementation must handle partial fills between two full-tank entries.

For example:

```text
Previous Full Tank
↓
Partial Fill
↓
Partial Fill
↓
Current Full Tank
```

Mileage should use:

```text
Total fuel added since previous full tank
```

when using tank-to-tank accounting.

---

# 37. Mileage Validation

Reject calculation if:

- Previous full tank does not exist
- Distance <= 0
- Fuel quantity <= 0
- Odometer sequence is invalid

Return:

```text
MileageResult
- status
- distance
- fuelConsumed
- mileage
- reasonUnavailable
```

Possible status:

```text
available
insufficientData
invalidOdometer
invalidFuelData
```

---

# 38. Cost per Kilometer

Create:

```text
CostPerKmCalculator
```

Inputs:

- Vehicle
- Date range
- Expense categories
- Distance travelled

Formula:

```text
costPerKm = totalSelectedExpense / totalDistance
```

If distance is zero:

Do not divide.

Return unavailable state.

---

# 39. Distance Calculation

Preferred calculation:

```text
maxValidOdometer - minValidOdometer
```

within a reporting period when reliable.

Alternative:

Sum valid odometer intervals.

The reporting service must avoid counting:

- Duplicate readings
- Manual correction anomalies
- Invalid backward odometer records

---

# 40. Dashboard Aggregation Service

Create:

```text
DashboardService
```

Responsibilities:

- Current vehicle
- Current odometer
- This month's fuel cost
- Maintenance cost
- Repair cost
- Other expense
- Total cost
- Distance
- Average mileage
- Cost/km
- Upcoming maintenance
- Expiring documents
- Recent activity

Avoid running dozens of independent queries from the UI.

Use one optimized dashboard query/service.

---

# 41. Reporting Architecture

Create:

```text
ReportRepository
ReportService
```

Reports:

- Monthly expenses
- Annual expenses
- Category breakdown
- Fuel spending
- Fuel price trend
- Mileage trend
- Maintenance spending
- Repair spending
- Document costs
- Cost per km
- Ownership cost

Use SQL aggregation where practical.

Example:

```sql
GROUP BY year, month
```

Do not load all records into memory for basic totals.

---

# 42. Reminder Architecture

Two types:

## 42.1 Date-Based Reminder

Examples:

- Insurance expiry
- Tax token
- Fitness
- Scheduled service

## 42.2 Odometer-Based Reminder

Examples:

- Engine oil
- Chain maintenance
- Brake inspection
- Tyre replacement

Date reminders can trigger using local scheduled notifications.

Odometer reminders require evaluation when the user's odometer changes.

---

# 43. Reminder Evaluation Engine

Create:

```text
ReminderEngine
```

Run when:

- App launches
- Vehicle odometer changes
- Fuel entry added
- Service added
- Repair added
- Reminder updated

Pseudo logic:

```text
for each active reminder:
    evaluate date condition
    evaluate odometer condition
    derive reminder status
    update if changed
```

---

# 44. Combined Reminder Logic

Example:

```text
Engine oil:
Due at 30,000 km
OR
Due on 15 December 2026
Whichever comes first
```

Derived status is based on the earliest active threshold.

---

# 45. Local Notification Design

Recommended service:

```text
NotificationService
```

Responsibilities:

- Request permissions
- Schedule
- Update
- Cancel
- Handle notification tap
- Reschedule after device reboot if platform requires it

Notification payload:

```text
vehicleId
reminderId
relatedEntityType
relatedEntityId
```

Tapping should open the relevant reminder or maintenance screen.

---

# 46. Notification IDs

Generate deterministic numeric notification IDs from reminder IDs or maintain mapping.

Reason:

A scheduled notification must be updateable or cancelable.

---

# 47. Odometer Reminder Notifications

Because the system cannot know mileage while the app is unused without vehicle integration:

Odometer reminders should be evaluated when:

- User records fuel
- User enters odometer
- User adds service/repair
- App resumes and data changes

The UI should clearly show overdue status even if no notification was possible at the exact kilometer.

---

# 48. Background Work

Use background tasks conservatively.

Appropriate tasks:

- Backup scheduling
- Notification rescheduling
- Cleanup of orphaned temporary files

Do not depend on background execution for core business correctness.

All important reminder states must be recalculated during normal app use.

---

# 49. Backup Architecture

Recommended components:

```text
BackupService
BackupManifest
BackupEncryptionService
BackupValidator
RestoreService
```

Backup package:

```text
garir_khata_backup_YYYYMMDD_HHMM.gkbackup
```

Logical contents:

```text
manifest.json
database.sqlite
attachments/
backup_metadata.json
```

---

# 50. Backup Manifest

Example:

```json
{
  "formatVersion": 1,
  "appVersion": "1.0.0",
  "createdAt": "2026-10-06T15:00:00+06:00",
  "vehicleCount": 2,
  "databaseSchemaVersion": 4,
  "encrypted": true
}
```

---

# 51. Backup Encryption

Recommended:

- Generate random backup encryption key
- Protect using secure user secret or platform-keystore-derived mechanism
- Use authenticated encryption such as AES-GCM
- Include versioned encryption metadata

Never create a custom cryptographic algorithm.

---

# 52. Backup Restore Flow

1. User selects file.
2. Validate file type.
3. Read manifest.
4. Verify checksum/integrity.
5. Verify compatible backup version.
6. Decrypt.
7. Validate SQLite database.
8. Show summary.
9. Ask for confirmation.
10. Create emergency pre-restore backup.
11. Restore database and attachments.
12. Run migrations.
13. Rebuild reminder schedules.
14. Verify final state.

---

# 53. Import Strategy

Future support:

- CSV fuel import
- CSV expense import
- Backup import

CSV importer should have:

1. File selection
2. Encoding detection
3. Column mapping
4. Preview
5. Validation
6. Duplicate detection
7. Import transaction
8. Summary

---

# 54. Export Architecture

Create:

```text
ExportService
```

Supported outputs:

- CSV
- JSON
- PDF summary

CSV exports:

- Fuel
- Expenses
- Maintenance
- Repairs
- Documents
- Odometer

PDF:

- Vehicle summary
- Expense summary
- Maintenance/resale history

---

# 55. Data Formatting

All raw amounts should be stored numerically.

Recommended:

Use integer minor units when precision is important.

For BDT:

```text
amountMinor = paisa
```

or use a fixed decimal representation.

Avoid binary floating-point for financial totals.

Example:

```text
৳1,250.50
```

Store as:

```text
125050 paisa
```

---

# 56. Fuel Quantity Precision

Fuel quantity needs decimal precision.

Store:

```text
milliliters
```

or fixed decimal quantity.

Example:

```text
4.75 L
```

could be stored as:

```text
4750 ml
```

This avoids floating-point errors.

---

# 57. Odometer Precision

For most Bangladesh use cases:

```text
integer kilometers
```

is sufficient.

Optionally support:

```text
decimal kilometers
```

if needed later.

---

# 58. Date and Time

Store date/time in UTC when it represents an instant.

Store local date for date-only concepts.

Examples:

Instant:

- Fuel entry timestamp
- Backup creation time

Date-only:

- Tax token expiry
- Insurance expiry
- Service due date

Avoid timezone-related shifts for expiry dates.

---

# 59. Localization Architecture

Use Flutter localization tooling.

Resources:

```text
app_en.arb
app_bn.arb
```

Example:

```json
{
  "fuel": "Fuel",
  "addFuel": "Add Fuel"
}
```

Bangla:

```json
{
  "fuel": "জ্বালানি",
  "addFuel": "জ্বালানি যোগ করুন"
}
```

Never hard-code user-facing strings in widgets.

---

# 60. Locale-Sensitive Formatting

Create formatting utilities:

```text
CurrencyFormatter
DateFormatter
DistanceFormatter
FuelFormatter
OdometerFormatter
```

Bangladesh default:

```text
৳4,850
1,245 km
19.7 L
41.6 km/L
```

---

# 61. Navigation Architecture

Recommended:

Declarative routing.

Routes:

```text
/onboarding
/home
/vehicles
/vehicles/:id
/fuel
/fuel/add
/fuel/:id
/expenses
/services
/repairs
/documents
/reminders
/reports
/settings
```

Deep-link-like internal navigation should be used for notification taps.

---

# 62. Main Navigation

Bottom navigation:

```text
Home
History
Add
Reports
More
```

Use nested navigation so tab state is preserved.

---

# 63. Add Action Architecture

The central Add action opens:

```text
QuickAddSheet
```

Actions:

- Fuel
- Expense
- Service
- Repair
- Odometer
- Document

The selected vehicle should be passed automatically.

---

# 64. State Management Design

Use feature-scoped providers.

Example:

```text
selectedVehicleProvider
dashboardProvider
fuelHistoryProvider(vehicleId)
monthlyExpenseProvider(vehicleId, month)
reminderListProvider(vehicleId)
```

Mutation controllers:

```text
AddFuelController
AddServiceController
AddRepairController
BackupController
```

Avoid one global application state object.

---

# 65. Error Model

Create a shared application error hierarchy.

Examples:

```text
AppError
- ValidationError
- DatabaseError
- FileError
- BackupError
- RestoreError
- PermissionError
- NotificationError
- SecurityError
- ImportError
- ExportError
```

Map errors to localized user-friendly messages.

Never expose raw SQLite or stack trace messages in the UI.

---

# 66. Result Pattern

Use an explicit result type where appropriate:

```text
Result<T>
- success(data)
- failure(error)
```

This keeps domain/application code predictable.

---

# 67. Logging

Create:

```text
AppLogger
```

Log:

- Database migration
- Backup/restore operations
- Notification scheduling failures
- Unexpected calculation errors
- File-system failures

Never log:

- Registration documents
- Engine/chassis numbers
- Insurance policy data
- App PIN
- encryption keys

---

# 68. Crash Reporting

Optional for MVP but recommended for production.

If external crash reporting is added:

- Scrub user data
- Disable attachment content
- Do not send private documents
- Avoid vehicle identifiers in breadcrumbs

---

# 69. Security Architecture

Sensitive data includes:

- Registration number
- Engine number
- Chassis number
- Document numbers
- Insurance documents
- Registration images

Controls:

- App-private storage
- Optional biometric/PIN lock
- Secure key storage
- Encrypted backups
- No public file exposure by default
- Android secure file-provider sharing
- iOS temporary share URLs

---

# 70. App Lock

Optional:

```text
AppLockService
```

Methods:

- setPin
- verifyPin
- enableBiometric
- lock
- unlock
- shouldAutoLock

Auto-lock options:

- Immediately
- 1 minute
- 5 minutes
- 15 minutes

---

# 71. Attachment Security

Document previews should:

- Avoid saving temporary copies to public storage
- Use secure temporary directories
- Delete temporary decrypted files after use
- Hide content in recent-app previews if high-security mode is enabled

---

# 72. Permission Strategy

Possible permissions:

- Notifications
- Camera
- Photos/files
- Biometric

Request only when required.

Examples:

Camera:

Request when user taps:

`Take Photo`

Notifications:

Ask after user creates a reminder or during onboarding with clear explanation.

---

# 73. Image Processing

For receipts/documents:

- Compress large images
- Preserve readable resolution
- Generate thumbnail
- Correct orientation
- Strip unnecessary metadata where appropriate

Recommended limits:

- Thumbnail for lists
- Full-size optimized file for details

---

# 74. Search Architecture

Use SQLite full-text search only if needed.

Initial search can use indexed columns:

- Vendor name
- Description
- Note
- Part name
- Service title
- Document type

For larger data:

Use SQLite FTS.

---

# 75. Timeline Architecture

Create:

```text
TimelineItem
- timestamp
- odometer
- type
- title
- subtitle
- amount
- sourceId
```

`TimelineRepository` can compose:

- Fuel
- Service
- Repair
- Expense
- Odometer
- Document renewal

Prefer a SQL view or unified query rather than loading every table independently.

---

# 76. Dashboard Performance

Target:

- Dashboard data visible quickly from local database
- No network requirement
- Avoid blocking UI on report-heavy calculations

Use:

- SQL aggregates
- cached derived summaries where necessary
- background isolate only for expensive export/backup work

---

# 77. Performance Targets

Recommended:

- Cold launch to usable local screen: <2 seconds on modern mid-range device
- Common save operation: <300 ms perceived
- Dashboard refresh: <500 ms typical
- Fuel history pagination: 50 records/page
- Large export operations should show progress

---

# 78. Pagination

Use pagination for:

- Fuel history
- Expense history
- Repairs
- Service records
- Timeline

Suggested:

```text
pageSize = 50
```

Cursor-based or keyset pagination is preferable for timeline history.

---

# 79. Data Migration

Use versioned migrations.

Example:

```text
Schema v1
- vehicles
- fuel
- expenses

Schema v2
- maintenance
- repairs

Schema v3
- documents
- reminders

Schema v4
- attachments
```

Every release with schema changes must include:

- Upgrade migration
- Migration test
- Backup compatibility test

---

# 80. Migration Safety

Before destructive migration:

1. Create local safety backup.
2. Attempt migration.
3. Validate database.
4. Delete safety backup only after success.

Avoid destructive fallback migrations.

---

# 81. Data Deletion

Deleting vehicle:

Default behavior:

- Archive vehicle

Permanent deletion:

Require explicit confirmation.

Deletion cascade should include:

- Fuel
- Expenses
- Service
- Repairs
- Parts
- Documents
- Reminders
- Attachments

Use transaction.

---

# 82. Soft Delete

Use soft delete selectively.

Recommended for:

- Vehicles
- Important history records if undo is desired

Fields:

```text
deletedAt
```

Not required for every entity in MVP.

---

# 83. Undo Strategy

For lightweight deletion:

Show snackbar:

```text
Entry deleted — Undo
```

Delay permanent deletion or retain temporary undo metadata.

Critical documents should use confirmation before delete.

---

# 84. Duplicate Detection

Potential duplicate cases:

- Same fuel date + odometer + amount
- Imported expense already present
- Same document reference

Show warning but do not necessarily block.

Example:

> A similar fuel entry already exists.

---

# 85. Validation Rules

Create validation in domain/application layer, not only UI.

Examples:

## Vehicle

- vehicle type required
- odometer >= 0

## Fuel

- quantity > 0
- total cost >= 0
- odometer >= previous valid reading unless correction mode

## Expense

- amount >= 0
- date required

## Service

- date required
- one or more service items

## Document

- expiryDate >= issueDate if both are present

---

# 86. Odometer Correction Design

If user enters lower odometer:

Present:

```text
The odometer is lower than the previous reading.
```

Options:

- Correct value
- Record odometer reset/replacement
- Cancel

If reset:

Create an odometer discontinuity record.

Reports must understand discontinuities.

---

# 87. Data Consistency Rules

When a fuel/service/repair record with odometer is edited:

- Update linked odometer entry
- Recalculate current vehicle odometer
- Recalculate affected mileage
- Re-evaluate reminders
- Recalculate affected report range

Perform in transaction where possible.

---

# 88. Expense Synchronization

When a service record creates an expense:

```text
Expense.sourceType = service
Expense.sourceRecordId = serviceId
```

Editing service total should update the linked expense.

Deleting the service should remove or archive linked expense.

---

# 89. Testing Strategy

Required categories:

1. Unit tests
2. Repository tests
3. Database tests
4. Migration tests
5. Widget tests
6. Integration tests
7. Backup/restore tests

---

# 90. Unit Test Priority

High-priority:

- Mileage calculation
- Partial refill calculation
- Cost/km
- Reminder state
- Combined date/km reminder
- Expense totals
- Odometer validation
- Backup manifest validation

---

# 91. Mileage Test Cases

Required:

1. Two consecutive full tanks
2. Full → partial → full
3. Full → multiple partial → full
4. Missing previous full tank
5. Same odometer
6. Backward odometer
7. Zero fuel
8. Edited previous fuel entry
9. Deleted fuel entry
10. Odometer reset

---

# 92. Reminder Test Cases

Required:

- 30 days before expiry
- 7 days before expiry
- Due today
- Expired
- 500 km remaining
- 200 km remaining
- Due kilometer
- Overdue kilometer
- Date due before km
- Km due before date
- Completed reminder
- Snoozed reminder

---

# 93. Database Tests

Test:

- Foreign keys
- Cascades
- Transactions
- Report aggregates
- Pagination
- Index-backed queries
- Migration from each supported previous version

---

# 94. Backup Tests

Test:

- Create backup
- Restore backup
- Wrong password/key
- Corrupt archive
- Missing attachment
- Old backup format
- Newer unsupported format
- Interrupted restore
- Restore rollback

---

# 95. Integration Tests

Core user journeys:

## Journey 1

```text
Add motorcycle
→ Add fuel
→ Add second full tank
→ Mileage appears
```

## Journey 2

```text
Record engine oil
→ Set next due kilometer
→ Add later odometer
→ Reminder becomes due soon
```

## Journey 3

```text
Add insurance
→ Set expiry
→ Notification scheduled
```

## Journey 4

```text
Create backup
→ Clear test data
→ Restore
→ Verify history
```

---

# 96. Analytics and Telemetry

If product analytics is added later:

Track only non-sensitive events.

Examples:

- vehicle_created
- fuel_entry_created
- reminder_created
- report_opened
- backup_created

Do not include:

- Registration numbers
- Odometer values
- Document numbers
- Costs unless explicitly aggregated/anonymized
- Attachment filenames

---

# 97. Feature Flags

Optional future abstraction:

```text
FeatureFlagService
```

Possible flags:

- cloudBackup
- OCR
- AIInsights
- tripCalculator
- resaleReport
- commercialVehicle
- OBDIntegration

For MVP, simple static configuration is enough.

---

# 98. Cloud Backup Future Design

When added:

Recommended abstraction:

```text
CloudStorageProvider
```

Methods:

```text
connect()
disconnect()
uploadBackup()
listBackups()
downloadBackup()
deleteBackup()
```

Implementations:

- GoogleDriveProvider
- OneDriveProvider
- DropboxProvider

The core backup format remains provider-independent.

---

# 99. OCR Future Design

Potential OCR use cases:

- Fuel receipt amount
- Document expiry date
- Insurance policy number
- Registration text
- Odometer photo

Architecture:

```text
OcrService
↓
OcrResult
↓
User Review Screen
↓
Validated Domain Input
```

Never save OCR output automatically without user confirmation for critical fields.

---

# 100. AI Future Design

Possible AI features:

- Expense categorization
- Maintenance summary
- Repeated repair insights
- Plain-language vehicle history summary

AI must not be required for core functionality.

Recommended abstraction:

```text
VehicleInsightService
```

Data sent externally should be minimized and clearly disclosed.

---

# 101. OBD Future Integration

Future cars may support OBD/Bluetooth.

Potential data:

- Odometer
- Fuel data
- Diagnostic trouble codes
- Engine temperature

Keep this behind:

```text
VehicleTelemetryProvider
```

Do not couple domain models directly to a specific OBD library.

---

# 102. EV Future Extension

Future model additions:

```text
EnergyEntry
- kWh
- chargingCost
- chargerType
- location
```

Analytics:

```text
km/kWh
cost/km
charging cost/month
```

The existing expense and vehicle model should remain usable.

---

# 103. Build Environments

Recommended:

```text
development
staging
production
```

Even without backend, environment separation helps:

- logging
- crash reporting
- feature flags
- test data
- developer tools

---

# 104. Configuration

Keep non-secret config in build configuration.

Never embed:

- Private API secrets
- Cloud storage client secrets that should remain server-side
- Encryption master keys

Future OAuth integrations should follow provider-recommended mobile flows.

---

# 105. Developer Tools

Development-only utilities:

- Database inspector
- Seed sample vehicle
- Generate sample fuel history
- Trigger reminder simulation
- Export debug logs
- Reset local database

Must be disabled in production builds.

---

# 106. CI/CD

Recommended pipeline:

1. Static analysis
2. Formatting check
3. Unit tests
4. Database tests
5. Widget tests
6. Build Android
7. Build iOS
8. Store artifacts

Release pipeline:

- Version bump
- Changelog
- Signed build
- Store submission

---

# 107. Code Quality Rules

Recommended:

- Strong linting
- Null safety
- No ignored errors without justification
- No direct DB access from widgets
- No direct file operations from UI
- Central formatting utilities
- Centralized error mapping

---

# 108. Dependency Management

Rules:

- Prefer well-maintained packages
- Minimize dependencies
- Pin compatible versions
- Review permissions introduced by packages
- Avoid packages that unnecessarily collect data
- Keep backup/crypto implementation auditable

---

# 109. Accessibility

Technical requirements:

- Semantic labels
- Screen reader support
- Dynamic text scaling
- Minimum tap targets
- Contrast compliance
- Do not rely only on color for reminder status
- Bangla labels tested at larger text sizes

---

# 110. Offline-First Rules

All core features must work without internet:

- Vehicle management
- Fuel
- Mileage
- Expenses
- Maintenance
- Repairs
- Documents
- Reminders
- Reports
- Backup to local file

Internet-dependent future features:

- Cloud backup
- OCR cloud service
- AI
- Map/service-center discovery

The app must degrade gracefully if offline.

---

# 111. Recommended MVP Architecture Scope

The MVP should include:

```text
Flutter
Riverpod
Drift/SQLite
Secure Storage
Local Notifications
Local File Storage
CSV Export
Encrypted Local Backup
Bangla + English
```

No backend.

No login.

No account creation.

No cloud dependency.

---

# 112. MVP Modules

Phase 1 technical modules:

1. App shell
2. Localization
3. Theme
4. Database
5. Vehicle
6. Odometer
7. Fuel
8. Expenses
9. Dashboard
10. Reports

Phase 2:

11. Maintenance
12. Engine oil
13. Repairs
14. Tyres
15. Battery
16. Parts

Phase 3:

17. Documents
18. Reminders
19. Notifications
20. Vendors
21. Attachments

Phase 4:

22. Export
23. Backup/restore
24. Security
25. Production hardening

---

# 113. Recommended Initial Database Tables

```text
vehicles
fuel_entries
odometer_entries
expenses
expense_categories

service_records
service_items
maintenance_templates

oil_changes
tyres
tyre_events
batteries

repairs
repair_parts
vehicle_parts

vehicle_documents
reminders
vendors
attachments

settings
backup_history
```

---

# 114. Key Technical Risks

## Risk 1 — Incorrect Mileage Calculation

Mitigation:

- Isolate calculation logic
- Support partial refills properly
- Extensive unit tests
- Explain unavailable mileage states

## Risk 2 — Odometer Corrections

Mitigation:

- Keep odometer history
- Support reset/replacement event
- Never silently rewrite history

## Risk 3 — Reminder Reliability

Mitigation:

- Store reminder state in DB
- Recalculate on app start
- Treat notifications as delivery mechanism, not source of truth

## Risk 4 — Backup Corruption

Mitigation:

- Checksums
- Versioned manifest
- Transactional restore
- Pre-restore safety backup

## Risk 5 — Sensitive Documents

Mitigation:

- App-private files
- Encryption where appropriate
- Secure sharing
- Optional app lock

---

# 115. Non-Functional Requirements

## Performance

- Smooth scrolling
- Local queries under typical user data should feel instant
- Reports should open quickly

## Reliability

- No loss of user records after crash
- Atomic transactions
- Migration tests

## Privacy

- Local-first
- No mandatory account
- No unnecessary telemetry

## Maintainability

- Feature separation
- Repository abstractions
- Testable domain logic

## Scalability

Support:

- Several vehicles
- Tens of thousands of records
- Years of vehicle history

without architecture change.

---

# 116. Suggested Technical Decisions Summary

| Area | Recommendation |
|---|---|
| Mobile framework | Flutter |
| Language | Dart |
| State management | Riverpod |
| Database | Drift + SQLite |
| Preferences | SharedPreferences-style abstraction |
| Sensitive secrets | Secure Storage |
| Notifications | Local notification service |
| Architecture | Feature-first Clean Architecture |
| Storage | Local DB + app-private files |
| Backup | Versioned encrypted archive |
| Export | CSV + future PDF |
| Localization | ARB-based বাংলা + English |
| Networking | None required for MVP |
| Authentication | None for MVP |
| App protection | Optional PIN/Biometrics |

---

# 117. Recommended Development Philosophy

Garir Khata should remain a **simple local-first utility**, not become unnecessarily backend-heavy.

The core design should prioritize:

```text
Accurate records
+ reliable reminders
+ fast entry
+ useful calculations
+ data ownership
```

The app's value comes from building a trustworthy long-term history of a user's vehicle.

The technical architecture should therefore optimize for:

- Data correctness
- Offline reliability
- Easy backup
- Clear business rules
- Minimal operational complexity

rather than server infrastructure.

---

# 118. Final Architecture Overview

```text
┌───────────────────────────────┐
│        Flutter UI             │
│  Screens / Widgets / Forms    │
└───────────────┬───────────────┘
                │
                ▼
┌───────────────────────────────┐
│ Riverpod Application Layer    │
│ Controllers / Use Cases       │
└───────────────┬───────────────┘
                │
                ▼
┌───────────────────────────────┐
│ Domain Layer                  │
│ Entities / Rules / Calculators│
│ Reminder Engine               │
└───────────────┬───────────────┘
                │
                ▼
┌───────────────────────────────┐
│ Repository Interfaces         │
└───────────────┬───────────────┘
                │
                ▼
┌────────────────────────────────────────────┐
│ Data & Infrastructure                     │
│                                            │
│ Drift / SQLite                            │
│ App-private File Storage                  │
│ Secure Storage                            │
│ Local Notifications                      │
│ Backup / Restore                          │
│ Export                                    │
└────────────────────────────────────────────┘
```

This architecture provides a strong MVP foundation while leaving clean extension points for:

- Cloud backup
- OCR
- AI insights
- Vehicle resale reports
- Commercial vehicle features
- OBD connectivity
- EV tracking
- Shared/family vehicles

without requiring the core application to be redesigned.
