# Garir Khata — Sprint-wise Technical Implementation Plan
## Vehicle Expense & Maintenance Tracker

**Product:** Garir Khata — গাড়ির খাতা  
**Document Type:** Sprint-wise Technical Implementation Plan  
**Primary Platform:** Flutter Mobile App  
**Architecture:** Feature-first Clean Architecture  
**State Management:** Riverpod  
**Database:** Drift + SQLite  
**Primary Languages:** বাংলা + English  
**MVP Strategy:** Offline-first, no backend, no mandatory account  
**Primary Market:** Bangladesh  
**Primary Initial Target:** Motorcycle owners  

---

# 1. Purpose

This document converts the Garir Khata feature specification and technical design into a practical, sprint-wise engineering execution plan.

It is designed to help a development team:

- Build the MVP incrementally
- Keep business rules testable
- Deliver usable software early
- Reduce architecture rework
- Prioritize motorcycle-focused workflows
- Validate mileage, cost, reminders, and backup correctness
- Prepare the product for Android and iOS release

---

# 2. Recommended Sprint Model

Recommended sprint duration:

**2 weeks per sprint**

Recommended MVP duration:

**10 sprints**

Indicative duration:

**20 weeks**

Optional stabilization/release sprint:

**Sprint 11**

This plan assumes a small team such as:

- 1–2 Flutter developers
- 1 QA engineer
- 1 UI/UX designer
- 1 technical lead/PM shared across the project

A single developer can follow the same plan with a longer calendar timeline.

---

# 3. Delivery Principles

Each sprint should aim to deliver:

1. A coherent vertical slice
2. Working UI
3. Domain logic
4. Database persistence
5. Validation
6. Unit tests
7. Repository/database tests
8. Basic QA scenarios
9. No critical regressions from previous sprint

Avoid building all database layers first and postponing UI until later.

Each sprint should produce demonstrable user value.

---

# 4. Definition of Done

A task is considered complete only when:

- Code is merged
- Static analysis passes
- Unit tests pass
- Database/repository tests pass where applicable
- UI handles loading/error/empty states
- Localization strings exist in English and Bangla
- Validation is implemented
- No known blocker-level bug remains
- Acceptance criteria are verified
- Relevant technical documentation is updated

---

# 5. High-Level Sprint Roadmap

| Sprint | Focus |
|---|---|
| Sprint 1 | Foundation, architecture, localization, DB setup |
| Sprint 2 | Vehicle management + onboarding |
| Sprint 3 | Odometer + fuel tracking |
| Sprint 4 | Mileage + dashboard + expense tracking |
| Sprint 5 | Maintenance + engine oil |
| Sprint 6 | Repairs + parts + tyre + battery |
| Sprint 7 | Documents + reminders + notifications |
| Sprint 8 | Reports + analytics + cost/km |
| Sprint 9 | Attachments + export + backup/restore |
| Sprint 10 | Security + settings + UX hardening |
| Sprint 11 | Release hardening, store readiness, final QA |

---

# 6. Sprint 1 — Project Foundation & Core Infrastructure

## Sprint Goal

Establish a production-ready Flutter codebase, architecture, local persistence layer, localization, navigation, theming, error handling, and developer tooling.

## Deliverables

- Flutter project initialized
- Clean architecture structure
- Riverpod configured
- Drift database configured
- Localization configured
- App theme configured
- Navigation shell in place
- Logging/error framework in place
- CI baseline established

---

## 6.1 Project Bootstrap

Tasks:

- Create Flutter application
- Configure Android application ID
- Configure iOS bundle identifier
- Set minimum Android version
- Set minimum iOS version
- Configure app display name
- Configure environment files
- Add lint rules
- Add formatting rules
- Configure dependency management
- Add `.gitignore`
- Add README
- Add project architecture notes

Acceptance criteria:

- App builds on Android
- App builds on iOS
- Static analysis passes
- Clean initial project structure exists

---

## 6.2 Architecture Setup

Create:

```text
lib/
├── app/
├── core/
├── features/
└── main.dart
```

Add feature module conventions:

```text
feature/
├── data/
├── domain/
├── application/
└── presentation/
```

Tasks:

- Define repository interface pattern
- Define use-case conventions
- Define controller/notifier conventions
- Define domain entity conventions
- Define mapping rules between DB and domain models

Acceptance criteria:

- Example feature compiles using architecture layers
- UI has no direct DB access

---

## 6.3 Riverpod Setup

Tasks:

- Add Riverpod
- Configure root `ProviderScope`
- Add core service providers
- Define repository provider pattern
- Add selected vehicle placeholder provider
- Add application-level settings provider

Acceptance criteria:

- Providers are injectable and testable
- No singleton service anti-pattern

---

## 6.4 Navigation Setup

Recommended bottom navigation shell:

- Home
- History
- Add
- Reports
- More

Tasks:

- Configure declarative router
- Add nested navigation
- Add placeholder routes
- Add route error screen
- Add navigation observer if needed

Acceptance criteria:

- Switching tabs preserves state
- Deep navigation works
- Unknown route handled safely

---

## 6.5 Theme System

Tasks:

- Define light theme
- Define dark theme
- Define semantic color roles
- Define typography
- Define spacing scale
- Define component defaults
- Validate Bangla typography

Components:

- Buttons
- Text fields
- Cards
- Chips
- Dialogs
- Bottom sheets
- App bars
- Snackbars

---

## 6.6 Localization

Tasks:

- Add ARB localization
- Create `app_en.arb`
- Create `app_bn.arb`
- Add language switching
- Add localized date/number helpers
- Add Bangla font fallback validation

Initial strings:

- Navigation
- Common buttons
- Loading
- Error
- Save
- Delete
- Cancel
- Vehicle
- Fuel
- Expense
- Service
- Reports

Acceptance criteria:

- Entire shell switches between English and Bangla
- No hard-coded strings in new screens

---

## 6.7 Database Foundation

Tasks:

- Add Drift
- Configure SQLite
- Create DB singleton/provider
- Define schema version
- Add migration scaffold
- Enable foreign keys
- Add database test helpers

Initial tables:

- settings
- vehicles
- odometer_entries

Acceptance criteria:

- Database initializes
- Basic insert/read/update works
- Migration test runs successfully

---

## 6.8 Shared Core Utilities

Create:

- `Result<T>`
- `AppError`
- `ValidationError`
- `DatabaseError`
- `FileError`
- `PermissionError`

Utilities:

- Date formatter
- Currency formatter
- Distance formatter
- Odometer formatter
- UUID generator
- Clock abstraction
- Logger

---

## 6.9 CI Pipeline

Tasks:

- Configure CI workflow
- Run formatter check
- Run static analysis
- Run unit tests
- Build Android debug artifact

Optional:

- iOS build on macOS runner

---

## 6.10 Sprint 1 Testing

Tests:

- App startup
- Language switching
- Theme switching
- Navigation
- Database initialization
- Migration baseline
- Result/error mapping

---

# 7. Sprint 2 — Onboarding & Vehicle Management

## Sprint Goal

Allow a first-time user to complete onboarding and create/manage one or more vehicles.

## Deliverables

- Splash
- Language selection
- Welcome flow
- Vehicle type selection
- Add vehicle
- Vehicle list
- Vehicle details
- Edit vehicle
- Archive vehicle
- Vehicle switcher

---

## 7.1 Vehicle Database Model

Implement fields:

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

Add indexes where needed.

---

## 7.2 Vehicle Domain Layer

Create:

- `Vehicle`
- `VehicleType`
- `FuelType`
- `OwnershipType`

Use cases:

- AddVehicle
- UpdateVehicle
- ArchiveVehicle
- GetVehicle
- GetActiveVehicles
- SetSelectedVehicle

---

## 7.3 Vehicle Repository

Tasks:

- Create repository interface
- Create Drift implementation
- Add entity mapping
- Add repository tests

Acceptance criteria:

- Active vehicles returned correctly
- Archived vehicles excluded by default

---

## 7.4 Onboarding Flow

Screens:

1. Splash
2. Language Selection
3. Welcome
4. Vehicle Type
5. Vehicle Details
6. Current Odometer
7. Setup Complete

Tasks:

- Add skip/continue behavior
- Persist onboarding completed flag
- Persist selected language
- Add validation
- Handle back navigation safely

---

## 7.5 Vehicle Form

Required fields:

- vehicle type
- nickname or model
- fuel type
- current odometer

Optional:

- brand
- model
- registration number
- purchase details
- engine/chassis numbers
- photo

Validation:

- Odometer >= 0
- Year within reasonable range
- Purchase price non-negative

---

## 7.6 Vehicle List

Each card:

- Nickname
- Brand/model
- Registration
- Odometer
- Vehicle type icon
- Current selection indicator

Actions:

- Select
- Edit
- Archive

---

## 7.7 Vehicle Profile

Sections:

- Overview
- Technical details
- Purchase info
- Registration information
- Current odometer

Future sections may be placeholders:

- Documents
- Service history
- Expenses

---

## 7.8 Selected Vehicle State

Create:

```text
selectedVehicleProvider
```

Behavior:

- Restore last selected vehicle
- Fallback to first active vehicle
- Update on archive if selected vehicle removed

---

## 7.9 Sprint 2 Testing

Unit:

- Vehicle validation
- Vehicle type mapping

Repository:

- Create/update/archive
- Active vehicle filtering

Widget:

- Vehicle form
- Onboarding navigation
- Vehicle switcher

Integration:

- First launch → create motorcycle → reach dashboard shell

---

# 8. Sprint 3 — Odometer & Fuel Tracking

## Sprint Goal

Deliver the application's most frequent user workflow: recording fuel and odometer readings.

## Deliverables

- Odometer management
- Add fuel
- Fuel history
- Fuel details
- Fuel edit/delete
- Automatic expense creation foundation
- Fuel validation

---

## 8.1 Odometer Schema

Implement:

```text
odometer_entries
```

Fields:

- id
- vehicleId
- recordedAt
- odometer
- sourceType
- sourceRecordId
- note
- isManualCorrection
- createdAt

Indexes:

- vehicleId + recordedAt
- vehicleId + odometer

---

## 8.2 Odometer Service

Create:

- AddOdometerReading
- GetLatestOdometer
- ValidateOdometer
- RecalculateCurrentVehicleOdometer

Rules:

- New reading should normally be >= previous
- Lower reading triggers correction workflow
- Source entity recorded

---

## 8.3 Odometer Correction Flow

UI:

- Warning dialog
- Correct value
- Odometer reset/replacement
- Cancel

Technical:

- Add discontinuity marker strategy
- Ensure reports can identify invalid continuous range

---

## 8.4 Fuel Schema

Implement:

```text
fuel_entries
```

Fields:

- id
- vehicleId
- dateTime
- odometer
- fuelType
- quantity
- pricePerUnit
- totalCost
- isFullTank
- vendorId nullable
- locationText
- paymentMethod
- note
- createdAt
- updatedAt

Use fixed precision.

Recommended:

- quantity in milliliters
- money in paisa

---

## 8.5 Fuel Domain Model

Create:

- FuelEntry
- FuelInput
- PaymentMethod
- FuelValidationResult

Use cases:

- AddFuelEntry
- UpdateFuelEntry
- DeleteFuelEntry
- GetFuelHistory
- GetFuelEntry

---

## 8.6 Add Fuel Transaction

Single transaction:

1. Validate input
2. Insert fuel
3. Insert/update odometer entry
4. Update current vehicle odometer
5. Create linked expense placeholder if expense table exists
6. Commit

During this sprint, expense linkage may use infrastructure placeholder for Sprint 4.

---

## 8.7 Add Fuel UI

Fields:

- Date/time
- Odometer
- Fuel type
- Liters
- Price/liter
- Total amount
- Full tank
- Location
- Payment method
- Note

Behavior:

- Enter liters + unit price → calculate total
- Enter liters + total → calculate unit price
- Remember last fuel type
- Default current date/time
- Default selected vehicle

---

## 8.8 Fuel History

List:

- Date
- Odometer
- Liters
- Total
- Full tank badge

Features:

- Pagination
- Vehicle filter
- Pull to refresh/local refresh

---

## 8.9 Fuel Details

Display:

- All input values
- Calculated unit price
- Linked odometer
- Note

Actions:

- Edit
- Delete

Delete rules:

- Confirm
- Recalculate vehicle odometer
- Prepare mileage recalculation hook

---

## 8.10 Duplicate Fuel Warning

Detect:

- Same vehicle
- Same odometer
- Similar timestamp
- Similar total

Warn:

> A similar fuel entry already exists.

Do not hard-block.

---

## 8.11 Sprint 3 Testing

Unit:

- Fuel input calculations
- Fixed precision conversion
- Odometer validation

Repository:

- Fuel CRUD
- Pagination

Transaction:

- Fuel + odometer atomic save

Integration:

- Add fuel → vehicle odometer updates
- Edit fuel → odometer updates correctly
- Delete latest fuel → current odometer recalculates

---

# 9. Sprint 4 — Mileage, Expenses & Dashboard

## Sprint Goal

Convert raw fuel and odometer data into useful financial and mileage insight.

## Deliverables

- Full-tank mileage
- Partial refill support
- Expense tracking
- Dashboard
- Monthly summary
- Cost/km initial implementation

---

## 9.1 Mileage Calculator

Create domain service:

```text
MileageCalculator
```

Support:

- Full → full
- Full → partial → full
- Full → multiple partial → full
- Insufficient data
- Invalid odometer
- Zero fuel

Return:

- status
- distance
- fuel quantity
- mileage
- explanation

---

## 9.2 Mileage Recalculation

Trigger when:

- Fuel added
- Fuel edited
- Fuel deleted
- Odometer correction affects interval

Do not rely on stale stored mileage if avoidable.

If caching is used:

- Store calculation metadata
- Invalidate affected ranges

---

## 9.3 Expense Schema

Create:

```text
expenses
expense_categories
```

Fields:

- id
- vehicleId
- date
- category
- amount
- odometer nullable
- vendorId nullable
- paymentMethod
- description
- note
- sourceType
- sourceRecordId
- createdAt
- updatedAt

---

## 9.4 System Expense Categories

Seed:

- Fuel
- Maintenance
- Repair
- Engine oil
- Parts
- Tyres
- Battery
- Tax token
- Fitness
- Insurance
- Registration
- Parking
- Toll
- Cleaning
- Accessories
- Fine
- Loan/installment
- Other

---

## 9.5 Fuel Expense Linking

On fuel save:

- Create or update linked expense
- `sourceType = fuel`
- `sourceRecordId = fuelEntryId`

On fuel delete:

- Delete linked expense

Test for duplicate prevention.

---

## 9.6 Manual Expense Flow

Screen:

- Date
- Category
- Amount
- Odometer
- Description
- Payment method
- Note

Add:

- Expense history
- Expense details
- Edit
- Delete

---

## 9.7 Dashboard Service

Create aggregated service for:

- Current odometer
- Current month fuel
- Maintenance
- Repair
- Other
- Total expense
- Distance
- Average mileage
- Cost/km
- Upcoming placeholders
- Recent activity

---

## 9.8 Dashboard UI

Sections:

### Header

- Selected vehicle
- Odometer
- Vehicle switcher

### This Month

- Fuel
- Maintenance
- Repairs
- Other
- Total

### Driving

- Distance
- Fuel used
- Mileage
- Cost/km

### Quick Add

- Fuel
- Expense
- Service
- Repair

### Recent Activity

Unified recent items.

---

## 9.9 Initial Cost/km Calculator

Create:

```text
CostPerKmCalculator
```

Default:

```text
selected monthly operating expenses / valid distance
```

If distance unavailable:

- Show `Not enough data`

---

## 9.10 Sprint 4 Testing

High-priority unit tests:

- Two full tanks
- Partial fill interval
- Multiple partial fills
- Fuel deletion impact
- Mileage invalid states
- Cost/km zero-distance handling
- Expense aggregation

Widget:

- Dashboard empty
- Dashboard populated
- Expense form

Integration:

- Add fuel twice → mileage appears on dashboard
- Add expense → monthly total changes

---

# 10. Sprint 5 — Maintenance & Engine Oil

## Sprint Goal

Add structured service tracking and the most important motorcycle maintenance workflow.

## Deliverables

- Maintenance templates
- Service records
- Multi-item services
- Engine oil records
- Next due date/km rules
- Service expense linkage

---

## 10.1 Maintenance Schema

Create:

```text
service_records
service_items
maintenance_templates
oil_changes
```

---

## 10.2 Seed Motorcycle Maintenance Templates

Seed:

- General service
- Engine oil
- Oil filter
- Air filter
- Spark plug
- Chain lubrication
- Chain adjustment
- Chain/sprocket
- Brake inspection
- Brake pad
- Clutch adjustment
- Coolant
- Front tyre
- Rear tyre
- Battery
- Suspension

Also seed basic car templates.

---

## 10.3 Service Repository

Implement:

- Add service
- Update service
- Delete service
- Get service history
- Get service details
- Get due services

---

## 10.4 Add Service Flow

Fields:

- Date
- Odometer
- Workshop/vendor
- Service items
- Labor cost
- Parts cost
- Total cost
- Next due date
- Next due odometer
- Notes

Support multiple service items.

---

## 10.5 Service Expense Link

Create linked expense:

```text
sourceType = service
sourceRecordId = serviceId
```

Editing service cost must update linked expense.

---

## 10.6 Engine Oil Tracking

Fields:

- Date
- Odometer
- Brand
- Product
- Viscosity
- Quantity
- Cost
- Filter changed
- Vendor
- Next due date
- Next due odometer
- Note

---

## 10.7 Oil Change Shortcut

Quick action:

`Add Oil Change`

Should optionally create:

- Oil change record
- Service item
- Expense
- Reminder seed

All in one transaction if configured.

---

## 10.8 Service History

List:

- Date
- Odometer
- Primary service item
- Total cost
- Workshop

Details:

- All items
- Cost split
- Next due
- Notes

---

## 10.9 Maintenance Empty States

Examples:

- No service history
- No oil change recorded
- No maintenance due yet

---

## 10.10 Sprint 5 Testing

Unit:

- Next due date/km
- Service total
- Oil interval

Repository:

- Service + items
- Oil CRUD

Transaction:

- Service + expense
- Oil + expense + odometer

Integration:

- Add oil change → service/expense/dashboard updated

---

# 11. Sprint 6 — Repairs, Parts, Tyres & Battery

## Sprint Goal

Complete the main vehicle maintenance record set.

## Deliverables

- Repair history
- Repair parts
- Standalone parts
- Tyre records
- Tyre events
- Battery tracking
- Warranty dates

---

## 11.1 Repair Schema

Create:

```text
repairs
repair_parts
vehicle_parts
```

---

## 11.2 Repair Flow

Fields:

- Date
- Odometer
- Category
- Problem
- Diagnosis
- Work performed
- Workshop
- Labor
- Parts
- Total
- Warranty
- Follow-up date
- Notes

Linked expense:

```text
sourceType = repair
```

---

## 11.3 Repair Categories

Seed:

- Engine
- Electrical
- Brake
- Suspension
- Transmission
- Clutch
- Tyre/wheel
- Body
- AC
- Fuel system
- Cooling
- Other

---

## 11.4 Repair Parts

Allow multiple parts:

- Name
- Brand
- Part number
- Quantity
- Unit cost
- Warranty

---

## 11.5 Vehicle Parts Tracking

Standalone part replacement:

- Installed date
- Odometer
- Replacement interval
- Vendor
- Warranty

---

## 11.6 Tyre Schema

Create:

```text
tyres
tyre_events
```

Support positions based on vehicle type.

Motorcycle:

- Front
- Rear

Car:

- FL
- FR
- RL
- RR
- Spare

---

## 11.7 Tyre Flow

Create:

- Add tyre
- View tyre details
- Replace
- Repair
- Inspect
- Rotate

Store lifecycle events.

---

## 11.8 Battery Schema & Flow

Track:

- Brand
- Model
- Specification
- Purchase date
- Install date
- Odometer
- Cost
- Warranty
- Vendor
- Status

Actions:

- Add battery
- Replace battery
- Mark removed

---

## 11.9 Warranty State

Show:

- Active
- Expiring soon
- Expired

Do not trigger notifications yet unless reminder engine is already scaffolded.

---

## 11.10 Sprint 6 Testing

Unit:

- Warranty state
- Tyre position rules
- Replacement interval validation

Repository:

- Repair + parts
- Tyres + events
- Battery

Integration:

- Repair → expense/dashboard
- Tyre replacement history preserved

---

# 12. Sprint 7 — Documents, Reminders & Notifications

## Sprint Goal

Deliver Bangladesh-specific legal document tracking and reliable maintenance reminders.

## Deliverables

- Registration data
- Tax token
- Fitness
- Insurance
- Reminder engine
- Date/km reminders
- Local notifications
- Snooze
- Complete/skip

---

## 12.1 Vehicle Document Schema

Create:

```text
vehicle_documents
```

Document types:

- Registration
- Tax token
- Fitness
- Insurance
- Route permit
- Driving license reference
- Ownership transfer
- Loan document
- Other

---

## 12.2 Add Document Flow

Fields:

- Type
- Number/reference
- Issue date
- Expiry date
- Fee
- Authority/provider
- Policy number
- Notes

Specific dynamic fields based on document type.

---

## 12.3 Reminder Schema

Create:

```text
reminders
```

Support:

- Date threshold
- Odometer threshold
- Combined threshold
- Recurrence
- Advance days
- Advance km
- Status
- Snooze
- Completion

---

## 12.4 Reminder Engine

Create:

```text
ReminderEngine
```

Evaluate:

- Upcoming
- Due soon
- Due
- Overdue
- Completed
- Skipped

Run on:

- App startup
- App resume
- Odometer update
- Fuel save
- Service save
- Reminder modification

---

## 12.5 Date Reminder Logic

Test:

- 30 days before
- 14 days
- 7 days
- 1 day
- Due
- Expired

---

## 12.6 Kilometer Reminder Logic

Examples:

- 500 km remaining
- 200 km remaining
- Due
- Overdue

---

## 12.7 Combined Reminder Logic

Rule:

```text
Due on date OR odometer, whichever comes first
```

Examples:

- Engine oil
- General service
- Tyre inspection

---

## 12.8 Local Notifications

Implement:

- Permission handling
- Schedule
- Update
- Cancel
- Notification tap routing
- Reschedule after app update/restart as necessary

Payload:

- reminderId
- vehicleId
- entity type
- entity ID

---

## 12.9 Reminder UI

Screens:

- Reminder list
- Reminder details
- Create/edit reminder
- Snooze sheet
- Completed reminders

Filters:

- Upcoming
- Due soon
- Overdue
- Completed

---

## 12.10 Dashboard Upcoming Section

Add:

- Maintenance due
- Document expiry
- Overdue items

---

## 12.11 Sprint 7 Testing

Unit:

- Reminder states
- Combined rules
- Snooze logic

Notification:

- Scheduling
- Cancel/update
- Deep link navigation

Integration:

- Add insurance → reminder → notification scheduled
- Add fuel with high odometer → service reminder becomes due

---

# 13. Sprint 8 — Reports, Analytics & Unified History

## Sprint Goal

Turn stored data into meaningful insights and a useful lifetime vehicle record.

## Deliverables

- Reports home
- Monthly expense report
- Fuel report
- Mileage report
- Maintenance report
- Repair report
- Cost/km report
- Unified history timeline

---

## 13.1 Report Repository

Create optimized aggregate queries for:

- Monthly expenses
- Yearly expenses
- Category totals
- Fuel quantity
- Fuel spending
- Fuel price
- Mileage
- Maintenance
- Repair
- Document fees
- Distance

---

## 13.2 Monthly Expense Report

Display:

- Fuel
- Maintenance
- Repairs
- Documents
- Other
- Total

Filters:

- Month
- Vehicle

---

## 13.3 Yearly Report

Display:

- Annual total
- Monthly average
- Highest month
- Category breakdown

---

## 13.4 Fuel Report

Metrics:

- Total liters
- Total spend
- Average price/L
- Distance
- Average mileage
- Fuel cost/km

Charts:

- Monthly fuel cost
- Fuel price trend

---

## 13.5 Mileage Report

Metrics:

- Latest
- 30-day
- 90-day
- Lifetime
- Best
- Lowest

Graph:

- Mileage by refill

---

## 13.6 Cost/km Report

Support:

- Fuel-only
- Operating cost
- Custom selected categories

Show formula explanation.

Handle insufficient distance safely.

---

## 13.7 Maintenance Report

Metrics:

- Total service cost
- Service count
- Average service cost
- Common service categories

---

## 13.8 Repair Report

Metrics:

- Total repair cost
- Count
- Top categories
- Repeated categories

Basic repeated issue detection:

- same repair category >= configured count in period

---

## 13.9 Unified Timeline

Create normalized timeline query.

Item types:

- Fuel
- Expense
- Service
- Repair
- Oil
- Tyre
- Battery
- Document
- Odometer

Features:

- Pagination
- Filter by type
- Search by text where available

---

## 13.10 Dashboard Optimization

Review dashboard query performance.

Ensure:

- No N+1 queries
- Aggregations use DB
- Recent activity query limited

---

## 13.11 Sprint 8 Testing

SQL tests:

- Monthly totals
- Category aggregation
- Mileage report
- Cost/km

Widget tests:

- Empty report
- Populated report
- Filter changes

Integration:

- User history produces correct dashboard/report totals

---

# 14. Sprint 9 — Attachments, Export, Backup & Restore

## Sprint Goal

Protect user ownership of data and enable receipts/documents to be stored safely.

## Deliverables

- Receipt/document attachments
- Image compression
- CSV export
- Backup creation
- Backup validation
- Restore
- Backup history

---

## 14.1 Attachment Schema

Create:

```text
attachments
```

Fields:

- id
- ownerType
- ownerId
- original filename
- stored filename
- MIME
- size
- relative path
- thumbnail
- checksum
- createdAt

---

## 14.2 File Storage Service

Create:

```text
FileStorageService
```

Responsibilities:

- Copy file to app-private storage
- Generate safe name
- Generate thumbnail
- Delete file
- Validate existence
- Cleanup orphan temp files

---

## 14.3 Camera/Photo Picker

Support:

- Take photo
- Choose image/file
- Permission handling

Use cases:

- Fuel receipt
- Service invoice
- Repair photo
- Registration document
- Insurance document

---

## 14.4 Attachment UI

Components:

- Attachment tile
- Preview
- Delete
- Rename display label
- Add attachment

---

## 14.5 CSV Export

Implement:

- Fuel
- Expenses
- Service
- Repairs
- Odometer
- Documents

Options:

- Date range
- Vehicle
- Share file

---

## 14.6 Backup Format

Create package:

```text
manifest.json
database.sqlite
attachments/
metadata.json
```

Extension:

```text
.gkbackup
```

---

## 14.7 Backup Service

Flow:

1. Flush DB
2. Create DB snapshot
3. Collect attachments
4. Generate manifest
5. Calculate checksums
6. Encrypt archive
7. Save/export

---

## 14.8 Backup History

Track:

- Timestamp
- Path/reference
- Size
- Vehicle count
- Schema version
- Status

---

## 14.9 Restore Service

Flow:

1. Pick backup
2. Validate archive
3. Read manifest
4. Verify version
5. Verify checksum
6. Decrypt
7. Validate DB
8. Show summary
9. Create safety backup
10. Restore
11. Run migration
12. Reschedule reminders
13. Validate final state

---

## 14.10 Restore UI

States:

- Reading
- Validating
- Summary
- Confirm restore
- Restoring
- Success
- Failed
- Corrupt backup
- Unsupported version

---

## 14.11 Sprint 9 Testing

Attachment:

- Add
- Delete
- Missing file handling

Export:

- Correct CSV values
- Bangla encoding

Backup:

- Create/restore
- Corrupt backup
- Wrong key/password if used
- Missing attachment
- Old schema backup
- Interrupted restore simulation

---

# 15. Sprint 10 — Settings, Security & UX Hardening

## Sprint Goal

Complete user preferences, privacy/security controls, common states, accessibility, and overall product polish.

## Deliverables

- Settings
- Theme
- Language
- Notification settings
- App lock
- Biometrics
- Permission states
- Common UI states
- Performance polish

---

## 15.1 Settings Home

Sections:

- General
- Appearance
- Reminders
- Data & backup
- Security
- About

---

## 15.2 General Settings

Add:

- Language
- Currency
- Distance unit
- Fuel unit
- Date format

MVP defaults:

- BDT
- km
- liter

---

## 15.3 Appearance

Add:

- Light
- Dark
- System

Validate:

- Bangla readability
- High contrast
- Large font scaling

---

## 15.4 Notification Preferences

Add:

- Maintenance
- Documents
- Backup reminder

Allow:

- Enable/disable
- Advance days
- Advance km

---

## 15.5 App Lock

Implement:

- Set PIN
- Verify PIN
- Change PIN
- Disable PIN
- Auto-lock timeout

Optional biometrics:

- Face ID
- Touch ID
- Android biometrics

---

## 15.6 Security Hardening

Tasks:

- Store secrets in secure storage
- Ensure private file storage
- Review logs for sensitive values
- Disable screenshot/recent-app preview where appropriate if supported/configured
- Review exported temporary files
- Cleanup decrypted temp files

---

## 15.7 Common UI States

Implement reusable designs:

- Initial loading
- Skeleton
- Empty list
- No search result
- Save in progress
- Save successful
- Save failed
- Delete confirmation
- Delete failed
- Unsaved changes
- Invalid odometer
- Duplicate fuel warning
- Permission denied
- Notification denied
- Storage nearly full
- Backup failed
- Restore failed
- Corrupt backup
- Database migration
- Calculation unavailable

---

## 15.8 Accessibility Review

Tasks:

- Semantic labels
- Screen reader validation
- Dynamic text
- Tap sizes
- Contrast
- Icon labels
- Error announcements

---

## 15.9 Performance Review

Profile:

- Startup
- Dashboard
- Timeline
- Fuel history
- Reports
- Backup

Optimize:

- Slow queries
- Excess rebuilds
- Image thumbnails
- Pagination
- provider invalidation

---

## 15.10 Sprint 10 Testing

Security:

- PIN
- Biometrics
- Auto-lock

UX:

- Localization completeness
- Dark mode
- Font scaling
- Permission denial

Regression:

- Core user journeys from Sprints 2–9

---

# 16. Sprint 11 — Release Hardening & Store Readiness

## Sprint Goal

Prepare a stable production release for Android and iOS.

## Deliverables

- Final regression
- Bug fixes
- Migration verification
- Release configuration
- Store assets
- Privacy text
- Production build

---

## 16.1 Full Regression

Run end-to-end scenarios:

1. Install fresh
2. Select Bangla
3. Create motorcycle
4. Add fuel
5. Add second full tank
6. Verify mileage
7. Add expense
8. Add service
9. Add engine oil
10. Add repair
11. Add tyre
12. Add insurance
13. Verify reminder
14. Open reports
15. Create backup
16. Restore backup
17. Enable PIN
18. Reopen app

---

## 16.2 Migration Testing

Test:

- Previous internal build schema → current
- Corrupt migration rollback
- Large dataset migration

---

## 16.3 Large Dataset Testing

Seed:

- Multiple vehicles
- 5+ years
- Thousands of fuel entries
- Thousands of expenses
- Hundreds of service records
- Attachments

Verify:

- Dashboard speed
- Timeline speed
- Report speed
- Backup size
- Restore reliability

---

## 16.4 Android Release Tasks

- App signing
- Release keystore configuration
- ProGuard/R8 review
- Notification permission handling
- FileProvider validation
- Adaptive icon
- App icon
- Splash
- Store screenshots
- Privacy policy link
- Play Store data safety form

---

## 16.5 iOS Release Tasks

- Signing
- Provisioning
- App icon
- Launch assets
- Info.plist permission descriptions
- Notification handling
- File sharing constraints
- Privacy manifest if required
- App Store screenshots
- App privacy disclosures

---

## 16.6 Production Logging

Set:

- Debug logs off/reduced
- Sensitive logs removed
- Crash reporter privacy configuration

---

## 16.7 Release Checklist

- Version number
- Build number
- Changelog
- Database schema version
- Backup format version
- Localization complete
- No blocker bugs
- No critical/high security bugs
- Store metadata ready

---

# 17. Cross-Sprint Technical Tasks

These tasks continue throughout all sprints.

## 17.1 Localization

Every new feature must include:

- English
- Bangla

No sprint should postpone localization.

---

## 17.2 Testing

Every business-rule task must include unit tests.

Priority areas:

- Money
- Mileage
- Odometer
- Reminders
- Backup
- Restore

---

## 17.3 Database Migrations

Each schema change requires:

- Version increase
- Migration
- Migration test
- Existing-data test

---

## 17.4 Error Handling

Every asynchronous user operation must handle:

- Success
- Validation failure
- Storage failure
- Unexpected failure

---

## 17.5 Analytics Privacy Review

If analytics is introduced:

- Do not capture document numbers
- Do not capture registration number
- Do not capture attachments
- Do not capture private notes

---

# 18. Suggested Epic Breakdown

## Epic 1 — App Foundation

- Architecture
- Navigation
- Localization
- Theme
- Database
- Error framework

## Epic 2 — Vehicle Management

- Onboarding
- Vehicles
- Selection
- Profile
- Archive

## Epic 3 — Fuel & Odometer

- Fuel
- Odometer
- Mileage

## Epic 4 — Expenses & Dashboard

- Expense categories
- Expense CRUD
- Dashboard
- Cost/km

## Epic 5 — Maintenance

- Service
- Oil
- Templates

## Epic 6 — Vehicle Components

- Repair
- Parts
- Tyres
- Battery

## Epic 7 — Documents & Reminders

- Tax token
- Fitness
- Insurance
- Reminder engine
- Notifications

## Epic 8 — Reports

- Expense
- Fuel
- Mileage
- Maintenance
- Repair
- Timeline

## Epic 9 — Data Ownership

- Attachments
- Export
- Backup
- Restore

## Epic 10 — Security & Release

- Settings
- App lock
- Production hardening
- Store release

---

# 19. Priority Classification

## P0 — Must Have

- Vehicle
- Odometer
- Fuel
- Mileage
- Expenses
- Service
- Engine oil
- Repair
- Documents
- Reminders
- Dashboard
- Reports
- Backup

## P1 — Strong MVP

- Tyres
- Battery
- Parts
- Attachments
- Export
- App lock
- Vendor tracking

## P2 — Post-MVP

- Budgeting
- Trip calculator
- Cloud backup
- OCR
- AI insights
- Resale PDF
- Commercial income tracking
- OBD
- EV support

---

# 20. Critical Technical Dependencies

## Fuel depends on:

- Vehicle
- Odometer
- Database

## Mileage depends on:

- Fuel
- Odometer

## Dashboard depends on:

- Fuel
- Expense
- Mileage
- Vehicle

## Maintenance depends on:

- Vehicle
- Odometer
- Expense linkage

## Reminder engine depends on:

- Vehicle
- Odometer
- Maintenance/documents

## Reports depend on:

- Stable schema
- Expense linking
- Mileage logic

## Backup depends on:

- Stable DB
- Attachment storage
- Schema versioning

---

# 21. Recommended QA Test Matrix

Test on:

## Android

- Low/mid-range Android
- Recent Android version
- One older supported version

## iOS

- Recent iPhone
- Smaller-screen device if supported

Test language:

- English
- বাংলা

Test themes:

- Light
- Dark

Test data states:

- Fresh install
- One vehicle
- Multiple vehicles
- Large history
- No internet
- Notification denied
- Storage low
- Backup restore

---

# 22. MVP Acceptance Criteria

The MVP is ready when a motorcycle owner can successfully:

1. Install the app.
2. Select Bangla or English.
3. Add a motorcycle.
4. Enter current odometer.
5. Add fuel.
6. Record multiple fuel refills.
7. See calculated mileage.
8. Track monthly fuel spending.
9. Add general expenses.
10. Record engine oil changes.
11. Record servicing.
12. Record repairs.
13. Track tyres.
14. Track battery.
15. Add tax token.
16. Add fitness certificate.
17. Add insurance.
18. Receive relevant reminders.
19. See total monthly cost.
20. See cost per kilometer.
21. View vehicle history.
22. Export data.
23. Create backup.
24. Restore backup.
25. Protect the app with PIN/biometrics if desired.

---

# 23. Post-MVP Sprint Suggestions

After the first production release:

## Sprint 12 — Budgeting & Trip Calculator

- Monthly budgets
- Fuel budget
- Trip fuel estimate
- Budget alerts

## Sprint 13 — Cloud Backup

- Google Drive
- OneDrive
- Dropbox
- Auto backup

## Sprint 14 — Resale Report

- Maintenance summary
- Printable PDF
- Share-safe report

## Sprint 15 — OCR

- Receipt capture
- Odometer image
- Document date extraction

## Sprint 16 — Smart Insights

- Mileage degradation
- Repeat repair detection
- Fuel forecast
- Maintenance suggestions

## Sprint 17 — Commercial/CNG Mode

- Daily income
- Daily operating cost
- Driver
- Net profit

---

# 24. Suggested Jira Story Naming

Examples:

```text
GK-001 Initialize Flutter Project
GK-002 Configure Riverpod
GK-003 Setup Drift Database
GK-004 Add Bangla Localization
GK-005 Create Vehicle Schema
GK-006 Implement Add Vehicle
GK-007 Implement Vehicle Switcher
GK-008 Create Odometer Service
GK-009 Implement Add Fuel
GK-010 Implement Fuel History
GK-011 Implement Mileage Calculator
GK-012 Create Expense Schema
GK-013 Build Dashboard Summary
GK-014 Implement Service Records
GK-015 Implement Oil Change Tracking
GK-016 Implement Repair Tracking
GK-017 Implement Vehicle Documents
GK-018 Implement Reminder Engine
GK-019 Schedule Local Notifications
GK-020 Implement Cost/km Report
GK-021 Implement Backup Service
GK-022 Implement Restore Service
GK-023 Implement App Lock
GK-024 Production Release Hardening
```

---

# 25. Suggested Story Template

Each Jira story should include:

## Title

Clear action-oriented name.

## User Story

Example:

> As a motorcycle owner, I want to record a fuel refill so that I can track fuel spending and mileage.

## Technical Scope

- Tables
- Repository
- Use case
- UI
- State
- Validation

## Acceptance Criteria

Specific testable behavior.

## Test Cases

Happy path + edge cases.

## Dependencies

Related stories.

## Definition of Done

Standard project DoD.

---

# 26. Example Detailed Story — Add Fuel

## User Story

As a vehicle owner, I want to record a fuel refill so I can track fuel cost and mileage.

## Tasks

### Database

- Add fuel table
- Add indexes
- Add migration

### Domain

- Add FuelEntry entity
- Add FuelInput
- Add validation

### Application

- Add AddFuelEntry use case
- Add controller

### Repository

- Insert
- Update
- Delete
- Query history

### Odometer

- Validate reading
- Insert linked reading
- Update vehicle current odometer

### Expense

- Create linked fuel expense

### UI

- Add fuel form
- Full tank toggle
- Cost auto-calculation
- Success state
- Validation messages

### Tests

- Valid fuel
- Zero liters
- Backward odometer
- Duplicate warning
- Transaction rollback

---

# 27. Example Detailed Story — Engine Oil Reminder

## User Story

As a motorcycle owner, I want to be reminded when engine oil is due so I do not exceed my maintenance interval.

## Tasks

### Domain

- Oil interval rule
- Combined km/date logic

### Database

- Store next due date
- Store next due odometer

### Reminder

- Create reminder on oil record
- Evaluate due state

### Notification

- Schedule date notification

### UI

- Show km remaining
- Show days remaining
- Complete reminder after oil change

### Tests

- km due first
- date due first
- both due
- overdue
- oil change resets schedule

---

# 28. Technical Review Gates

Schedule formal architecture/quality reviews at:

## After Sprint 2

Review:

- Architecture
- DB
- Vehicle model

## After Sprint 4

Review:

- Mileage correctness
- Expense linking
- Dashboard performance

## After Sprint 7

Review:

- Reminder reliability
- Notification behavior
- Document security

## After Sprint 9

Review:

- Backup integrity
- Restore safety
- Attachment storage

## Before Release

Review:

- Security
- Migration
- Privacy
- Performance
- Store compliance

---

# 29. Risks and Mitigation Plan

## Risk — Mileage logic incorrect

Mitigation:

- Strong domain isolation
- Test matrix
- Sample real-world refill history

## Risk — Expense duplication

Mitigation:

- `sourceType + sourceRecordId`
- Unique linkage where possible

## Risk — Reminder notifications missed

Mitigation:

- DB reminder state remains source of truth
- Re-evaluate on app start

## Risk — Data loss during restore

Mitigation:

- Pre-restore safety backup
- Validation
- Atomic restore strategy

## Risk — Schema migration failure

Mitigation:

- Migration tests from every supported schema
- Safety backup

## Risk — Attachment storage growth

Mitigation:

- Compression
- Storage usage indicator
- Cleanup tools

---

# 30. Final Recommended MVP Execution Order

The recommended implementation order is:

```text
Foundation
↓
Vehicle
↓
Odometer
↓
Fuel
↓
Mileage
↓
Expense
↓
Dashboard
↓
Maintenance
↓
Repair / Tyre / Battery
↓
Documents
↓
Reminders
↓
Reports
↓
Attachments
↓
Backup / Restore
↓
Security
↓
Release Hardening
```

This order minimizes rework because each feature builds on stable foundations.

---

# 31. Final Delivery Outcome

At the end of the MVP implementation, Garir Khata should be a robust local-first vehicle companion where a Bangladeshi motorcycle or car owner can maintain a trustworthy digital history of:

- Fuel
- Mileage
- Expenses
- Service
- Engine oil
- Repairs
- Tyres
- Battery
- Parts
- Tax token
- Fitness
- Insurance
- Odometer
- Documents

and receive practical outputs such as:

> **This Month**  
> Fuel: ৳4,850  
> Maintenance: ৳1,200  
> Repairs: ৳800  
> Distance: 818 km  
> Average Mileage: 41.6 km/L  
> **Cost/km: ৳8.80**

The technical priority throughout development should remain:

**data correctness first, convenience second, advanced intelligence later.**
