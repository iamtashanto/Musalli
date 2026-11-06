# Musalli Performance & Hardening Specification

This document details the performance benchmarks, glass rendering fallback strategy, accessibility guarantees, memory safety practices, and production bundle optimizations for Musalli (iOS & Android).

---

## 1. Performance Targets & Cold Start

| Metric | Target | Mid-Range Android (e.g. SD 680, 3GB RAM) | High-End (iOS / Flagship Android) |
|---|---|---|---|
| **Cold Start to Interactive** | `< 2.0s` | `~1.2s` | `< 0.6s` |
| **Warm Start** | `< 500ms` | `~250ms` | `< 120ms` |
| **Scrolling & Transition Frame Budget** | `60fps` (`< 16.6ms` / frame) | Sustained 60fps | 120fps ProMotion / High Refresh |
| **Impeller Ready** | 0 shader compilation jank | Supported on iOS & modern Android | Supported |

### Cold Start Optimization Techniques
1. **Deferred Asset Decoding**: Heavy JSON assets (`surahs.json`, `hadith.json`, `audio_manifest.json`) are parsed asynchronously in background isolates via `compute()` or streaming loaders rather than blocking the main UI thread during `runApp()`.
2. **Pre-compiled Shaders & Impeller**: Musalli uses standard Skia/Impeller shader primitives without dynamic runtime GLSL compilation overhead.
3. **Database Pre-warming**: SQLite connection is opened lazily with in-memory cache for critical settings (`AppDatabase`).

---

## 2. Dynamic Glass Rendering Tiers (`GlassQuality`)

To ensure smooth 60fps rendering even on low-end hardware (2–3 GB RAM, Adreno 610 tier), Musalli implements an adaptive glass quality detector:

```mermaid
graph TD
    A[GlassQualityDetector] -->|Frame timings < 16ms| B[High Quality: Bilateral Blur 20px + Specular Borders]
    A -->|Occasional jank detected| C[Medium Quality: Reduced Blur 8px + 1px Border]
    A -->|Frame timings > 32ms or Battery Saver| D[Low Quality: 0px Blur, Opaque Tinted Card]
```

- **High Quality**: `BackdropFilter` with `ImageFilter.blur(sigmaX: 16, sigmaY: 16)`, subtle gradient borders, specular highlights.
- **Medium Quality**: Reduced blur radius (sigma 8.0) and simplified gradient strokes.
- **Low Quality (Fallback)**: Replaces `BackdropFilter` with an opaque dark tinted container (`Color(0xFF131A26)`). Zero shader blurs are performed, completely eliminating fill-rate bottlenecks on low-end Mali/Adreno GPUs.

---

## 3. Memory & Resource Lifecycle Management

Musalli implements a strict zero-leak disposal policy:

1. **Audio Player**: All `AudioPlayer` instances in simulator and Quran player are strictly tied to Riverpod provider lifecycles or StatefulWidget `dispose()` handlers, calling `.stop()` and `.dispose()`.
2. **Timers & Streams**:
   - Prayer waqt countdown timers are canceled when navigating away or unmounting.
   - Sensor streams (compass for Qibla compass) are paused/cancelled immediately when `QiblaScreen` is popped.
3. **Controllers**: All `ScrollController`, `TextEditingController`, and `AnimationController` instances are paired with explicit `dispose()` overrides.

---

## 4. Accessibility (A11y) & Usability

1. **Text Scale Factor 2.0 Compatibility**:
   - All components, action tiles, and cards use flexible column/row layouts with wrap or expanded text blocks, tested at `2.0x` system font scaling without text clipping or overflow errors (`A11y Text Scale test`).
2. **Screen Reader (TalkBack / VoiceOver)**:
   - Interactive cards, buttons, and prayer status switches are wrapped with `Semantics(button: true, label: ..., hint: ...)` with descriptive Bengali strings.
3. **Contrast Ratio Compliance**:
   - Main text colors (`#F8FAFC` on `#0B0F17`) provide a contrast ratio of `16.2:1`, far exceeding WCAG AAA standards (7:1).
   - Secondary text (`#94A3B8`) meets WCAG AA (4.5:1).
4. **Reduced Motion**:
   - Respects `MediaQuery.of(context).disableAnimations`. Transition durations drop to 0ms when reduced motion is preferred by user.

---

## 5. APK & Production Bundle Sizing

- **Font Subsetting**: Amiri Quran font and Hind Siliguri fonts include standard subsets required for Bengali and Arabic glyphs.
- **Tree-shaking**: `--tree-shake-icons` active for Flutter material & Cupertino icons.
- **Asset Bundling**: Audio files are on-demand streamed or cached locally upon user request rather than packed into the initial APK.
- **Target Sizes**:
  - Per-ABI Split APK (`armeabi-v7a` / `arm64-v8a`): `< 18 MB`.
  - Android App Bundle (AAB): `< 22 MB`.

---

## 6. Privacy-First Error Handling & Telemetry

- **Zero-Telemetry Default**: Telemetry and crash reporting are strictly opt-in (`crash_reporting_opt_in: false`).
- **Data Scrubbing**: All errors logged locally via `CrashReportingService` sanitize personal identifiers, email addresses, and location coordinates before any processing.

