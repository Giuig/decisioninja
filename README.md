# decisioninja

Decision-making app built with Flutter. Roll dice, use the pointer, or flip a coin — let the ninja decide.


## Features

- **Binary Decisions** — choose between Left/Right, Yes/No, or Heads/Tails
- **Dice Roller** — roll dice with various sides (D4, D6, D8, D10, D12, D20)
- **Pointer** — classic spinner for yes/no decisions
- **Material You** — dynamic color theming, light and dark mode
- **Google-Free** — no Google Play Services required, fully FOSS

## Try it Online

**[Launch decisioninja](https://giuig.github.io/decisioninja/)**


## Download

Get the latest APK from the [Releases page](https://github.com/Giuig/decisioninja/releases/latest).

| APK | Notes |
|---|---|
| `decisioninja-X.X.X.apk` | Universal — works on any device |
| `decisioninja-X.X.X-arm64-v8a.apk` | Most modern Android phones |
| `decisioninja-X.X.X-armeabi-v7a.apk` | Older 32-bit devices |
| `decisioninja-X.X.X-x86_64.apk` | Emulators |

### Install via Obtainium

Add `https://github.com/Giuig/decisioninja` in [Obtainium](https://github.com/ImranR98/Obtainium) to receive automatic updates. Use the APK filter `decisioninja-\d` to select the universal build.


## Support

I make FOSS apps in my free time, a coffee would help me keep them going! ☕

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/giuig)

## Build

```bash
# Prerequisites: Flutter SDK 3.41.5+
flutter pub get
flutter build apk --release --split-per-abi --no-tree-shake-icons --split-debug-info=build/debug-info
flutter build web --base-href=/decisioninja/ --release
```

## Part of the ninja apps family

| App | Description |
|---|---|
| [tvninja](https://github.com/Giuig/tvninja) | IPTV / M3U8 player |
| [auraninja](https://github.com/Giuig/auraninja) | Ambient sound mixer and focus app |
| [ninja_material](https://github.com/Giuig/ninja_material) | Shared Flutter library powering all ninja apps |

## License

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](./LICENSE)

This project is licensed under the [GNU General Public License v3.0](./LICENSE).
