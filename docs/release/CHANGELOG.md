# Changelog — Garir Khata

## 1.0.0+11 — Sprint 11 release candidate

### Added
- Full settings, app lock (PIN + biometrics), and privacy cover
- Attachments, CSV export, encrypted `.gkbackup` backup/restore
- Reports, unified history timeline, documents & reminders
- Production logging (debug muted in release; sensitive values sanitized)
- Android release signing template, R8/ProGuard rules, FileProvider, adaptive icons
- iOS privacy manifest and store permission copy
- Release checklist, privacy policy, Play/App Store disclosure drafts

### Fixed / hardened
- Temp export/decrypt cleanup on bootstrap
- Cloud/device backup of app-private data disabled on Android
- Localization coverage for settings & security surfaces

### Schema / formats
- Database schema version: **7**
- Backup format version: **1**
