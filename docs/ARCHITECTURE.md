# Musalli (মুসল্লি) — Architecture Guide (`/docs/ARCHITECTURE.md`)

**Companion Web Platform**: [https://namajshikkha.tashanto.com](https://namajshikkha.tashanto.com)  
**Target Platforms**: Android (minSdk 23) & iOS (13.0+)  
**Flavors**: `dev` (`com.tashanto.musalli.dev`, `"মুসল্লি (Dev)"`) & `prod` (`com.tashanto.musalli`, `"মুসল্লি — Musalli"`)

---

## 1. Directory & Layer Structure

The Flutter codebase inside `/app` follows a strict **feature-first Clean Architecture** with pure Dart domain models and Riverpod state management:

```text
app/
├── assets/
│   ├── audio/                     # Bundled offline MP3 recitations & takbirs
│   ├── data/                      # Bundled JSON content (prayers, surahs, duas, rulings)
│   └── fonts/                     # Bundled HindSiliguri (Bangla) & Amiri (Uthmani Arabic) TTFs
├── docs/
│   ├── ARCHITECTURE.md            # Folder layout, Riverpod state, GoRouter & Deep Links
│   ├── DESIGN_SYSTEM.md           # Tokens, GlassSurface, adaptive quality, component catalog
│   └── MOTION.md                  # Page transitions, spring physics, haptics & 60fps rules
├── lib/
│   ├── core/
│   │   ├── config/                # FlavorConfig (dev / prod)
│   │   ├── database/              # Drift SQLite AppDatabase, tables/, migrations/
│   │   ├── design_system/         # Tokens, GlassSurface, GlassQuality, Glass & Content widgets
│   │   ├── error/                 # GlobalErrorHandler & BanglaErrorScreen
│   │   ├── l10n/                  # ARB files (app_bn.arb, app_en.arb) & generated localizations
│   │   ├── providers/             # Root Riverpod providers (locale, theme, glassQuality, DB)
│   │   ├── router/                # GoRouter + StatefulShellRoute + MainShellScaffold
│   │   ├── services/              # Privacy-first AppLogger
│   │   ├── theme/                 # MusalliTheme (Material 3 + MusalliDesignTokens)
│   │   └── utils/                 # BengaliNumberFormatter (০-৯ conversion)
│   ├── features/
│   │   └── <feature>/
│   │       ├── data/              # Repositories, JSON asset loaders, Drift DAOs
│   │       ├── domain/            # Pure Dart entities & use-cases (zero Flutter imports)
│   │       └── presentation/      # Riverpod controllers, screens & feature widgets
│   ├── shared/
│   │   └── models/                # Cross-feature Freezed models (FourLayerText, RulingCategory)
│   ├── app_bootstrap.dart         # Shared initialization, error trapping & ProviderScope
│   ├── main_dev.dart              # Dev flavor entrypoint
│   ├── main_prod.dart             # Prod flavor entrypoint
│   └── main.dart                  # Default entrypoint (delegates to main_dev.dart)
└── test/                          # Unit, widget, and golden test suites
```

---

## 2. State Management (Riverpod + Code Generation)

- **Code Generation**: Managed via `riverpod_annotation` and `riverpod_generator`.
- **Root `ProviderScope` Overrides**:
  - `flavorConfigProvider`: Overridden at startup in `bootstrapMusalliApp(FlavorConfig)` so widgets and services can inspect `flavor.isDev` / `flavor.isProd`.
  - `appDatabaseProvider`: Provides the singleton Drift `AppDatabase` (backed by `sqlite3_flutter_libs` on device, and overridable in tests with an in-memory database).
  - `appLocaleProvider`: Defaults to `Locale('bn')` (Bangla), supports instant switching to `Locale('en')` (English), and persists to the Drift `app_settings` table.
  - `appThemeModeProvider`: Persists light/dark theme selection.
  - `glassQualityProvider`: Auto-detects `GlassQuality` (`high` / `medium` / `low`) at startup using `device_info_plus` (RAM / Android SDK check) and early `FrameTiming` sampling, with manual user override persisted in `app_settings`.

---

## 3. Navigation & Deep Linking (`go_router` + `StatefulShellRoute`)

### 3.1 Five-Tab Stateful Shell
`appRouterProvider` configures a `StatefulShellRoute` rendered inside `MainShellScaffold` with 5 independent `StatefulShellBranch` stacks:
1. **হোম (Home)** — `/`
2. **শিখুন (Learn)** — `/learn`
3. **সিমুলেটর (Simulator)** — `/simulator` (accepts `?prayer=<slug>&unit=<id>`)
4. **সময় (Times)** — `/times`
5. **আরও (More)** — `/more`

Each branch maintains its own `GlobalKey<NavigatorState>` and `PageStorageKey` so scroll positions and nested navigation stacks are preserved when switching tabs. Re-tapping the active tab smoothly scrolls to the top and resets the branch to its root.

### 3.2 Custom Scheme & Universal / App Links
Both `AndroidManifest.xml` and `ios/Runner/Info.plist` + `Runner.entitlements` are configured for:
- **Custom Scheme**:
  - `musalli://namaj/<slug>` $\rightarrow$ normalized by `normalizeIncomingDeepLinkUri` to `/namaj/<slug>`
  - `musalli://simulator?prayer=<slug>&unit=<id>` $\rightarrow$ normalized to `/simulator?prayer=<slug>&unit=<id>`
- **HTTPS App Links / Universal Links**:
  - `https://namajshikkha.tashanto.com/namaj/<slug>`
  - `https://namajshikkha.tashanto.com/simulator?prayer=<slug>&unit=<id>`

### 3.3 Files to Upload to `https://namajshikkha.tashanto.com` for Verified Domain Links
To complete domain verification on Android and iOS, host these two static files on the Next.js website under `website/public/.well-known/`:

1. **Android (`https://namajshikkha.tashanto.com/.well-known/assetlinks.json`)**:
   ```json
   [
     {
       "relation": ["delegate_permission/common.handle_all_urls"],
       "target": {
         "namespace": "android_app",
         "package_name": "com.tashanto.musalli",
         "sha256_cert_fingerprints": [
           "<RELEASE_KEYSTORE_SHA256_FINGERPRINT>"
         ]
       }
     },
     {
       "relation": ["delegate_permission/common.handle_all_urls"],
       "target": {
         "namespace": "android_app",
         "package_name": "com.tashanto.musalli.dev",
         "sha256_cert_fingerprints": [
           "<DEBUG_KEYSTORE_SHA256_FINGERPRINT>"
         ]
       }
     }
   ]
   ```

2. **iOS (`https://namajshikkha.tashanto.com/.well-known/apple-app-site-association`)**:
   ```json
   {
     "applinks": {
       "apps": [],
       "details": [
         {
           "appIDs": [
             "<APPLE_TEAM_ID>.com.tashanto.musalli",
             "<APPLE_TEAM_ID>.com.tashanto.musalli.dev"
           ],
           "components": [
             { "/": "/namaj/*" },
             { "/": "/simulator*" }
           ]
         }
       ]
     }
   }
   ```

---

## 4. Package Selections & Justifications

| Capability | Package & Version | Notes / Justification |
|---|---|---|
| State Management | `flutter_riverpod: 3.4.3`, `riverpod_annotation: 4.0.7` | Compile-safe reactive state with easy `ProviderScope` overrides for testing. |
| Routing | `go_router: 18.1.3` | Native `StatefulShellRoute` support for 5 persistent tabs + declarative URI deep linking. |
| Local Database | `drift: 2.35.3`, `drift_flutter: 0.3.1`, `sqlite3_flutter_libs: 0.6.0+eol` | Type-safe SQLite with schema migrations and reactive streams. |
| Immutable Models | `freezed_annotation: 3.1.0`, `json_annotation: 4.12.0` | Value equality, `copyWith`, and fast JSON deserialization for bundled content. |
| Audio Playback | `just_audio: 0.10.6`, `audio_session: 0.2.4` | Gapless offline asset & cached network audio with word/position stream sync. |
| Prayer Times | `adhan_dart: 2.0.1` | Pure Dart offline calculation supporting Karachi method & Hanafi Asr madhab. |
| Compass / Sensors | `sensors_plus: 7.1.1` | Used for Qibla magnetometer/accelerometer fusion (chosen from the prompt's `flutter_compass` or `sensors_plus` option because `sensors_plus` is actively maintained by the Flutter Community Plus team with full Dart 3 & Android 14+ support). |
| Geolocation | `geolocator: 14.1.2` | On-device coordinates for prayer times & Qibla (never sent to any server). |
| Notifications | `flutter_local_notifications: 22.3.3`, `timezone: 0.11.2` | Local waqt reminders & adhan scheduling. |
| Home Widgets | `home_widget: 0.10.0` | Android & iOS home-screen prayer time widgets. |
| Hardware Info | `device_info_plus: 13.3.0` | Detects `isLowRamDevice` and Android SDK level for `GlassQuality` auto-tuning. |

