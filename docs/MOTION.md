# Musalli Motion & Micro-Interactions Guide (`/docs/MOTION.md`)

**Goal**: Calm, spiritually respectful, responsive motion that runs at a locked **60fps** on mid-range and low-end Android devices while honoring OS reduced-motion accessibility settings (`MediaQuery.disableAnimations`).

---

## 1. Duration & Curve Tokens (`MusalliMotionTokens`)

| Token | Duration | Curve | Primary Usage |
|---|---:|---|---|
| `motion.fast` | `150ms` | `Curves.easeOutCubic` | Press scale down (`0.97`), chip toggles, opacity fades |
| `motion.normal` | `250ms` | `Curves.easeOutCubic` | Press release, bottom bar show/hide, number counter ticks |
| `motion.emphasized` | `400ms` | `Curves.easeInOutCubicEmphasized` | Sliding tab pill, segmented control, modal sheet entrance |
| `motion.slow` | `600ms` | `Curves.easeInOutCubic` | Namaj Simulator 2D figure joint-angle interpolation |

---

## 2. Page Transitions (`MusalliPageTransitions`)

All pushed routes in `lib/core/router/app_router.dart` use explicit `pageBuilder` transitions:

1. **Default Push (`MusalliPageTransitions.sharedAxisHorizontal`)**:
   - **Duration**: `300ms` forward / `250ms` reverse.
   - **Curve**: `Curves.easeInOutCubicEmphasized`.
   - **Effect**: Horizontal shared-axis slide (`Offset(0.08, 0) -> Offset.zero`) + fade + subtle scale (`0.97 -> 1.0`).
   - **When to use**: Standard drill-down screens (settings, sub-menus, dev showcase).

2. **Card $\rightarrow$ Detail (`MusalliPageTransitions.heroDetail`)**:
   - **Duration**: `350ms` forward / `280ms` reverse.
   - **Effect**: Pairs with `GlassCard(heroTag: ...)` / `GlassListTile(heroTag: ...)` so tapping a prayer card (`prayer-card-fajr`) smoothly expands its glass surface into the detail header.
   - **When to use**: Navigating from a prayer card to `/namaj/:slug` or from a surah card to its detail view.

3. **Modal Flows (`MusalliPageTransitions.glassModalSheet` & `GlassBottomSheet.show`)**:
   - **Duration**: `360ms` forward / `260ms` reverse.
   - **Effect**: Vertical slide from bottom (`Offset(0, 0.14) -> Offset.zero`) over an animated frosted backdrop.
   - **When to use**: Simulator setup sheet, layer preferences, quick filters.

4. **Bottom Tab Switching (`MainShellScaffold`)**:
   - **Effect**: Cross-fade (`150ms`) + subtle vertical offset (`Offset(0, 0.015) -> Offset.zero`, `250ms`) while keeping all 5 `StatefulShellBranch` trees mounted in memory (`IgnorePointer` + `TickerMode`) so there is zero rebuild jank.
   - **Shell Scroll Behavior**: Scrolling down hides `GlassBottomNavBar` (`Offset(0, 1.35)`); scrolling up reveals it. Re-tapping the active tab smoothly scrolls to `0.0` (`320ms`).

5. **Predictive Back & iOS Swipe-Back**:
   - Android `AndroidManifest.xml` enables `android:enableOnBackInvokedCallback="true"` paired with `PredictiveBackPageTransitionsBuilder()` on Android and `CupertinoPageTransitionsBuilder()` on iOS/macOS.

---

## 3. Micro-Interactions & Haptics

- **Buttons & Interactive Cards (`PressScaleContainer`)**:
  - Scales to `0.97` on pointer down (`150ms`), releases with `Curves.easeOutBack` (`250ms`).
  - Triggers `HapticFeedback.lightImpact()` on primary actions (`GlassButton`, `GlassCard`) and `HapticFeedback.selectionClick()` on toggles (`GlassChip`, `GlassSegmentedControl`, `GlassBottomNavBar`).
- **First-Mount Staggered List Entrance (`FirstMountStaggeredEntrance`)**:
  - Animates fade + vertical slide (`Offset(0, 0.08) -> Offset.zero`, `280ms`) with a `40ms * index` stagger (capped at index 8) **only on initial mount** (`_hasStarted` guard), never re-running on state updates.
- **Crescent Moon Pull-to-Refresh (`CrescentRefreshWrapper`)**:
  - Custom-painted golden crescent moon & star emblem (`CrescentMoonIndicator`) with light haptic impact on trigger.
- **Animated Number Counters (`AnimatedNumberCounter`)**:
  - Smoothly interpolates integer changes (`TweenAnimationBuilder<double>`) formatted in Bangla numerals (`০-৯`).

---

## 4. Accessibility & 60fps Profile Mode Verification

- **Reduced Motion (`context.isReducedMotion`)**:
  - Checks `MediaQuery.maybeDisableAnimationsOf(context)`.
  - When enabled: `AnimatedGradientBackground` and `GlassShimmerLoader` stop their tickers; `PressScaleContainer` disables scaling; `FirstMountStaggeredEntrance` snaps immediately to `1.0`; page transitions fall back to simple `FadeTransition`.
- **Profile Mode 60fps Verification Summary**:
  - Frame budget target: `< 16.6ms` per frame (UI thread `< 6ms`, Raster thread `< 8ms`).
  - By isolating real-time `BackdropFilter` to floating chrome (`GlassBottomNavBar`, `GlassSliverAppBar`) within `RepaintBoundary` layers and keeping scrolling list `GlassCard`s blur-free by default, scrolling the 50-card showcase list maintains 60fps with zero shader-compilation or offscreen-buffer spikes.

