# Sprint 11 — Release checklist

Version: **1.0.0+11**  
Schema: **7** · Backup format: **1**

## Build & identity

- [x] `pubspec.yaml` version / build number set
- [x] `ReleaseInfo` mirrors version, schema, backup format
- [x] Android applicationId `bd.garirkhata.garir_khata`
- [x] iOS bundle id `bd.garirkhata.garirKhata`
- [ ] Upload keystore created; `android/key.properties` filled (never committed)
- [ ] iOS signing & provisioning profiles configured in Xcode / CI

## Android

- [x] Release signingConfig wired (falls back to debug if no key.properties)
- [x] R8 / ProGuard rules reviewed
- [x] Adaptive + legacy launcher icons from `docs/UX/Icon-1.png`
- [x] FileProvider paths for share/export
- [x] `allowBackup=false` + data extraction rules
- [x] Notification + biometric permissions declared
- [ ] `flutter build appbundle --release` smoke build
- [ ] Play Console data safety submitted (`PLAY_STORE_DATA_SAFETY.md`)

## iOS

- [x] App icons refreshed from UX icon
- [x] Info.plist permission strings
- [x] PrivacyInfo.xcprivacy bundled
- [x] File sharing / document browser disabled
- [ ] `flutter build ipa` / Archive smoke build
- [ ] App Store privacy answers submitted (`APP_STORE_PRIVACY.md`)

## Quality

- [x] Full regression journey test (`test/release/full_regression_journey_test.dart`)
- [x] Migration tests (`test/release/migration_test.dart`)
- [x] Large dataset perf smoke (`test/release/large_dataset_perf_test.dart`)
- [ ] Manual device pass of Sprint 11 §16.1 scenarios
- [x] Localization EN + BN for settings / security
- [x] Production logging: debug muted in release; PIN/password sanitization
- [ ] No open blocker / critical security bugs

## Store copy

- [x] Privacy policy draft (`PRIVACY_POLICY.md`)
- [x] Changelog (`CHANGELOG.md`)
- [x] Store metadata + screenshot plan (`STORE_METADATA.md`)
- [ ] Privacy policy hosted at a public HTTPS URL
