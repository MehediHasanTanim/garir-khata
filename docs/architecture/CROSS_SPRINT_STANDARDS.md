# Cross-Sprint Technical Standards

Applies to every feature sprint (see plan §17).

## 17.1 Localization

- Every user-visible string ships in **English** (`app_en.arb`) and **Bangla** (`app_bn.arb`) in the same PR.
- Prefer `context.l10n.*` over hardcoded `Text('...')`.
- After ARB changes, regenerate or patch `app_localizations*.dart` so both locales compile.
- Do not merge UI that only has English placeholders.

**Check:** EN and BN key sets must match (no `only_en` / `only_bn` keys).

## 17.2 Testing

Business-rule changes require unit tests. Priority suites:

| Area | Location |
|---|---|
| Money (paisa) | `test/core/formatting/money_precision_test.dart` |
| Mileage | `test/features/mileage/` |
| Odometer | `test/features/odometer/` |
| Reminders | `test/features/reminders/` |
| Backup / restore | `test/features/backup/` + `test/release/` |

## 17.3 Database migrations

Every schema change must include **all four**:

1. Bump `AppDatabase.schemaVersion`
2. Additive `onUpgrade` step (never silent destructive drops in production paths)
3. Migration test (old `user_version` → current)
4. Existing-data assertion (rows inserted before upgrade remain readable)

Reference: `test/release/migration_test.dart`.

## 17.4 Error handling

Async user operations return `Result<T>` and UI must handle:

| Outcome | UI |
|---|---|
| Success | Snackbar / navigate / refresh |
| Validation | Field or message from `ValidationError` |
| Storage (`DatabaseError` / `FileError`) | Localized storage failure (`errorStorageFailed`) |
| Unexpected | Localized generic (`errorUnexpected`) — never raw SQL/stack |

Helper: `lib/core/ui/async_result_feedback.dart` (`presentAsyncResult`, `userFacingErrorMessage`).

## 17.5 Analytics privacy

- Default provider is `NoOpAnalytics` (`analyticsProvider`).
- If an SDK is added, wrap it with `PrivacySafeAnalytics`.
- **Never** send: document numbers, registration numbers, attachment paths/names, private notes, PIN/password.

Scrubber + tests: `lib/core/analytics/privacy_safe_analytics.dart`, `test/core/analytics/`.
