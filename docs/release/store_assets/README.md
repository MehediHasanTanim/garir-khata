# Store assets

| File | Use |
|---|---|
| `android_icon_512.png` | Play Store high-res icon |
| `ios_icon_1024.png` | App Store icon |

Source of truth: `docs/UX/Icon-1.png`.

Regenerate:

```bash
python3 tools/generate_store_icons.py
```

Screenshots: capture on device or reuse mockups under `docs/UX/` (see `STORE_METADATA.md`).
