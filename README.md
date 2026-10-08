# Garir Khata — গাড়ির খাতা

Offline-first vehicle expense, mileage, maintenance, and document tracker for Bangladesh.

**Primary target:** Motorcycle owners  
**Languages:** বাংলা + English  
**Stack:** Flutter · Riverpod · Drift/SQLite · go_router

## Docs

| Area | Path |
|---|---|
| Features | `docs/feature/` |
| Technical design | `docs/design/` |
| Sprint plan | `docs/plan/` |
| **UX & icons (source of truth)** | `docs/UX/` |
| Architecture notes | `docs/architecture/ARCHITECTURE.md` |

UI and app icons must follow designs in `docs/UX/`.

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Quality checks

```bash
dart format .
flutter analyze
flutter test
flutter build apk --debug
```

## Project layout

```text
lib/
├── app/          # bootstrap, router, theme, localization
├── core/         # database, errors, result, formatting, logging
├── features/     # feature-first modules (data/domain/application/presentation)
└── main.dart
```

## Configuration

- Android application ID: `bd.garirkhata.garir_khata` (minSdk 24)
- iOS bundle ID: `bd.garirkhata.garirKhata` (iOS 15+)
- Display name: **Garir Khata**
- Env template: `.env.example`

## Sprint status

- ✅ Sprint 1 — Project foundation & core infrastructure
- ✅ Sprint 2 — Onboarding & vehicle management
- ✅ Sprint 3 — Odometer & fuel tracking
- ✅ Sprint 4 — Mileage, expenses & dashboard
- ✅ Sprint 5 — Maintenance & engine oil
- ✅ Sprint 6 — Repairs, parts, tyres & battery
- ✅ Sprint 7 — Documents, reminders & notifications
- ✅ Sprint 8 — Reports, analytics & unified history
- ✅ Sprint 9 — Attachments, export, backup & restore
