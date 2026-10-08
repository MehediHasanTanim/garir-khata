# Garir Khata — Architecture Notes

## Overview

Offline-first Flutter app using feature-first Clean Architecture.

```text
UI → Riverpod Controllers → Use Cases → Repository Interfaces → Drift/SQLite
```

## Layers

| Layer | Responsibility |
|---|---|
| `presentation` | Widgets, screens, form controllers |
| `application` | Notifiers, orchestration, use-case wiring |
| `domain` | Entities, repository interfaces, pure business rules |
| `data` | Drift DAOs, mappers, repository implementations |

## Rules

- UI never accesses Drift / SQLite directly.
- Domain never imports Flutter widgets.
- Money and fuel quantities use fixed precision (paisa / milliliters) in later sprints.
- User-facing strings come from ARB localization only.
- Visual UX and icons must follow `docs/UX/`.

## Core stack

- Flutter + Dart
- Riverpod
- go_router (StatefulShellRoute bottom nav)
- Drift + SQLite
- SharedPreferences for lightweight preferences
- ARB localization (বাংলা + English)

## Feature module layout

```text
features/<feature>/
├── data/
├── domain/
├── application/
└── presentation/
```
