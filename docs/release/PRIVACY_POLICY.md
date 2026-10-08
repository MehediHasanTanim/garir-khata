# Privacy Policy — Garir Khata / গাড়ির খাতা

**Last updated:** 2026-10-08  
**App:** Garir Khata (`bd.garirkhata.garir_khata` / `bd.garirkhata.garirKhata`)

## Summary

Garir Khata is an **offline-first** vehicle expense and maintenance tracker. Your vehicle data is stored **on your device**. We do not operate a cloud account system for this MVP.

## Data we store on your device

- Vehicle profiles (nickname, type, odometer, optional registration details you enter)
- Fuel, expense, service, oil, repair, tyre, battery, and document records
- Reminder schedules and notification preferences
- Attachments (photos/files) you add
- Optional app-lock PIN (stored as a salted hash in platform secure storage) and biometric unlock preference
- Backups you explicitly create (`.gkbackup`), optionally password-encrypted

## Data we do not collect

- No analytics SDKs in this release
- No advertising identifiers
- No crash reporter account linking in this release
- No automatic upload of your khata to our servers

## Permissions

| Permission | Why |
|---|---|
| Notifications | Maintenance / document / backup reminders you enable |
| Camera / photos | Attach receipts and documents |
| Biometrics / Face ID | Optional unlock when app lock is enabled |
| Files (share / pick) | Export CSV and create/restore backups you choose |

## Sharing

You may **export** CSV or **share** backups using the system share sheet. That content leaves the app only when **you** choose a destination (email, Drive, Files, etc.).

## Security

- SQLite database and attachment files live in app-private storage
- Android cloud backup of app data is disabled
- Optional backup password uses authenticated encryption (AES-GCM)
- PIN is never stored in plain text

## Children’s privacy

The app is not directed at children under 13.

## Contact

For privacy questions about this app, contact the publisher listed on the store listing page for Garir Khata.

## Changes

We may update this policy when features change. Material changes will be reflected in the in-app About section and store listing.
