# Play Console — Data safety form (draft)

Fill the Play Console **Data safety** questionnaire using this draft. Adjust if you add network sync or analytics later.

## Overview answers

| Question | Answer |
|---|---|
| Does your app collect or share user data? | **No** (data stays on device; user-initiated shares are not “collection” by the developer) |
| Is data encrypted in transit? | N/A for app-held data; user shares use the destination app’s transport |
| Can users request deletion? | Users can uninstall the app or clear app storage; there is no cloud account |

## Data types (collected by developer)

Mark **not collected** for:

- Location
- Personal info (name, email, phone) — unless you later add an account
- Financial info
- Health
- Messages
- Photos / videos — **not collected by developer**; may be stored **on device** only
- Files / docs — on device only
- App activity / diagnostics — not collected in this release
- Device IDs / advertising ID

## Optional on-device processing (disclose as “processed on device” if asked)

- Photos/files the user attaches
- Vehicle and expense records
- Biometric unlock (system API; biometric templates stay with the OS)

## Security practices

- Data is encrypted in transit: N/A (no developer backend)
- Users can request deletion: uninstall / clear storage
- Committed to Play Families Policy: No (not targeting children)
