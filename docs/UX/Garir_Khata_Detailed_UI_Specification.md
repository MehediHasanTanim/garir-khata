# Garir Khata — Detailed UI Specification
## Vehicle Expense & Maintenance Tracker

**Product:** Garir Khata — গাড়ির খাতা  
**Document Type:** Detailed UI Specification  
**Primary Platform:** Mobile  
**Primary Target:** Motorcycle owners in Bangladesh  
**Secondary Target:** Car, CNG, SUV, microbus, pickup, and other personal/light commercial vehicle owners  
**Languages:** বাংলা + English  
**Default Currency:** BDT (৳)  
**Default Distance Unit:** Kilometer  
**Default Fuel Unit:** Liter  

---

# 1. UI Design Goals

Garir Khata should feel like a simple digital vehicle notebook rather than a complex fleet-management system.

The interface should optimize for:

- Very fast entry after fuel refill or servicing
- Simple Bangla labels
- Clear cost visibility
- Minimal typing
- Easy access to upcoming maintenance
- Reliable document-expiry awareness
- Strong readability outdoors
- Comfortable one-handed use
- Clear distinction between expenses, maintenance, and legal documents

The application should support both motorcycle and car owners without making motorcycle users navigate through irrelevant car-specific complexity.

---

# 2. Core UX Principles

## 2.1 One Primary Action per Screen

Every screen should have one obvious next action.

Examples:

- Dashboard → `Add`
- Fuel History → `Add Fuel`
- Tyre List → `Add Tyre`
- Empty Documents → `Add Document`

## 2.2 Progressive Disclosure

Do not show all advanced fields initially.

Example for Add Fuel:

Always visible:

- Odometer
- Liters
- Amount
- Full tank

Expandable:

- Fuel station
- Payment method
- Note
- Receipt

## 2.3 Context-Aware Defaults

Use safe defaults:

- Current date/time
- Selected vehicle
- Previous fuel type
- Previous payment method

Never auto-fill odometer from old data as if it were current.

## 2.4 Bangla-First Readability

Bangla UI should avoid long formal sentences.

Prefer:

`জ্বালানি যোগ করুন`

Instead of overly technical translations.

## 2.5 Status by Text + Icon

Never rely only on colors.

Example:

- `Due soon`
- `Overdue`
- `Completed`

Each with icon and color.

---

# 3. App Navigation

Recommended bottom navigation:

1. **Home**
2. **History**
3. **Add**
4. **Reports**
5. **More**

Bangla:

1. **হোম**
2. **ইতিহাস**
3. **যোগ করুন**
4. **রিপোর্ট**
5. **আরও**

The `Add` item should be visually emphasized.

---

# 4. Global App Bar Patterns

## 4.1 Standard App Bar

Contains:

- Back button where applicable
- Screen title
- Optional selected vehicle chip
- Context menu if needed

## 4.2 Dashboard App Bar

Contains:

- Vehicle avatar/photo
- Vehicle nickname
- Registration number
- Vehicle switcher chevron
- Notification/reminder icon

## 4.3 Form App Bar

Contains:

- Back
- Form title
- Optional `Save` text action if bottom CTA is not used

Preferred pattern:

- Bottom sticky primary action

---

# 5. Screen Inventory

The application requires the following major screen groups:

## A. Launch & Onboarding

1. Splash
2. Language Selection
3. Welcome
4. Vehicle Type Selection
5. Add Vehicle — Basic Info
6. Add Vehicle — Registration & Technical
7. Add Vehicle — Current Odometer
8. Reminder Setup
9. Setup Complete

## B. Main Navigation

10. Home Dashboard
11. Vehicle Switcher
12. Quick Add Sheet
13. Notifications / Reminder Inbox

## C. Vehicle Management

14. Vehicle List
15. Vehicle Profile
16. Edit Vehicle
17. Archive Vehicle Confirmation

## D. Fuel & Mileage

18. Add Fuel
19. Fuel History
20. Fuel Details
21. Edit Fuel
22. Mileage Dashboard
23. Mileage Trend Details

## E. Odometer

24. Update Odometer
25. Odometer History
26. Odometer Correction Warning
27. Odometer Reset / Replacement

## F. Expenses

28. Add Expense
29. Expense History
30. Expense Details
31. Edit Expense
32. Expense Category Management

## G. Service & Maintenance

33. Add Service
34. Add Service Item
35. Service History
36. Service Details
37. Edit Service
38. Maintenance Templates
39. Maintenance Item Details

## H. Engine Oil

40. Engine Oil Overview
41. Add Oil Change
42. Oil Change History
43. Oil Change Details

## I. Tyres

44. Tyre Overview
45. Add Tyre
46. Tyre Details
47. Tyre Event
48. Replace Tyre
49. Tyre History

## J. Battery

50. Battery Overview
51. Add Battery
52. Battery Details
53. Replace Battery
54. Battery History

## K. Repairs & Parts

55. Add Repair
56. Repair History
57. Repair Details
58. Add Repair Part
59. Parts List
60. Add Part
61. Part Details

## L. Documents

62. Documents Home
63. Add Document
64. Document Details
65. Edit Document
66. Renew Document
67. Insurance Details
68. Tax Token Details
69. Fitness Details

## M. Reminders

70. Reminder List
71. Reminder Details
72. Add Reminder
73. Edit Reminder
74. Snooze Reminder
75. Complete Reminder

## N. Vendors

76. Vendor List
77. Add Vendor
78. Vendor Details
79. Edit Vendor

## O. History

80. Unified History Timeline
81. History Filters
82. History Item Details Redirect

## P. Reports

83. Reports Home
84. Monthly Expense Report
85. Yearly Expense Report
86. Fuel Report
87. Mileage Report
88. Maintenance Report
89. Repair Report
90. Document Cost Report
91. Cost per Kilometer Report
92. Ownership Cost Report

## Q. Attachments

93. Attachment Picker
94. Attachment Preview
95. Attachment Viewer

## R. Export & Backup

96. Export Data
97. Export Preview
98. Backup & Restore Home
99. Create Backup
100. Backup Progress
101. Backup Success
102. Restore Backup Picker
103. Restore Summary
104. Restore Confirmation
105. Restore Progress
106. Restore Success
107. Restore Failure

## S. Settings & Security

108. Settings Home
109. General Settings
110. Language Settings
111. Appearance Settings
112. Reminder Settings
113. Notification Settings
114. Security Settings
115. Set App PIN
116. Verify App PIN
117. Change App PIN
118. Biometric Settings
119. Data & Storage
120. About & Help

## T. Common UI States

121. Initial Loading
122. Skeleton Loading
123. Empty List
124. No Search Results
125. Save in Progress
126. Save Success
127. Save Failed
128. Delete Confirmation
129. Delete Failed
130. Unsaved Changes
131. Permission Denied
132. Notification Permission Denied
133. Invalid Odometer
134. Duplicate Fuel Warning
135. Calculation Unavailable
136. Storage Almost Full
137. Database Migration
138. Offline/No Internet for Optional Service
139. Generic Error
140. Search & Filter Sheet
141. Date Picker
142. Month Picker
143. Amount Input
144. Odometer Input
145. Confirmation Bottom Sheet

---

# 6. A. Launch & Onboarding

## 6.1 Screen 1 — Splash

### Purpose

Show brand identity while initializing:

- Local database
- Preferences
- Language
- Selected vehicle
- Reminder state

### Layout

Center:

- App icon
- `Garir Khata`
- `গাড়ির খাতা`

Bottom:

- Small loading indicator only when initialization takes noticeable time

### Behavior

Route:

- First launch → Language Selection
- Setup incomplete → Resume onboarding
- Existing user → Home

---

## 6.2 Screen 2 — Language Selection

### Header

`Choose your language`

Bangla:

`ভাষা নির্বাচন করুন`

### Options

Large cards:

- বাংলা
- English

Each card includes:

- Language name
- Sample secondary text

### Primary Action

`Continue`

### Notes

Default may follow system locale but must require confirmation on first launch.

---

## 6.3 Screen 3 — Welcome

### Hero

Simple illustration:

- Motorcycle/car
- Notebook/check mark

### Title

English:

`Your vehicle records, all in one place`

Bangla:

`গাড়ির সব হিসাব এক জায়গায়`

### Supporting Copy

`Track fuel, mileage, service, repairs, and important document dates.`

Bangla equivalent should remain concise.

### Primary CTA

`Add Vehicle`

### Secondary

`Learn More` optional

---

## 6.4 Screen 4 — Vehicle Type Selection

### Title

`What do you drive?`

### Grid

- Motorcycle
- Scooter
- Car
- SUV
- CNG
- Microbus
- Pickup
- Other

Each item:

- Icon
- Label

### Behavior

Selecting one highlights card.

### CTA

`Continue`

---

## 6.5 Screen 5 — Add Vehicle: Basic Info

### Fields

- Vehicle nickname
- Brand
- Model
- Variant
- Model year
- Fuel type
- Vehicle color
- Optional photo

### Example

Nickname:

`My Hornet`

### Primary CTA

`Continue`

### Secondary

`Skip optional fields`

---

## 6.6 Screen 6 — Registration & Technical Info

### Fields

- Registration number
- Engine capacity
- Engine number
- Chassis number
- Purchase date
- Purchase price
- Ownership type

### Privacy Note

Small inline note:

`Sensitive details are stored on your device.`

### CTA

`Continue`

---

## 6.7 Screen 7 — Current Odometer

### Main Field

Large numeric input:

`Current odometer`

Example:

`24,860 km`

### Helper

`Enter the current reading shown on your vehicle.`

### CTA

`Continue`

---

## 6.8 Screen 8 — Reminder Setup

### Title

`Set up important reminders`

### Suggested Cards

For motorcycle:

- Engine oil
- General service
- Tax token
- Insurance
- Fitness

Each:

- Toggle
- Optional interval

### Example

Engine Oil:

`Every 2,000 km or 90 days`

### CTA

`Finish Setup`

### Secondary

`Skip for now`

---

## 6.9 Screen 9 — Setup Complete

### Success Icon

### Title

`Your vehicle is ready`

### Summary

- Vehicle name
- Odometer
- Fuel type

### CTA

`Go to Dashboard`

---

# 7. B. Main Navigation

## 7.1 Screen 10 — Home Dashboard

### App Bar

- Vehicle image/avatar
- Vehicle nickname
- Registration
- Switcher chevron
- Reminder icon

### Section A — This Month

Summary card:

- Fuel
- Maintenance
- Repairs
- Other
- Total

Example:

```text
Fuel          ৳4,850
Maintenance   ৳1,200
Repairs         ৳800
Other           ৳350
---------------------
Total         ৳7,200
```

### Section B — Driving Summary

Metrics:

- Distance
- Fuel used
- Mileage
- Cost/km

### Section C — Upcoming

Cards:

- Engine oil — 320 km remaining
- Chain service — 5 days
- Tax token — 25 days

### Section D — Quick Actions

2x2 or horizontal row:

- Fuel
- Service
- Expense
- Repair

### Section E — Recent Activity

Timeline rows.

### Empty Dashboard State

If no data:

- Show setup progress
- Encourage first fuel entry

Primary:

`Add Fuel`

---

## 7.2 Screen 11 — Vehicle Switcher

Bottom sheet.

### Header

`Select Vehicle`

### Vehicle Rows

- Photo/icon
- Nickname
- Model
- Registration
- Current odometer
- Selected checkmark

### Bottom Action

`Add New Vehicle`

---

## 7.3 Screen 12 — Quick Add Sheet

Large bottom sheet.

### Options

- Add Fuel
- Add Expense
- Add Service
- Add Repair
- Update Odometer
- Add Document
- Add Reminder

Use icons and labels.

Motorcycle users should see fuel first.

---

## 7.4 Screen 13 — Reminder Inbox

### Tabs

- Due
- Upcoming
- Completed

### Reminder Row

- Icon
- Title
- Vehicle
- Due state
- Remaining km/days

Swipe or menu:

- Complete
- Snooze

---

# 8. C. Vehicle Management

## 8.1 Screen 14 — Vehicle List

### Header

`My Vehicles`

### Card Content

- Image
- Nickname
- Brand/model
- Registration
- Odometer
- Monthly spending

### Actions

Overflow:

- Edit
- Archive

### FAB

`Add Vehicle`

---

## 8.2 Screen 15 — Vehicle Profile

### Header

Vehicle image + nickname.

### Summary

- Registration
- Type
- Fuel
- Odometer

### Sections

#### Details

- Brand
- Model
- Year
- Engine capacity

#### Ownership

- Purchase date
- Purchase price

#### Technical

- Engine number
- Chassis number

#### Quick Links

- Documents
- Service History
- Expenses
- Tyres
- Battery

### Actions

- Edit
- Archive

---

## 8.3 Screen 16 — Edit Vehicle

Same fields as onboarding.

Sticky action:

`Save Changes`

Warn on unsaved changes.

---

## 8.4 Screen 17 — Archive Vehicle Confirmation

### Title

`Archive this vehicle?`

### Explanation

History will remain available but the vehicle will no longer appear in active lists.

### Actions

- Cancel
- Archive

---

# 9. D. Fuel & Mileage

## 9.1 Screen 18 — Add Fuel

### Top

Selected vehicle chip.

### Required Fields

1. Odometer
2. Fuel quantity
3. Total amount
4. Full tank toggle

### Optional Visible Fields

- Price per liter
- Fuel type

### Expandable Section

`More details`

- Fuel station
- Location
- Payment method
- Notes
- Receipt

### Auto Calculations

If user enters liters + amount:

Show:

`Price/L: ৳130.00`

If liters + price:

Show:

`Total: ৳1,170`

### Full Tank Toggle

Label:

`Filled to full tank`

Helper:

`Use full-tank entries for more accurate mileage.`

### Sticky CTA

`Save Fuel Entry`

---

## 9.2 Screen 19 — Fuel History

### Header

- Title
- Month filter
- Search/filter icon

### Summary

At top:

- Total fuel spend
- Total liters
- Avg price/L
- Avg mileage

### List Row

- Date
- Odometer
- Liters
- Total
- Mileage if available
- Full tank badge

### FAB

`Add Fuel`

---

## 9.3 Screen 20 — Fuel Details

### Summary

- Date/time
- Odometer
- Liters
- Total

### Calculated

- Price/L
- Distance since prior full tank
- Mileage
- Fuel cost/km

### Additional

- Station
- Payment
- Note
- Receipt

### Actions

- Edit
- Delete

---

## 9.4 Screen 21 — Edit Fuel

Same as Add Fuel.

If editing affects mileage:

Inline warning:

`This change may update mileage calculations for nearby fuel entries.`

---

## 9.5 Screen 22 — Mileage Dashboard

### Hero Metric

`Average Mileage`

Example:

`41.6 km/L`

### Comparison

`+5.4% vs last month`

### Cards

- Latest
- 30-day
- 90-day
- Lifetime
- Best
- Lowest

### Chart

Mileage trend over time.

### CTA

`View Fuel History`

---

## 9.6 Screen 23 — Mileage Trend Details

### Filters

- 30 days
- 3 months
- 6 months
- 1 year
- All

### Chart

Mileage per full-tank interval.

### List Below

- Date
- Distance
- Fuel
- Mileage

---

# 10. E. Odometer

## 10.1 Screen 24 — Update Odometer

Large numeric field.

Show current:

`Current: 24,860 km`

New:

`New reading`

Optional note.

CTA:

`Update`

---

## 10.2 Screen 25 — Odometer History

Timeline:

- Date
- Reading
- Source
- Difference

Source examples:

- Fuel
- Service
- Manual

---

## 10.3 Screen 26 — Invalid Odometer Warning

### Title

`This reading is lower than the previous reading`

Show:

- Previous: 24,860 km
- Entered: 14,200 km

Actions:

- Correct value
- Odometer was reset/replaced
- Cancel

---

## 10.4 Screen 27 — Odometer Reset / Replacement

Fields:

- Date
- Old reading
- New reading
- Reason
- Note

Warning:

`Distance reports will treat this as a new odometer segment.`

CTA:

`Confirm Reset`

---

# 11. F. Expenses

## 11.1 Screen 28 — Add Expense

Fields:

- Date
- Category
- Amount
- Odometer optional
- Description
- Vendor optional
- Payment method
- Notes
- Attachment

CTA:

`Save Expense`

---

## 11.2 Screen 29 — Expense History

### Summary

Current month total.

### Filters

- Month
- Category
- Amount
- Vendor

### Row

- Category icon
- Description
- Date
- Amount

---

## 11.3 Screen 30 — Expense Details

Show:

- Category
- Amount
- Date
- Odometer
- Vendor
- Description
- Note
- Attachment

Actions:

- Edit
- Delete

---

## 11.4 Screen 31 — Edit Expense

Same as add form.

If auto-generated from fuel/service:

Show notice:

`This expense is linked to a fuel/service record.`

Prefer redirect to source record for editing.

---

## 11.5 Screen 32 — Expense Category Management

List:

- System categories
- Custom categories

Actions:

- Add custom category
- Rename custom category
- Disable custom category

System categories cannot be deleted.

---

# 12. G. Service & Maintenance

## 12.1 Screen 33 — Add Service

### Fields

- Date
- Odometer
- Workshop
- Service items
- Labor cost
- Parts cost
- Total
- Next due date
- Next due odometer
- Notes
- Invoice

### CTA

`Save Service`

---

## 12.2 Screen 34 — Add Service Item

Bottom sheet.

### Search

`Search maintenance item`

### Suggested Motorcycle Items

- Engine oil
- Chain lubrication
- Brake
- Air filter
- Spark plug
- General service

### Custom

`Add custom service item`

---

## 12.3 Screen 35 — Service History

### Filter

- All
- Routine
- Repairs excluded
- Date range

### Row

- Date
- Odometer
- Primary item
- Additional item count
- Cost
- Workshop

---

## 12.4 Screen 36 — Service Details

### Header

Date + total.

### Sections

- Service items
- Labor
- Parts
- Workshop
- Odometer
- Next due
- Notes
- Invoice

Actions:

- Edit
- Repeat Service
- Delete

---

## 12.5 Screen 37 — Edit Service

Same form.

Warn:

`Updating cost will also update the linked expense.`

---

## 12.6 Screen 38 — Maintenance Templates

Sections:

### Motorcycle

- Engine oil
- Chain
- Brake
- Air filter
- Spark plug
- Tyres

### Car

- Engine oil
- Filters
- AC
- Wheel alignment
- Coolant

Users can:

- Enable
- Disable
- Customize intervals

---

## 12.7 Screen 39 — Maintenance Item Details

Show:

- Current interval
- Last completed
- Next due
- History
- Reminder settings

Actions:

- Record Maintenance
- Edit Interval

---

# 13. H. Engine Oil

## 13.1 Screen 40 — Engine Oil Overview

### Hero

`Next Oil Change`

Example:

`320 km remaining`

Secondary:

`or 18 days`

### Current Oil

- Brand
- Product
- Viscosity
- Installed at
- Date

### CTA

`Record Oil Change`

### History Preview

Last 3 records.

---

## 13.2 Screen 41 — Add Oil Change

Fields:

- Date
- Odometer
- Brand
- Product
- Viscosity
- Quantity
- Cost
- Filter changed
- Workshop
- Next due km
- Next due date
- Notes
- Receipt

CTA:

`Save Oil Change`

---

## 13.3 Screen 42 — Oil Change History

Rows:

- Date
- Odometer
- Product
- Cost
- Interval since previous

---

## 13.4 Screen 43 — Oil Change Details

Show all fields plus:

- Distance since previous oil change
- Days since previous
- Next due

Actions:

- Edit
- Delete

---

# 14. I. Tyres

## 14.1 Screen 44 — Tyre Overview

For motorcycle:

Two large cards:

- Front Tyre
- Rear Tyre

Each:

- Brand
- Model
- Age
- Distance used
- Status

For cars:

Use 4-position layout plus spare.

### CTA

`Add / Replace Tyre`

---

## 14.2 Screen 45 — Add Tyre

Fields:

- Position
- Brand
- Model
- Size
- Purchase date
- Install date
- Install odometer
- Cost
- Warranty
- Vendor
- Notes
- Receipt

---

## 14.3 Screen 46 — Tyre Details

Show:

- Position
- Brand/model
- Size
- Install date
- Distance used
- Age
- Warranty
- History

Actions:

- Inspect
- Repair
- Replace

---

## 14.4 Screen 47 — Tyre Event

Event type:

- Inspection
- Repair
- Rotation
- Removed

Fields depend on event.

---

## 14.5 Screen 48 — Replace Tyre

Show old tyre summary.

New tyre form.

On save:

- Mark old as replaced
- Create new active tyre
- Record event
- Create expense if cost entered

---

## 14.6 Screen 49 — Tyre History

Timeline per position.

---

# 15. J. Battery

## 15.1 Screen 50 — Battery Overview

### Current Battery Card

- Brand/model
- Installed date
- Age
- Warranty
- Install odometer
- Status

CTA:

`Replace Battery`

---

## 15.2 Screen 51 — Add Battery

Fields:

- Brand
- Model
- Specification
- Purchase date
- Install date
- Install odometer
- Cost
- Warranty
- Vendor
- Notes
- Receipt

---

## 15.3 Screen 52 — Battery Details

Show:

- Age
- Warranty remaining
- Cost
- Install odometer
- Vendor
- Notes

---

## 15.4 Screen 53 — Replace Battery

Old battery summary + new form.

On save:

- Mark old removed
- Add replacement
- Create linked expense

---

## 15.5 Screen 54 — Battery History

Chronological list.

---

# 16. K. Repairs & Parts

## 16.1 Screen 55 — Add Repair

Fields:

- Date
- Odometer
- Category
- Problem
- Diagnosis
- Repair performed
- Workshop
- Labor
- Parts
- Total
- Warranty
- Follow-up
- Notes
- Photos/invoice

CTA:

`Save Repair`

---

## 16.2 Screen 56 — Repair History

Rows:

- Date
- Category
- Problem
- Cost
- Workshop

Filter:

- Category
- Date
- Workshop

---

## 16.3 Screen 57 — Repair Details

Sections:

- Problem
- Diagnosis
- Repair performed
- Parts
- Labor
- Total
- Warranty
- Follow-up
- Attachments

Actions:

- Edit
- Repeat/Follow-up
- Delete

---

## 16.4 Screen 58 — Add Repair Part

Fields:

- Name
- Brand
- Part number
- Quantity
- Unit cost
- Warranty

---

## 16.5 Screen 59 — Parts List

List installed/replaced parts.

Tabs:

- Active
- History

---

## 16.6 Screen 60 — Add Part

Fields:

- Part name
- Category
- Brand
- Part number
- Install date
- Odometer
- Cost
- Vendor
- Warranty
- Replacement interval
- Notes

---

## 16.7 Screen 61 — Part Details

Show:

- Current status
- Install date
- Distance used
- Warranty
- Replacement due

---

# 17. L. Vehicle Documents

## 17.1 Screen 62 — Documents Home

### Summary Cards

- Tax Token
- Fitness
- Insurance
- Registration

Each card shows:

- Status
- Expiry
- Days remaining

### Additional Documents

List below.

CTA:

`Add Document`

---

## 17.2 Screen 63 — Add Document

First step:

Select type.

Then dynamic form.

Common fields:

- Document number
- Issue date
- Expiry date
- Fee
- Authority/provider
- Notes
- Attachment
- Reminder lead time

---

## 17.3 Screen 64 — Document Details

Show:

- Document type
- Number
- Issue date
- Expiry
- Remaining days
- Provider
- Fee
- Attachment
- Reminder status

Actions:

- Edit
- Renew
- Delete

---

## 17.4 Screen 65 — Edit Document

Same dynamic form.

---

## 17.5 Screen 66 — Renew Document

Show current document summary.

Fields:

- New issue date
- New expiry date
- Fee
- Updated number if applicable
- New attachment

On save:

- Preserve renewal history

---

## 17.6 Screen 67 — Insurance Details

Extra fields:

- Provider
- Policy number
- Coverage
- Premium
- Contact
- Start/end

---

## 17.7 Screen 68 — Tax Token Details

Extra:

- Token/reference
- Amount
- Issue/expiry
- Authority

---

## 17.8 Screen 69 — Fitness Details

Extra:

- Certificate/reference
- Issue/expiry
- Fee

---

# 18. M. Reminders

## 18.1 Screen 70 — Reminder List

Tabs:

- Due
- Upcoming
- Completed

Rows:

- Icon
- Title
- Vehicle
- Remaining days/km
- Status

---

## 18.2 Screen 71 — Reminder Details

Show:

- Reminder title
- Related item
- Due date
- Due odometer
- Remaining
- Recurrence
- Notification status

Actions:

- Complete
- Snooze
- Edit

---

## 18.3 Screen 72 — Add Reminder

Fields:

- Title
- Type
- Related vehicle
- Related entity optional
- Due date
- Due odometer
- Advance days
- Advance km
- Repeat
- Notification

CTA:

`Save Reminder`

---

## 18.4 Screen 73 — Edit Reminder

Same form.

---

## 18.5 Screen 74 — Snooze Reminder

Options:

- Tomorrow
- 3 days
- 7 days
- 100 km
- Custom

---

## 18.6 Screen 75 — Complete Reminder

Confirmation:

`Mark this maintenance as completed?`

Option:

`Add service record now`

---

# 19. N. Vendors

## 19.1 Screen 76 — Vendor List

Tabs/filter:

- Workshop
- Fuel station
- Parts
- Tyre
- Battery
- Insurance

Row:

- Name
- Type
- Last visit
- Total spent

---

## 19.2 Screen 77 — Add Vendor

Fields:

- Name
- Type
- Phone
- Address
- Contact person
- Notes
- Favorite

---

## 19.3 Screen 78 — Vendor Details

Show:

- Contact
- Visit count
- Total spend
- Recent records

Actions:

- Call
- Edit

---

## 19.4 Screen 79 — Edit Vendor

Same form.

---

# 20. O. Unified History

## 20.1 Screen 80 — History Timeline

Chronological feed.

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

Each item:

- Icon
- Title
- Date
- Odometer
- Amount if any
- Summary

---

## 20.2 Screen 81 — History Filters

Bottom sheet.

Filters:

- Date range
- Record type
- Expense category
- Vehicle
- Vendor

Actions:

- Apply
- Clear

---

## 20.3 Screen 82 — History Item Redirect

Selecting a timeline row opens the corresponding detail screen.

---

# 21. P. Reports

## 21.1 Screen 83 — Reports Home

Cards:

- Monthly Expense
- Fuel
- Mileage
- Maintenance
- Repairs
- Documents
- Cost/km
- Ownership Cost

Top selector:

- Vehicle
- Period

---

## 21.2 Screen 84 — Monthly Expense Report

### Hero

`Total this month`

### Breakdown

- Fuel
- Maintenance
- Repairs
- Documents
- Other

### Chart

Category breakdown.

### Comparison

`+12% vs last month`

---

## 21.3 Screen 85 — Yearly Expense Report

Show:

- Annual total
- Monthly average
- Highest month
- Monthly bar chart

---

## 21.4 Screen 86 — Fuel Report

Metrics:

- Total spend
- Liters
- Avg price/L
- Avg mileage
- Fuel cost/km

Charts:

- Fuel spend by month
- Fuel price trend

---

## 21.5 Screen 87 — Mileage Report

Metrics:

- Latest
- 30-day
- 90-day
- Lifetime
- Best
- Lowest

Chart:

- Trend

---

## 21.6 Screen 88 — Maintenance Report

Metrics:

- Total maintenance
- Service count
- Average service cost
- Top maintenance categories

---

## 21.7 Screen 89 — Repair Report

Metrics:

- Total repair
- Repair count
- Top categories
- Repeat issue hint

---

## 21.8 Screen 90 — Document Cost Report

Show:

- Tax token
- Fitness
- Insurance
- Registration-related cost

---

## 21.9 Screen 91 — Cost per Kilometer Report

Tabs:

- Fuel-only
- Operating cost
- Custom

Show:

- Distance
- Included expenses
- Total
- Cost/km

Formula info link:

`How this is calculated`

---

## 21.10 Screen 92 — Ownership Cost Report

Advanced.

Show:

- Fuel
- Maintenance
- Repair
- Documents
- Accessories
- Purchase cost optional

---

# 22. Q. Attachments

## 22.1 Screen 93 — Attachment Picker

Bottom sheet:

- Take Photo
- Choose Photo
- Choose File

---

## 22.2 Screen 94 — Attachment Preview

Show image/file preview.

Actions:

- Use This File
- Retake/Choose Again

---

## 22.3 Screen 95 — Attachment Viewer

Full-screen.

Actions:

- Share
- Rename label
- Delete

For sensitive docs:

Avoid exposing file path.

---

# 23. R. Export & Backup

## 23.1 Screen 96 — Export Data

Options:

- Fuel
- Expenses
- Maintenance
- Repairs
- Documents
- Full History

Format:

- CSV
- PDF summary when supported

Filters:

- Vehicle
- Date range

CTA:

`Export`

---

## 23.2 Screen 97 — Export Preview

Show:

- Record count
- Date range
- Vehicle
- Format

CTA:

`Create Export`

---

## 23.3 Screen 98 — Backup & Restore Home

Cards:

- Create Backup
- Restore Backup
- Backup History

Show last backup date.

---

## 23.4 Screen 99 — Create Backup

Options:

- Include attachments toggle
- Backup location
- Encryption info

CTA:

`Create Backup`

---

## 23.5 Screen 100 — Backup Progress

Show:

- Preparing database
- Adding files
- Encrypting
- Finalizing

Progress indicator.

---

## 23.6 Screen 101 — Backup Success

Show:

- Backup filename
- Date
- Size

Actions:

- Share/Save
- Done

---

## 23.7 Screen 102 — Restore Backup Picker

File selection.

Helper:

`Choose a Garir Khata backup file.`

---

## 23.8 Screen 103 — Restore Summary

Show:

- Backup date
- App version
- Vehicles
- Attachments
- Schema version

Warnings if old backup.

---

## 23.9 Screen 104 — Restore Confirmation

Strong warning:

`Restoring may replace current local data.`

Checkbox:

`I understand`

CTA:

`Restore`

---

## 23.10 Screen 105 — Restore Progress

Stages:

- Validating
- Safety backup
- Restoring
- Migrating
- Rebuilding reminders

---

## 23.11 Screen 106 — Restore Success

Show summary.

CTA:

`Go to Dashboard`

---

## 23.12 Screen 107 — Restore Failure

Show:

- Friendly explanation
- No data was changed if rollback succeeded

Actions:

- Retry
- Choose another backup
- Cancel

---

# 24. S. Settings & Security

## 24.1 Screen 108 — Settings Home

Sections:

- General
- Appearance
- Reminders
- Notifications
- Security
- Data & Storage
- About

---

## 24.2 Screen 109 — General Settings

Items:

- Currency
- Distance unit
- Fuel unit
- Date format
- Default vehicle

---

## 24.3 Screen 110 — Language Settings

Options:

- বাংলা
- English

Immediate preview if possible.

---

## 24.4 Screen 111 — Appearance Settings

Options:

- System
- Light
- Dark

Optional:

- Larger text preference
- High contrast

---

## 24.5 Screen 112 — Reminder Settings

Defaults:

- Document reminder lead days
- Service reminder lead km
- Service reminder lead days

---

## 24.6 Screen 113 — Notification Settings

Toggles:

- Maintenance
- Document expiry
- Backup reminders

Show system permission state.

---

## 24.7 Screen 114 — Security Settings

Items:

- App PIN
- Biometrics
- Auto-lock
- Hide sensitive preview

---

## 24.8 Screen 115 — Set App PIN

4–6 digit numeric PIN.

Steps:

- Enter
- Confirm

---

## 24.9 Screen 116 — Verify App PIN

Centered lock screen.

- PIN keypad
- Biometrics shortcut

---

## 24.10 Screen 117 — Change App PIN

- Verify old
- Enter new
- Confirm

---

## 24.11 Screen 118 — Biometric Settings

Show:

- Device support
- Enable/disable

---

## 24.12 Screen 119 — Data & Storage

Show:

- Database size
- Attachment size
- Backup history

Actions:

- Export
- Backup
- Restore
- Clear temporary files
- Delete all data

---

## 24.13 Screen 120 — About & Help

Sections:

- App version
- Help
- Privacy
- Open-source licenses
- Contact/support if available

---

# 25. T. Common UI States

## 25.1 Screen 121 — Initial Loading

Use centered app mark + minimal progress.

Do not show long blocking loader for normal local reads.

---

## 25.2 Screen 122 — Skeleton Loading

Use skeletons matching final layout.

Examples:

- Dashboard cards
- Fuel rows
- Report cards

---

## 25.3 Screen 123 — Empty List

Pattern:

- Simple icon
- Clear title
- One-sentence explanation
- Primary action

Example:

`No fuel records yet`

`Add your first refill to start tracking mileage.`

---

## 25.4 Screen 124 — No Search Results

Show search term.

Actions:

- Clear search
- Clear filters

---

## 25.5 Screen 125 — Save in Progress

Prefer inline disabled CTA with spinner.

Prevent duplicate submit.

---

## 25.6 Screen 126 — Save Success

Prefer snackbar:

`Saved successfully`

Avoid modal for routine success.

---

## 25.7 Screen 127 — Save Failed

Message:

`We couldn't save this record.`

Actions:

- Retry
- Cancel

Preserve user input.

---

## 25.8 Screen 128 — Delete Confirmation

Use destructive confirmation.

Title:

`Delete this record?`

Show consequence.

Actions:

- Cancel
- Delete

---

## 25.9 Screen 129 — Delete Failed

Message:

`This record could not be deleted.`

Action:

`Retry`

---

## 25.10 Screen 130 — Unsaved Changes

Title:

`Discard changes?`

Actions:

- Keep Editing
- Discard

---

## 25.11 Screen 131 — Permission Denied

Explain why permission is needed.

Actions:

- Open Settings
- Not Now

---

## 25.12 Screen 132 — Notification Permission Denied

Message:

`Reminders will still appear in the app, but system notifications are turned off.`

CTA:

`Open Settings`

---

## 25.13 Screen 133 — Invalid Odometer

Display previous vs entered.

Actions:

- Correct
- Record reset/replacement

---

## 25.14 Screen 134 — Duplicate Fuel Warning

Show similar existing record.

Actions:

- Review Existing
- Save Anyway
- Cancel

---

## 25.15 Screen 135 — Calculation Unavailable

Example:

`Not enough full-tank entries to calculate mileage yet.`

Provide next step:

`Add another full-tank refill.`

---

## 25.16 Screen 136 — Storage Almost Full

Message:

`Your device is running low on storage.`

Actions:

- Review Attachments
- Continue

---

## 25.17 Screen 137 — Database Migration

Title:

`Updating your data`

Do not allow force-close actions inside UI.

Show progress if measurable.

---

## 25.18 Screen 138 — Offline / Optional Service Unavailable

Only for future cloud/OCR/AI features.

Message:

`This feature needs internet access.`

Core app remains usable.

---

## 25.19 Screen 139 — Generic Error

Message:

`Something went wrong.`

Actions:

- Retry
- Go Back

Show error code only in expandable diagnostics if needed.

---

## 25.20 Screen 140 — Search & Filter Sheet

Reusable bottom sheet.

Sections depend on module.

Common:

- Date
- Type
- Category
- Vendor

Actions:

- Reset
- Apply

---

## 25.21 Screen 141 — Date Picker

Use platform-appropriate date picker.

For expiry:

Show selected date + remaining days after selection.

---

## 25.22 Screen 142 — Month Picker

Grid/list of months.

Used in:

- Reports
- Expenses
- Fuel

---

## 25.23 Screen 143 — Amount Input

Requirements:

- Numeric keyboard
- `৳` prefix
- Thousand separators
- Decimal when needed
- No negative unless adjustment use-case supports it

---

## 25.24 Screen 144 — Odometer Input

Requirements:

- Numeric keyboard
- `km` suffix
- Current reading shown
- Difference from previous shown after entry

---

## 25.25 Screen 145 — Confirmation Bottom Sheet

Reusable for:

- Archive
- Complete reminder
- Mark replaced
- Reset maintenance interval

---

# 26. Reusable Components

## 26.1 Vehicle Selector

Compact top-bar chip.

Shows:

- Icon/photo
- Nickname
- Chevron

---

## 26.2 Summary Metric Card

Contains:

- Label
- Main value
- Comparison/subtitle

Used for:

- Mileage
- Fuel
- Cost/km
- Distance

---

## 26.3 Expense Summary Card

Contains:

- Total
- Category breakdown
- Month label

---

## 26.4 Reminder Card

Contains:

- Icon
- Title
- Remaining amount
- Status chip
- Optional action

---

## 26.5 Timeline Row

Contains:

- Type icon
- Title
- Subtitle
- Date
- Odometer
- Amount

---

## 26.6 Status Chip

Statuses:

- Upcoming
- Due soon
- Due
- Overdue
- Completed
- Expired
- Active
- Archived

---

## 26.7 Amount Row

Left:

Description

Right:

Amount

Optional secondary:

Category/date

---

## 26.8 Odometer Badge

Example:

`24,860 km`

Used in:

- Fuel
- Service
- Repair
- History

---

## 26.9 Attachment Tile

Shows:

- Thumbnail/type icon
- File label
- Size
- Menu

---

## 26.10 Empty State Component

Configurable:

- Icon
- Title
- Description
- CTA

---

# 27. Form Design Standards

## 27.1 Required Fields

Mark with `*` only where necessary.

Do not overload users with mandatory fields.

## 27.2 Numeric Inputs

Use numeric keyboard.

Examples:

- Amount
- Liters
- Odometer

## 27.3 Auto-Calculated Fields

Clearly label:

`Calculated`

Examples:

- Price/L
- Total cost
- Cost/km

## 27.4 Optional Sections

Use collapsible:

`More details`

## 27.5 Save Pattern

Sticky bottom CTA for long forms.

---

# 28. Search Behavior

Search should match:

- Titles
- Vendor names
- Notes
- Categories
- Part names

For vehicle history:

Search field at top.

Filter icon next to it.

---

# 29. Notification UX

Notification text should be concise.

Examples:

## Engine Oil

`Engine oil due soon`

`About 200 km remaining.`

Bangla:

`ইঞ্জিন অয়েল বদলানোর সময় কাছাকাছি`

`আর প্রায় ২০০ কিমি বাকি।`

## Tax Token

`Tax token expires in 7 days`

Bangla:

`Tax token-এর মেয়াদ ৭ দিনের মধ্যে শেষ হবে`

Tapping opens the relevant detail screen.

---

# 30. Bangla UI Recommendations

Use familiar localized terms.

Recommended:

| English | Bangla |
|---|---|
| Fuel | জ্বালানি |
| Mileage | মাইলেজ |
| Service | সার্ভিস |
| Maintenance | রক্ষণাবেক্ষণ |
| Engine Oil | ইঞ্জিন অয়েল |
| Repair | মেরামত |
| Tyre | টায়ার |
| Battery | ব্যাটারি |
| Documents | কাগজপত্র |
| Expense | খরচ |
| Reminder | রিমাইন্ডার |
| Odometer | ওডোমিটার |
| Cost/km | প্রতি কিমি খরচ |
| History | ইতিহাস |
| Reports | রিপোর্ট |
| Settings | সেটিংস |
| Save | সংরক্ষণ |
| Delete | মুছুন |
| Cancel | বাতিল |
| Add | যোগ করুন |

Avoid forcing fully translated technical automotive terms when users commonly know the English word.

---

# 31. Accessibility Requirements

All screens must support:

- System font scaling
- Screen-reader labels
- Minimum touch target size
- High text contrast
- Error text in addition to color
- Icon + label for critical actions
- Logical focus order
- Accessible form validation

---

# 32. Dark Mode Requirements

Dark theme should preserve:

- Readable Bangla typography
- Distinct cards
- Visible status chips
- Charts with sufficient contrast
- Clear destructive actions

No information should depend on subtle background shade only.

---

# 33. Motorcycle-Specific UI Behavior

For motorcycle users, prioritize:

Dashboard shortcuts:

1. Fuel
2. Engine Oil
3. Service
4. Repair

Maintenance templates:

- Chain
- Front tyre
- Rear tyre
- Brake
- Spark plug

Tyre UI:

Only show front and rear.

Avoid car-specific items unless user manually enables them.

---

# 34. Car-Specific UI Behavior

For car users, include:

- Four-wheel tyre positions
- Spare tyre
- AC service
- Wheel alignment
- Cabin filter
- Transmission oil

Dashboard priority may remain:

1. Fuel
2. Service
3. Expense
4. Repair

---

# 35. Dashboard Information Priority

Order from most important:

1. Vehicle
2. This month's cost
3. Distance/mileage
4. Upcoming maintenance
5. Documents
6. Quick actions
7. Recent history

Avoid placing charts directly on the dashboard if they make the page feel dense.

Detailed charts belong in Reports.

---

# 36. UX for Insufficient Data

Do not show zero for metrics that cannot yet be calculated.

Bad:

`Mileage: 0 km/L`

Good:

`Mileage: Not enough data`

Supporting text:

`Add another full-tank refill to calculate mileage.`

---

# 37. UX for Estimated Data

Any forecast must be labeled:

`Estimated`

Example:

`Estimated fuel cost next month: ৳5,100`

Avoid presenting forecasts as exact.

---

# 38. UX for Linked Records

When an expense is auto-generated from:

- Fuel
- Service
- Repair
- Oil
- Tyre
- Battery
- Document renewal

Expense detail should show:

`Linked to: Fuel Entry`

Tap opens source.

Editing should generally happen at source to prevent inconsistency.

---

# 39. UX for Sensitive Documents

For screens containing:

- Engine number
- Chassis number
- Insurance number
- Registration documents

Optional privacy actions:

- Hide/show value
- App lock requirement
- Avoid displaying values in notifications

---

# 40. Recommended MVP Screen Priority

For first production MVP, the highest priority screens are:

1. Splash
2. Language Selection
3. Welcome
4. Vehicle Type
5. Add Vehicle
6. Current Odometer
7. Home Dashboard
8. Vehicle Switcher
9. Quick Add
10. Add Fuel
11. Fuel History
12. Fuel Details
13. Mileage Dashboard
14. Update Odometer
15. Add Expense
16. Expense History
17. Add Service
18. Service History
19. Engine Oil Overview
20. Add Oil Change
21. Add Repair
22. Repair History
23. Tyre Overview
24. Battery Overview
25. Documents Home
26. Add Document
27. Reminder List
28. Reminder Details
29. History Timeline
30. Reports Home
31. Monthly Expense Report
32. Fuel Report
33. Mileage Report
34. Cost/km Report
35. Export
36. Backup & Restore
37. Settings
38. Security
39. Common States

---

# 41. Final UX Goal

A typical motorcycle owner's most frequent journey should require very little effort:

```text
Open app
→ Tap Add
→ Tap Fuel
→ Enter odometer
→ Enter liters
→ Enter amount
→ Save
```

The app should then automatically update:

- Odometer
- Fuel spending
- Monthly total
- Mileage when possible
- Cost/km
- Relevant reminders
- Vehicle history

The UI should make Garir Khata feel like a trustworthy, lightweight personal vehicle notebook that gradually becomes more valuable as the user records more history.
