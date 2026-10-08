#!/usr/bin/env python3
"""Regenerate launcher + store icons from docs/UX/Icon-1.png."""

from __future__ import annotations

from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "docs/UX/Icon-1.png"


def resize_cover(im: Image.Image, size: int) -> Image.Image:
    w, h = im.size
    side = min(w, h)
    left = (w - side) // 2
    top = (h - side) // 2
    cropped = im.crop((left, top, left + side, top + side))
    return cropped.resize((size, size), Image.Resampling.LANCZOS)


def main() -> None:
    src = Image.open(SRC).convert("RGBA")
    bg = (13, 122, 112, 255)

    android_legacy = {
        "mipmap-mdpi": 48,
        "mipmap-hdpi": 72,
        "mipmap-xhdpi": 96,
        "mipmap-xxhdpi": 144,
        "mipmap-xxxhdpi": 192,
    }
    android_adaptive = {
        "mipmap-mdpi": 108,
        "mipmap-hdpi": 162,
        "mipmap-xhdpi": 216,
        "mipmap-xxhdpi": 324,
        "mipmap-xxxhdpi": 432,
    }

    for folder, size in android_legacy.items():
        out = ROOT / "android/app/src/main/res" / folder
        out.mkdir(parents=True, exist_ok=True)
        resize_cover(src, size).save(out / "ic_launcher.png")

    for folder, size in android_adaptive.items():
        out = ROOT / "android/app/src/main/res" / folder
        resize_cover(src, size).save(out / "ic_launcher_foreground.png")
        Image.new("RGBA", (size, size), bg).save(out / "ic_launcher_background.png")

    store = ROOT / "docs/release/store_assets"
    store.mkdir(parents=True, exist_ok=True)
    resize_cover(src, 512).save(store / "android_icon_512.png")
    resize_cover(src, 1024).save(store / "ios_icon_1024.png")

    ios_dir = ROOT / "ios/Runner/Assets.xcassets/AppIcon.appiconset"
    ios_icons = {
        "Icon-App-20x20@1x.png": 20,
        "Icon-App-20x20@2x.png": 40,
        "Icon-App-20x20@3x.png": 60,
        "Icon-App-29x29@1x.png": 29,
        "Icon-App-29x29@2x.png": 58,
        "Icon-App-29x29@3x.png": 87,
        "Icon-App-40x40@1x.png": 40,
        "Icon-App-40x40@2x.png": 80,
        "Icon-App-40x40@3x.png": 120,
        "Icon-App-60x60@2x.png": 120,
        "Icon-App-60x60@3x.png": 180,
        "Icon-App-76x76@1x.png": 76,
        "Icon-App-76x76@2x.png": 152,
        "Icon-App-83.5x83.5@2x.png": 167,
        "Icon-App-1024x1024@1x.png": 1024,
    }
    for name, size in ios_icons.items():
        resize_cover(src, size).convert("RGB").save(ios_dir / name, "PNG")

    print("Icons regenerated from", SRC)


if __name__ == "__main__":
    main()
