# App Store Connect — App Privacy (draft)

## Data Not Linked to You / Not Collected

For App Store Connect **App Privacy**:

- **Tracking:** No
- **Data Used to Track You:** None
- **Data Linked to You:** None
- **Data Not Linked to You:** None collected by the developer

### On-device only (do not list as collected unless Apple’s form requires “product interaction” for local storage)

The app stores vehicle logs, optional PIN hash, and user-selected attachments **on device**. No developer-operated analytics or account.

## Permission strings (Info.plist)

Already set:

- Face ID — unlock
- Camera / Photo Library — receipts & documents
- Notifications — reminders

## Encryption export compliance

`ITSAppUsesNonExemptEncryption` = **false** (standard HTTPS not used for developer backend; backup encryption is user-controlled local crypto exempt for most App Store flows — confirm with counsel if needed).
