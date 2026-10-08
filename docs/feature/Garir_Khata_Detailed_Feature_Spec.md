# Garir Khata — Detailed Feature Specification
## Vehicle Expense & Maintenance Tracker for Bangladesh

**App Name:** Garir Khata  
**Bangla Name:** গাড়ির খাতা  
**Primary Target:** Motorcycle owners in Bangladesh  
**Secondary Target:** Private car, CNG, microbus, pickup, and other personal/light commercial vehicle owners  
**Platform:** Mobile-first application  
**Primary Languages:** বাংলা and English  
**Primary Currency:** BDT (৳)

---

# 1. Product Overview

**Garir Khata** is a personal vehicle expense, mileage, maintenance, and document tracking app designed for vehicle owners who want a simple way to understand how much their vehicle actually costs to own and operate.

The app works like a digital vehicle notebook where users can record:

- Fuel purchases
- Odometer readings
- Mileage
- Engine oil changes
- Routine servicing
- Tyres
- Battery
- Repairs
- Spare parts
- Tax token
- Fitness certificate
- Insurance
- Registration-related information and dates
- Other vehicle expenses

The app converts these records into useful insights such as:

> **This Month**  
> Fuel: ৳4,850  
> Maintenance: ৳1,200  
> Total Distance: 818 km  
> Average Mileage: 41.6 km/L  
> Cost/km: ৳7.40

The application should be especially easy for motorcycle owners who currently track servicing and fuel informally through memory, paper notes, messaging apps, or not at all.

---

# 2. Product Goals

## 2.1 Primary Goals

1. Make vehicle expense tracking fast enough to use after every fuel refill or service.
2. Help users know the true monthly and yearly cost of owning a vehicle.
3. Prevent missed servicing and document renewal dates.
4. Track mileage and detect unusual fuel efficiency changes.
5. Maintain a complete maintenance and repair history.
6. Help users estimate future maintenance needs.
7. Preserve useful records for resale, budgeting, and troubleshooting.
8. Support Bangla-speaking users with a simple, locally familiar experience.

## 2.2 Secondary Goals

- Compare multiple vehicles.
- Identify high-cost months and recurring repair problems.
- Track workshop/service-center history.
- Store photos, invoices, and document references.
- Estimate fuel cost for planned travel.
- Improve vehicle resale transparency through maintenance records.

---

# 3. Target Users

## 3.1 Motorcycle Owners

The primary audience.

Typical needs:

- Frequent fuel tracking
- Mileage calculation
- Engine oil reminders
- Chain cleaning/lubrication
- Brake service
- Air filter maintenance
- Tyre replacement
- Battery replacement
- Tax token/registration reminders
- Quick expense entry

## 3.2 Private Car Owners

Typical needs:

- Fuel and mileage
- Periodic servicing
- Engine oil/filter changes
- Tyres
- Battery
- AC service
- Insurance
- Fitness
- Tax token
- Repairs
- Parts replacement history

## 3.3 CNG / Ride-Sharing / Commercial Drivers

Possible advanced audience.

Typical needs:

- Daily expense logging
- Fuel/CNG cost
- Income vs expense
- High-mileage maintenance
- Driver expense records
- Per-day and per-km operating cost

This can be treated as an advanced or later-phase extension.

---

# 4. Product Principles

## 4.1 Fast Entry

Common actions should require minimal taps.

Examples:

- Add fuel
- Add service
- Add expense
- Add odometer reading

## 4.2 Vehicle-First Design

Everything should be organized around a selected vehicle.

## 4.3 Clear Cost Visibility

Users should immediately understand:

- How much they spent
- What they spent it on
- How far they drove
- How efficiently the vehicle ran

## 4.4 Reminder-Driven Maintenance

The app should notify users before:

- Service due dates
- Kilometer-based maintenance thresholds
- Document expiry dates

## 4.5 Simple Bengali-Friendly UX

Avoid technical wording where simpler labels are possible.

Example:

- `জ্বালানি` instead of overly technical terms
- `সার্ভিসিং`
- `ইঞ্জিন অয়েল`
- `টায়ার`
- `ব্যাটারি`
- `কাগজপত্র`

---

# 5. Feature Scope Overview

The application is divided into the following major modules:

1. Onboarding & Vehicle Setup
2. Dashboard
3. Vehicle Management
4. Fuel Tracking
5. Mileage Tracking
6. Expense Tracking
7. Maintenance & Servicing
8. Engine Oil Tracking
9. Tyre Tracking
10. Battery Tracking
11. Repair History
12. Parts Replacement
13. Vehicle Documents
14. Reminder System
15. Odometer Management
16. Reports & Analytics
17. Cost-per-Kilometer Analytics
18. Fuel Efficiency Analytics
19. Service History
20. Workshop & Vendor Tracking
21. Attachments & Receipts
22. Notes
23. Search & Filters
24. Data Backup & Export
25. Settings
26. Common UI States

---

# 6. Onboarding & First-Time Setup

## 6.1 Splash Screen

Display:

- Garir Khata logo
- App name
- Bangla name: `গাড়ির খাতা`

## 6.2 Language Selection

Options:

- বাংলা
- English

Allow changing later from Settings.

## 6.3 Welcome Screen

Message example:

**আপনার গাড়ির খরচ, মাইলেজ ও সার্ভিসের হিসাব এক জায়গায় রাখুন।**

Primary action:

`গাড়ি যোগ করুন`

## 6.4 Vehicle Type Selection

Supported types:

- Motorcycle
- Scooter
- Private Car
- CNG
- Microbus
- Pickup
- SUV
- Other

## 6.5 Vehicle Basic Information

Fields:

- Vehicle nickname
- Brand
- Model
- Variant
- Model year
- Vehicle type
- Fuel type
- Registration number
- Current odometer
- Purchase date
- Purchase price
- Optional photo

Fuel types:

- Petrol
- Octane
- Diesel
- CNG
- LPG
- Electric
- Hybrid
- Other

## 6.6 Optional Vehicle Details

- Engine capacity
- Engine number
- Chassis number
- Color
- Registration authority/reference
- Ownership type
- Finance/loan status
- Notes

## 6.7 Reminder Setup

Prompt the user to configure:

- Engine oil
- General service
- Tax token
- Fitness
- Insurance
- Other important dates

Skip should be allowed.

---

# 7. Dashboard

The Dashboard should answer:

1. How much have I spent?
2. How far have I driven?
3. What is my mileage?
4. What maintenance is due soon?

## 7.1 Dashboard Header

Show:

- Selected vehicle
- Registration number
- Vehicle switcher
- Current odometer
- Add-entry shortcut

## 7.2 Monthly Summary Card

Example:

> **October 2026**  
> Fuel: ৳4,850  
> Maintenance: ৳1,200  
> Repairs: ৳800  
> Other: ৳350  
> **Total: ৳7,200**

## 7.3 Driving Summary

Show:

- Distance this month
- Fuel consumed
- Average mileage
- Cost/km

Example:

> Distance: 818 km  
> Fuel: 19.7 L  
> Mileage: 41.6 km/L  
> Cost/km: ৳7.40

## 7.4 Upcoming Maintenance

Examples:

- Engine oil due in 320 km
- General service due in 12 days
- Front tyre inspection due soon

## 7.5 Upcoming Documents

Examples:

- Tax token expires in 25 days
- Insurance expires in 42 days
- Fitness expires in 3 months

## 7.6 Quick Actions

- Add Fuel
- Add Expense
- Add Service
- Add Repair
- Update Odometer
- Add Reminder

## 7.7 Recent Activity

Timeline example:

- Fuel — ৳1,150
- Engine oil — ৳850
- Odometer — 24,510 km
- Brake pad replacement — ৳1,400

---

# 8. Vehicle Management

## 8.1 Vehicle List

Each card shows:

- Vehicle image
- Nickname
- Brand/model
- Registration number
- Current odometer
- Monthly spending

## 8.2 Multiple Vehicle Support

Users can manage more than one vehicle.

Possible examples:

- Personal motorcycle
- Family car
- Office vehicle

## 8.3 Vehicle Profile

Sections:

- Overview
- Technical details
- Current odometer
- Purchase info
- Documents
- Service history
- Expense history
- Attachments

## 8.4 Edit Vehicle

Allow updating all editable vehicle details.

## 8.5 Archive Vehicle

For:

- Sold vehicle
- No longer used
- Temporarily inactive vehicle

Do not delete history by default.

---

# 9. Fuel Tracking

Fuel tracking should be one of the fastest workflows in the app.

## 9.1 Add Fuel Entry

Fields:

- Date
- Time
- Odometer
- Fuel type
- Quantity in liters
- Price per liter
- Total cost
- Full tank? Yes/No
- Fuel station
- Location text
- Payment method
- Notes
- Receipt photo

## 9.2 Auto Calculations

If quantity and price are entered:

`Total = Quantity × Price per Liter`

If total and quantity are entered:

`Price per Liter = Total ÷ Quantity`

## 9.3 Full Tank Method

Mileage should support reliable full-tank calculation.

For consecutive full-tank entries:

`Mileage = Distance since previous full tank ÷ Fuel added`

## 9.4 Partial Refill

Partial refills are stored but should not produce misleading mileage calculations.

## 9.5 Fuel History

List fields:

- Date
- Odometer
- Liters
- Price/L
- Total
- Mileage

## 9.6 Fuel Entry Details

Show:

- All fuel data
- Calculated distance
- Calculated mileage
- Cost per km
- Notes
- Receipt

## 9.7 Fuel Price Trend

Chart:

- Price/L over time

## 9.8 Fuel Spending Trend

Chart:

- Monthly fuel spending

---

# 10. Mileage Tracking

## 10.1 Mileage Calculation

Support:

- Full-tank mileage
- Manual mileage entry
- Distance/fuel average

## 10.2 Mileage Summary

Show:

- Latest mileage
- 30-day average
- 90-day average
- Lifetime average
- Best mileage
- Lowest mileage

## 10.3 Mileage Trend

Graph by:

- Refill
- Week
- Month

## 10.4 Mileage Change Detection

Example:

> Your average mileage has dropped by 12% compared with the previous 30 days.

Possible causes can be suggested without claiming a diagnosis:

- Tyre pressure
- Traffic conditions
- Engine tuning
- Air filter
- Riding/driving style
- Fuel quality

## 10.5 Motorcycle-Focused Mileage

Motorcycle users may use:

- Reserve-to-reserve
- Full tank
- Manual trip meter

The app should recommend the full-tank method for better accuracy.

---

# 11. Odometer Management

## 11.1 Update Odometer

Fields:

- Date
- Current odometer
- Optional note

## 11.2 Automatic Odometer Updates

The odometer can be updated automatically when adding:

- Fuel
- Service
- Repair
- Maintenance

## 11.3 Validation

New odometer should normally not be lower than previous reading.

If lower:

- Warn the user
- Allow correction
- Allow odometer reset/replacement case with explanation

## 11.4 Odometer History

Show chronological readings.

---

# 12. Expense Tracking

## 12.1 Expense Categories

Default categories:

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
- Washing/Cleaning
- Accessories
- Fine
- Loan/Installment
- Other

## 12.2 Add Expense

Fields:

- Date
- Category
- Amount
- Odometer
- Vendor/workshop
- Payment method
- Description
- Notes
- Attachment

## 12.3 Custom Categories

Users may create custom categories.

Examples:

- Bike modification
- Helmet/accessories
- Detailing
- Garage rent

## 12.4 Expense History

Filter by:

- Month
- Category
- Vehicle
- Amount range
- Vendor

## 12.5 Expense Details

Show complete record and attachments.

---

# 13. Maintenance & Servicing

## 13.1 Maintenance Categories

Motorcycle examples:

- General service
- Engine oil
- Oil filter
- Air filter
- Spark plug
- Chain adjustment
- Chain lubrication
- Chain/sprocket replacement
- Brake pad/shoe
- Brake fluid
- Clutch adjustment
- Coolant
- Tyre
- Wheel alignment
- Battery
- Suspension
- Electrical
- Engine work
- Washing/detailing

Car examples:

- General service
- Engine oil
- Oil filter
- Air filter
- Cabin filter
- AC service
- Coolant
- Brake service
- Transmission oil
- Power steering
- Wheel alignment
- Wheel balancing
- Suspension
- Timing belt
- Battery
- Tyres

## 13.2 Add Service Record

Fields:

- Service date
- Odometer
- Service type
- Workshop
- Labor cost
- Parts cost
- Total cost
- Parts used
- Next due date
- Next due odometer
- Notes
- Invoice/receipt photos

## 13.3 Service Packages

Allow multiple jobs in one visit.

Example:

**Service Visit — 06 Oct 2026**

- Engine oil
- Oil filter
- Chain adjustment
- Brake cleaning

## 13.4 Next Service Rules

Allow:

- Date-based
- Kilometer-based
- Whichever comes first

Example:

> Engine oil every 2,000 km or 90 days.

## 13.5 Service History

Timeline of maintenance records.

## 13.6 Repeat Previous Service

Quick action:

`Repeat Service`

Useful for regular oil changes.

---

# 14. Engine Oil Tracking

## 14.1 Oil Change Record

Fields:

- Date
- Odometer
- Oil brand
- Product name
- Viscosity
- Quantity
- Cost
- Filter changed?
- Workshop
- Notes

## 14.2 Next Oil Change

Set by:

- Kilometer
- Time
- Both

Example:

> Next oil change at 26,500 km or 15 Dec 2026.

## 14.3 Oil Reminder

Reminder thresholds:

- 500 km remaining
- 200 km remaining
- Due
- Overdue

User can customize.

## 14.4 Oil History

Show previous:

- Brands
- Intervals
- Costs
- Mileage between oil changes

---

# 15. Tyre Tracking

## 15.1 Tyre Positions

Motorcycle:

- Front
- Rear

Car:

- Front Left
- Front Right
- Rear Left
- Rear Right
- Spare

## 15.2 Tyre Record

Fields:

- Brand
- Model
- Size
- Purchase date
- Installation date
- Installation odometer
- Cost
- Warranty
- Shop
- Notes

## 15.3 Tyre Replacement Reminder

Based on:

- Age
- Kilometer
- Manual inspection date

## 15.4 Tyre History

Track replacement history per position.

## 15.5 Rotation Tracking

For vehicles where relevant:

- Rotation date
- Odometer
- Position changes

---

# 16. Battery Tracking

## 16.1 Battery Record

Fields:

- Brand
- Model
- Capacity/specification
- Purchase date
- Installation date
- Cost
- Warranty period
- Warranty expiry
- Shop
- Notes
- Invoice

## 16.2 Battery Reminder

Examples:

- Warranty ending
- Battery age reached configured threshold
- Inspection due

## 16.3 Battery History

Track previous batteries and lifespan.

---

# 17. Repair Tracking

## 17.1 Add Repair

Fields:

- Date
- Odometer
- Problem
- Diagnosis/description
- Repair performed
- Workshop
- Labor cost
- Parts cost
- Total
- Parts replaced
- Warranty
- Follow-up date
- Notes
- Photos/invoice

## 17.2 Repair Categories

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
- Cooling system
- Other

## 17.3 Repeat Problem Detection

If similar repair categories occur repeatedly, show:

> Brake-related repairs were recorded 3 times in the last 6 months.

## 17.4 Repair Timeline

Chronological repair history.

---

# 18. Spare Parts Tracking

## 18.1 Part Record

Fields:

- Part name
- Brand
- Part number
- Installed date
- Installed odometer
- Cost
- Supplier
- Warranty
- Notes

## 18.2 Replacement Interval

Optional:

- Replace after X km
- Replace after X months

## 18.3 Part History

Show previous replacements.

---

# 19. Vehicle Documents

This is a major Bangladesh-specific feature.

## 19.1 Document Types

Default document types:

- Registration Certificate
- Tax Token
- Fitness Certificate
- Insurance
- Route Permit
- Driving License reference
- Ownership transfer documents
- Pollution/emission document if relevant
- Loan/hypothecation documents
- Other

## 19.2 Document Record

Fields:

- Document type
- Document/reference number
- Issue date
- Expiry date
- Renewal reminder date
- Fee/cost
- Issuing authority
- Notes
- Document photo/PDF

## 19.3 Tax Token Tracking

Fields:

- Tax token number/reference
- Issue date
- Expiry date
- Amount
- Renewal notes

Reminder examples:

- 30 days before
- 14 days before
- 7 days before
- 1 day before
- Expired

## 19.4 Fitness Tracking

Same reminder structure.

## 19.5 Insurance Tracking

Fields:

- Provider
- Policy number
- Coverage type
- Start date
- Expiry date
- Premium
- Contact
- Attachment

## 19.6 Registration Information

Store:

- Registration number
- Registration date
- Owner name
- Engine number
- Chassis number
- Vehicle class
- Optional registration document image

Sensitive numbers should be protected appropriately.

---

# 20. Reminder System

## 20.1 Reminder Types

- Maintenance
- Engine oil
- Service
- Tyre
- Battery
- Tax token
- Fitness
- Insurance
- Registration-related
- Custom reminder

## 20.2 Date-Based Reminder

Example:

> Remind me 30 days before insurance expiry.

## 20.3 Kilometer-Based Reminder

Example:

> Service at 28,000 km.

## 20.4 Combined Reminder

Example:

> Change engine oil every 2,000 km or 3 months, whichever comes first.

## 20.5 Reminder Status

- Upcoming
- Due soon
- Due today
- Overdue
- Completed
- Skipped

## 20.6 Reminder Notifications

Notification examples:

**ইঞ্জিন অয়েল বদলানোর সময় কাছাকাছি**  
আর প্রায় ২০০ কিমি বাকি।

**Tax Token expires in 7 days**

## 20.7 Snooze

Options:

- Tomorrow
- 3 days
- 7 days
- Custom

---

# 21. Service Centers, Workshops & Vendors

## 21.1 Vendor Types

- Fuel station
- Workshop
- Authorized service center
- Parts shop
- Tyre shop
- Battery shop
- Insurance provider
- Other

## 21.2 Vendor Record

Fields:

- Name
- Type
- Phone
- Address
- Contact person
- Notes

## 21.3 Vendor History

Show:

- Number of visits
- Total spending
- Services performed
- Last visit

## 21.4 Favorite Vendors

Mark frequently used vendors.

---

# 22. Attachments & Receipts

Users may attach:

- Fuel receipts
- Service invoices
- Repair photos
- Part invoices
- Document images
- Insurance files

Supported attachment categories:

- Image
- PDF
- Other supported documents

## 22.1 Attachment Preview

Allow:

- View
- Rename
- Replace
- Delete

## 22.2 Storage Indicators

Show attachment storage usage where relevant.

---

# 23. Notes

## 23.1 Vehicle Notes

Examples:

- Strange engine noise
- Tyre pressure preference
- Mechanic recommendation
- Next modification idea

## 23.2 Maintenance Notes

Attach notes to service entries.

## 23.3 Quick Note

Allow a simple vehicle note from Dashboard.

---

# 24. Reports & Analytics

## 24.1 Monthly Expense Report

Breakdown:

- Fuel
- Maintenance
- Repairs
- Documents
- Other

## 24.2 Yearly Expense Report

Show:

- Total annual cost
- Monthly average
- Highest spending month
- Category breakdown

## 24.3 Expense by Category

Pie/bar visualization.

## 24.4 Fuel Report

Show:

- Total liters
- Total fuel spend
- Average price/L
- Average mileage
- Distance driven

## 24.5 Maintenance Report

Show:

- Total maintenance cost
- Number of services
- Most frequent service category
- Average service cost

## 24.6 Repair Report

Show:

- Repair total
- Repair categories
- Repeated issues

## 24.7 Document Cost Report

Show:

- Tax
- Insurance
- Fitness
- Registration-related fees

## 24.8 Total Ownership Cost

Optional advanced report:

`Purchase-related cost + Fuel + Maintenance + Repair + Documents + Other`

Can exclude purchase price when the user only wants operating cost.

---

# 25. Cost-per-Kilometer Analytics

This is one of the core differentiating outputs.

## 25.1 Monthly Cost/km

Formula:

`Cost per km = Total selected expenses ÷ Distance travelled`

Default selected expenses:

- Fuel
- Maintenance
- Repairs
- Regular ownership expenses

## 25.2 Fuel-Only Cost/km

`Fuel cost per km = Fuel spending ÷ Distance travelled`

## 25.3 Custom Cost/km

Allow the user to include/exclude:

- Insurance
- Tax token
- Accessories
- Loan payments
- Parking/toll

## 25.4 Example Output

> **October 2026**  
> Distance: 818 km  
> Fuel: ৳4,850  
> Maintenance: ৳1,200  
> Other: ৳350  
> Total: ৳6,400  
> **Cost/km: ৳7.82**

---

# 26. Fuel Efficiency Analytics

## 26.1 Key Metrics

- Current mileage
- Monthly average
- Lifetime average
- Best refill
- Worst refill

## 26.2 Trend Indicator

Example:

> Mileage improved 5.4% compared with last month.

## 26.3 Fuel Cost Forecast

Based on recent driving:

> At your current usage, estimated fuel cost next month is approximately ৳5,100.

Clearly label as an estimate.

---

# 27. Search & Filters

## 27.1 Global Search

Search:

- Expense
- Service
- Repair
- Vendor
- Part
- Document
- Notes

## 27.2 Filters

- Date range
- Vehicle
- Category
- Amount
- Odometer
- Vendor
- Record type

## 27.3 Saved Filters

Advanced feature.

Example:

`All motorcycle repairs in 2026`

---

# 28. Timeline / Vehicle History

Provide a unified chronological history.

Examples:

- 24,000 km — Fuel
- 24,420 km — Engine oil
- 24,870 km — Rear brake pad
- 25,100 km — Tax token renewed

Filters:

- All
- Fuel
- Service
- Repair
- Documents
- Expenses

This history can become a useful resale record.

---

# 29. Vehicle Resale Summary

Advanced feature.

Generate a clean summary showing:

- Vehicle details
- Current odometer
- Maintenance history
- Engine oil history
- Major repairs
- Tyre replacements
- Battery replacement
- Selected document status

Do not expose private attachments by default.

Possible output:

`Maintenance Summary`

Useful when selling a vehicle.

---

# 30. Budgeting

## 30.1 Monthly Vehicle Budget

User can set:

- Fuel budget
- Maintenance budget
- Total budget

## 30.2 Budget Progress

Example:

> Fuel budget: ৳6,000  
> Used: ৳4,850  
> Remaining: ৳1,150

## 30.3 Budget Warning

Example:

> You have used 90% of your monthly vehicle budget.

---

# 31. Trip Cost Calculator

Advanced feature.

Inputs:

- Trip distance
- Average mileage
- Fuel price

Output:

- Estimated fuel needed
- Estimated fuel cost

Example:

> Distance: 220 km  
> Mileage: 40 km/L  
> Fuel needed: 5.5 L  
> Estimated cost: ৳715

Round appropriately.

---

# 32. Motorcycle-Specific Features

Because motorcycles are a strong target segment, the app should include optional bike-specific maintenance templates.

## 32.1 Motorcycle Maintenance Items

- Engine oil
- Oil filter
- Air filter
- Spark plug
- Chain lubrication
- Chain adjustment
- Chain/sprocket
- Front brake
- Rear brake
- Clutch cable
- Throttle cable
- Coolant
- Front tyre
- Rear tyre
- Battery
- Suspension
- Headlight/electrical

## 32.2 Chain Maintenance Reminder

Support:

- Every X km
- Every X days
- After rain/manual trigger

## 32.3 Bike Wash

Optional expense/maintenance record.

## 32.4 Modification Tracking

Examples:

- Crash guard
- Mobile holder
- Auxiliary light
- Seat modification
- Luggage box

Keep modifications separate from essential maintenance if desired.

---

# 33. Car-Specific Features

Optional templates:

- Engine oil
- Oil filter
- Air filter
- Cabin filter
- Coolant
- Brake fluid
- Transmission oil
- AC servicing
- Wheel alignment
- Wheel balancing
- Tyre rotation
- Timing belt/chain
- Battery
- Wiper replacement
- Suspension

---

# 34. CNG / Commercial Vehicle Extensions

Advanced phase.

Possible modules:

- Daily trip log
- Daily income
- Driver payment
- Toll/parking
- Fuel/CNG expense
- Daily net profit
- Driver assignment
- Commercial document reminders

These should not complicate the core personal-vehicle MVP.

---

# 35. Data Export

## 35.1 Export Formats

- CSV
- PDF summary
- JSON backup

## 35.2 Export Categories

- Fuel
- Expenses
- Maintenance
- Repairs
- Documents
- Full vehicle history

## 35.3 Date Range

Allow:

- This month
- This year
- Custom

## 35.4 Share Report

User may share exported reports through installed apps.

---

# 36. Backup & Restore

Recommended even for a local-first version.

## 36.1 Local Backup

Create encrypted backup file.

## 36.2 Restore Backup

Validate before restoring.

## 36.3 Cloud Storage Integration

Advanced:

- Google Drive
- OneDrive
- Dropbox

Possible modes:

- Manual backup
- Scheduled backup
- Restore from selected backup

## 36.4 Backup Safety

Before restore:

- Show backup date
- Show vehicle count
- Warn about overwrite/merge behavior

---

# 37. Notifications

## 37.1 Notification Categories

- Maintenance reminders
- Document expiry
- Budget alerts
- Backup reminders
- Service follow-up

## 37.2 Notification Settings

Per category:

- On/Off
- Reminder lead time
- Quiet hours

---

# 38. Settings

## 38.1 General

- Language
- Currency
- Distance unit
- Fuel unit
- Date format
- Theme

Default Bangladesh settings:

- Currency: BDT
- Distance: Kilometer
- Fuel: Liter

## 38.2 Appearance

- Light
- Dark
- System default

## 38.3 Reminder Settings

Default reminder windows.

## 38.4 Data & Backup

- Export
- Backup
- Restore
- Delete all data

## 38.5 Security

Optional:

- App PIN
- Biometric lock

Useful because vehicle documents may contain sensitive information.

---

# 39. Localization

Full support for:

- বাংলা
- English

Example labels:

| English | বাংলা |
|---|---|
| Fuel | জ্বালানি |
| Mileage | মাইলেজ |
| Service | সার্ভিস |
| Engine Oil | ইঞ্জিন অয়েল |
| Repair | মেরামত |
| Tyre | টায়ার |
| Battery | ব্যাটারি |
| Documents | কাগজপত্র |
| Expense | খরচ |
| Reminder | রিমাইন্ডার |
| Odometer | ওডোমিটার |
| Cost per km | প্রতি কিমি খরচ |

Numbers may remain Arabic numerals initially for usability and consistency, with optional Bengali numeral support later.

---

# 40. Home Screen Navigation

Recommended bottom navigation:

1. Home
2. History
3. Add
4. Reports
5. More

## 40.1 Home

Dashboard and reminders.

## 40.2 History

Unified vehicle timeline.

## 40.3 Add

Prominent central action.

Options:

- Fuel
- Expense
- Service
- Repair
- Odometer
- Document

## 40.4 Reports

Cost, mileage, and trend analytics.

## 40.5 More

- Vehicle profile
- Documents
- Tyres
- Battery
- Vendors
- Backup
- Settings

---

# 41. Quick Add Experience

The `Add` button should prioritize common actions.

Recommended order for motorcycle users:

1. Fuel
2. Service
3. Expense
4. Repair
5. Odometer
6. Document

Remember previous values when safe.

Examples:

- Last fuel type
- Last fuel station
- Last payment method

Never reuse an old odometer without explicit confirmation.

---

# 42. Smart Suggestions

Advanced but useful.

Examples:

> You usually change engine oil every 2,100 km. Would you like to create a reminder?

> Your insurance expires in 30 days. Add a renewal reminder?

> Mileage has been lower than your recent average for 3 refills.

Suggestions must remain explainable and dismissible.

---

# 43. Data Validation Rules

## 43.1 Fuel

- Quantity > 0
- Cost >= 0
- Odometer should not move backward
- Fuel price should be within a configurable reasonable range warning, not a hard block

## 43.2 Expense

- Amount required
- Category required
- Date required

## 43.3 Service

- Service type required
- Date required
- Odometer recommended

## 43.4 Document

- Document type required
- Expiry must be later than issue date when both exist

## 43.5 Vehicle

- Nickname or model required
- Vehicle type required

---

# 44. Dashboard Empty States

## 44.1 No Fuel Data

Message:

`এখনও কোনো জ্বালানির হিসাব যোগ করা হয়নি।`

Action:

`প্রথম জ্বালানি এন্ট্রি যোগ করুন`

## 44.2 No Maintenance Data

Message:

`সার্ভিস বা মেইনটেন্যান্সের তথ্য যোগ করলে পরবর্তী সময়ের রিমাইন্ডার পাবেন।`

## 44.3 No Expense Data

Message:

`এই মাসে এখনো কোনো খরচ যোগ করা হয়নি।`

## 44.4 No Reminder

Message:

`এখন কোনো কাজ বাকি নেই।`

---

# 45. Common UI States

The app must design reusable states for:

1. Initial loading
2. Skeleton loading
3. Empty list
4. No search result
5. Save in progress
6. Save successful
7. Save failed
8. Delete confirmation
9. Delete failed
10. Unsaved changes
11. Invalid odometer
12. Duplicate fuel entry warning
13. Future date warning
14. Permission denied
15. Notification permission denied
16. Attachment upload/import failed
17. Storage nearly full
18. Backup in progress
19. Backup successful
20. Backup failed
21. Restore in progress
22. Restore failed
23. Corrupt backup
24. Database migration
25. Calculation unavailable because of insufficient data

---

# 46. MVP Feature Set

The first release should remain focused.

## 46.1 MVP — Core

- বাংলা + English
- Single/multiple vehicle setup
- Motorcycle/car vehicle types
- Dashboard
- Fuel tracking
- Full-tank mileage calculation
- Odometer tracking
- Expense tracking
- Maintenance/service records
- Engine oil tracking
- Repair records
- Tax token tracking
- Fitness tracking
- Insurance tracking
- Date-based reminders
- Kilometer-based reminders
- Monthly cost summary
- Fuel spending report
- Mileage report
- Cost/km
- Vehicle history timeline
- Receipt/photo attachment
- Local export
- Basic backup/restore
- Settings

## 46.2 MVP — Recommended Motorcycle Enhancements

- Chain service
- Front/rear tyre records
- Battery record
- Brake service
- Air filter
- Spark plug

---

# 47. Advanced Feature Set

Advanced releases may include:

- Cloud backup
- Auto backup
- Trip cost calculator
- Vehicle resale report
- Budgeting
- Smart maintenance suggestions
- Repeated repair detection
- Fuel forecast
- Advanced cost-of-ownership
- Vendor analytics
- Custom maintenance templates
- PDF reports
- Multi-driver support
- Commercial/CNG income tracking
- Service-center contact integration
- AI-assisted expense categorization
- OCR receipt capture
- OCR document date extraction
- Predictive maintenance suggestions
- Vehicle comparison
- Shared family vehicle access

---

# 48. Suggested Main Screens

1. Splash
2. Language Selection
3. Welcome
4. Vehicle Type
5. Add Vehicle
6. Reminder Setup
7. Home Dashboard
8. Vehicle Switcher
9. Add Menu
10. Add Fuel
11. Fuel History
12. Fuel Details
13. Mileage Dashboard
14. Add Expense
15. Expense History
16. Expense Details
17. Add Service
18. Service History
19. Service Details
20. Engine Oil
21. Add Oil Change
22. Tyres
23. Tyre Details
24. Battery
25. Battery Details
26. Add Repair
27. Repair History
28. Repair Details
29. Parts
30. Add Part
31. Documents
32. Add Document
33. Document Details
34. Reminder List
35. Reminder Details
36. Unified History
37. Reports Home
38. Monthly Report
39. Fuel Report
40. Mileage Report
41. Maintenance Report
42. Cost/km Report
43. Vendor List
44. Vendor Details
45. Vehicle Profile
46. Edit Vehicle
47. Export
48. Backup & Restore
49. Notification Settings
50. General Settings
51. Security Settings
52. About/Help

---

# 49. Key Calculations

## 49.1 Distance Between Entries

`Distance = Current odometer - Previous odometer`

## 49.2 Full Tank Mileage

`Mileage = Distance since previous full tank ÷ Liters added`

## 49.3 Fuel Cost per Kilometer

`Fuel cost/km = Fuel expense ÷ Distance travelled`

## 49.4 Total Operating Cost per Kilometer

`Operating cost/km = Selected operating expenses ÷ Distance travelled`

## 49.5 Monthly Average Mileage

Use valid mileage intervals within the selected month.

Prefer weighted calculation:

`Total valid distance ÷ Total fuel used`

rather than averaging individual mileage numbers when possible.

## 49.6 Monthly Expense

`Fuel + Maintenance + Repairs + Documents + Other selected costs`

---

# 50. Example Dashboard

## গাড়ির খাতা

**Honda CB Hornet 160R**  
Current Odometer: **24,860 km**

### This Month

| Category | Amount |
|---|---:|
| Fuel | ৳4,850 |
| Maintenance | ৳1,200 |
| Repairs | ৳800 |
| Other | ৳350 |
| **Total** | **৳7,200** |

### Driving

- Distance: **818 km**
- Fuel Used: **19.7 L**
- Average Mileage: **41.6 km/L**
- **Cost/km: ৳8.80**

### Upcoming

- Engine oil — **320 km remaining**
- Chain service — **Due in 5 days**
- Tax token — **25 days remaining**

### Quick Add

`Fuel` · `Service` · `Expense` · `Repair`

---

# 51. Privacy & Security Requirements

Because the app may store registration documents and vehicle identifiers:

- Store data securely.
- Protect sensitive local files.
- Do not expose document images on the lock screen.
- Support optional PIN/biometric lock.
- Exclude sensitive attachment content from notifications.
- Confirm before permanently deleting backups or vehicle records.

If cloud backup is added later:

- Use encrypted transport.
- Clearly explain what is uploaded.
- Provide logout/disconnect options.

---

# 52. Accessibility & Usability

- Large tap targets
- Bangla-friendly typography
- High contrast
- Clear amount formatting
- Minimal required typing
- Numeric keyboard for mileage/cost
- Icons always paired with labels for critical actions
- Avoid relying only on colors for status
- Support system font scaling where practical

---

# 53. Product Differentiators

Garir Khata should not position itself merely as an expense notebook.

Its strongest differentiators are:

1. **Bangladesh-first vehicle document tracking**
2. **Motorcycle-focused maintenance workflows**
3. **Simple Bangla interface**
4. **Full-tank mileage calculation**
5. **True cost-per-kilometer**
6. **Maintenance by both date and odometer**
7. **Unified lifetime vehicle history**
8. **Resale-friendly maintenance records**
9. **Simple enough for everyday use after every refill**

---

# 54. Recommended MVP Positioning

> **গাড়ির খরচ, মাইলেজ, সার্ভিস আর কাগজপত্রের হিসাব — সব এক জায়গায়।**

Secondary line:

> Fuel থেকে engine oil, tax token থেকে repair — Garir Khata keeps your vehicle history organized.

For motorcycle-focused marketing:

> **বাইকের তেল, মাইলেজ, সার্ভিস আর খরচ — ভুলে নয়, হিসাব করে চালান।**

---

# 55. Future Expansion Opportunities

Potential future modules:

- Vehicle marketplace/resale integration
- Workshop marketplace
- Service booking
- Insurance renewal partners
- Fuel station offers
- Smart fuel receipt scanning
- Automatic odometer capture from photo
- Bluetooth/OBD integration for supported cars
- EV charging tracking
- EV battery health
- Fleet edition
- Driver expense management
- Ride-share profitability
- Vehicle loan tracker
- Accident/claim records
- Emergency roadside information

These should remain separate from the initial focused MVP.

---

# 56. Final Recommended Product Focus

The best initial market is:

**Bangladeshi motorcycle owners who want to track fuel, mileage, servicing, engine oil, repairs, and legal document expiry dates.**

The first release should optimize the following repeated workflow:

1. User refuels.
2. Opens Garir Khata.
3. Enters odometer, liters, and amount.
4. App updates mileage and monthly fuel spend.
5. App continuously calculates cost/km.
6. When service or a legal document is approaching, the app reminds the user.
7. Over time, the user builds a complete digital history of the vehicle.

This narrow but highly useful workflow gives the app a strong reason to be used every week rather than only occasionally.
