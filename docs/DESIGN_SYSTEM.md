# Musalli Design System (`/docs/DESIGN_SYSTEM.md`)

**Location**: `lib/core/design_system/`  
**Aesthetic Direction**: Calm, spiritual iOS-style frosted glass over deep emerald/teal ambient gradients and subtle Rub el Hizb geometric lattice patterns, engineered to degrade gracefully on 2–3 GB RAM Android phones.

---

## 1. Design Tokens (`MusalliDesignTokens`)

All tokens are exposed via `Theme.of(context).extension<MusalliDesignTokens>()` (or the shorthand `context.tokens`):

### 1.1 Colors (`MusalliColorTokens`)
- **Brand Scale**:
  - Light: `primaryEmerald` (`#059669`), `emeraldLight` (`#34D399`), `emeraldDark` (`#065F46`), `tealDeep` (`#0F766E`), `goldAccent` (`#D97706`).
  - Dark: `primaryEmerald` (`#10B981`), `emeraldLight` (`#6EE7B7`), `emeraldDark` (`#047857`), `tealDeep` (`#115E59`), `goldAccent` (`#FBBF24`).
- **Semantic Fiqh Ruling Colors** (consistent with the website):
  - `fard` (ফরজ): Emerald (`#047857` light / `#34D399` dark)
  - `wajib` (ওয়াজিব): Amber Gold (`#B45309` light / `#FBBF24` dark)
  - `sunnah` (সুন্নাত): Sky Teal (`#0369A1` light / `#38BDF8` dark)
  - `nafl` (নফল): Royal Purple (`#6D28D9` light / `#C084FC` dark)

### 1.2 Typography (`MusalliTypographyTokens`)
- **Bangla & Latin UI Font**: Bundled `HindSiliguri` (`400`, `500`, `600`, `700`).
- **Quranic & Hadith Arabic Font**: Bundled `Amiri` (`400`, `700`) with generous line-height (`1.85`–`1.95`) and strict `TextDirection.rtl` rendering so Uthmani harakat never clip.
- **Scale**:
  - `display` (`30sp`), `titleLarge` (`22sp`), `titleMedium` (`17sp`), `bodyLarge` (`16sp`), `bodyMedium` (`14sp`), `label` (`12sp`), `arabicLarge` (`28sp`), `arabicBody` (`23sp`).

### 1.3 Spacing, Radii & Motion
- **Spacing (`MusalliSpacingTokens`)**: 4pt grid (`xxs: 4`, `xs: 8`, `sm: 12`, `md: 16`, `lg: 20`, `xl: 24`, `xxl: 32`, `xxxl: 48`).
- **Radii (`MusalliRadiusTokens`)**: `sm: 12`, `md: 20`, `lg: 28`, `full: 999`.
- **Motion (`MusalliMotionTokens`)**: Durations `150ms`, `250ms`, `400ms`, `600ms`; curves `easeOutCubic`, `easeInOutCubicEmphasized`, and `interactiveSpring`.

---

## 2. Glass Surface & Performance Guard

### 2.1 `GlassSurface`
- Renders a `ClipRRect` + `BackdropFilter` (sigma `24` in `high`, `12` in `medium`) + translucent linear gradient fill + custom-painted 1px directional gradient border (top-left specular highlight) + soft shadow.
- Wrapped in a `RepaintBoundary`.

### 2.2 Three-Tier Performance Guard (`GlassQuality`)
1. **Hardware Auto-Detection (`GlassQualityDetector.detectHardwareTier`)**:
   - Inspects `androidInfo.isLowRamDevice` and `androidInfo.version.sdkInt`. Devices with 2–3 GB RAM (`isLowRamDevice == true`) or Android SDK $\le 26$ automatically start in `GlassQuality.low`.
2. **Startup Frame-Time Guard (`evaluateFrameTimings`)**:
   - Samples the first 25 frames after launch; if average frame time exceeds `18ms`, downgrades `high -> medium`, or `> 24ms` downgrades to `low`.
3. **Zero Nested Blur Rule (`_GlassBlurScope`)**:
   - `GlassSurface` checks an `InheritedWidget` scope (`_GlassBlurScope`) and never applies a second `BackdropFilter` inside an already-blurred parent.
   - Standard list cards (`GlassCard`) default to `enableBlur: false` (using translucent gradient + specular 1px border) so scrolling 50+ cards stays locked at 60fps on every device, while floating bars (`GlassBottomNavBar`, `GlassSliverAppBar`, `GlassBottomSheet`, `GlassDialog`, and hero cards) use real-time blur when quality permits.

---

## 3. Component Catalog

### Glass Primitives & Navigation
- `GlassSurface`: Core frosted container.
- `GlassCard`: Interactive card with `0.97` press-scale animation, haptic feedback, and optional `heroTag`.
- `GlassSliverAppBar`: Collapsing large-title header that shrinks into a frosted bar on scroll.
- `GlassBottomNavBar`: Floating pill navigation bar with a spring-animated sliding active indicator and auto-hide on scroll down.
- `GlassBottomSheet` & `GlassDialog`: Modal overlays with blurred backdrops.
- `GlassButton`: `primary`, `secondary`, and `ghost` variants with press-scale animation.
- `GlassChip`, `GlassSegmentedControl`, `GlassSearchBar`, `GlassListTile`.
- `AnimatedGradientBackground` & `PatternOverlay`: Ambient gradient drift + 8-pointed Islamic geometric star lattice.

### Islamic Content Components
- `ArabicBlock`: 4-layer recitation card (Uthmani Arabic, Bangla `uccharon`, `Banglish`, and `meaning`), per-layer toggles, font-size scaler, audio play/pause with progress bar, real-time word highlight from `highlightWordIndexStream`, and copy action.
- `RulingBadge`: Semantic `fard`, `wajib`, `sunnah`, `nafl`, and `special` badges.
- `ReferenceChip`: Citation chip (`"সহীহ বুখারী ৭৫৭"`) with authenticity grade pill (`সহীহ` / `হাসান` / `যঈফ`).
- `Callout`: `tip`, `warning`, and `reference` callout boxes.
- `SectionHeader`, `ProgressRing`, `EmptyState`, `GlassShimmerLoader`.

