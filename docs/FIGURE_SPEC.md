# Namaj Simulator Figure Specification & Architecture

This document provides the architectural evaluation between **Rive** and **Flutter CustomPainter**, the technical justification for the current implementation, and a comprehensive specification for a future `.riv` vector animation asset.

---

## 1. Architectural Evaluation: Rive vs. CustomPainter

| Evaluation Metric | Rive (.riv runtime) | Flutter CustomPainter (Code Rig) |
|---|---|---|
| **Bundle Size & Overhead** | Requires `rive` package (~2.4 MB binary + engine dependencies). | **0 KB added dependencies**; pure Flutter graphics primitives. |
| **Asset Delivery & Offline Guarantee** | Requires loading a binary `.riv` file from assets or network; asset decoding overhead. | **Instantaneous synchronous instantiation**; 100% offline with zero load delay. |
| **Fiqh Precision & Mathematical Control** | Bone rotations must be baked into visual keyframes by an animator; modifying fiqh angles requires re-exporting `.riv`. | **Direct programmatic control**: Every joint angle (ruku 90°, sajda contact points, hand folding) is defined in pure Dart data and can be verified by automated unit tests. |
| **Dynamic Highlight Overlays** | Complex to hook shader glows to specific bone tips across dynamic view angles. | **Built-in custom shader and canvas highlights**: 7 sajda contact points glow with radial gradients, and index finger glows during testimony. |
| **Low-End Device Performance (2–3 GB RAM)** | Rive runtime uses internal C++ canvas rendering which adds memory overhead on budget devices. | **Native Skia/Impeller hardware acceleration** with `RepaintBoundary` caching for constant 60fps rendering. |

### Conclusion
**CustomPainter** is implemented as the primary production engine for Musalli because it is mathematically verifiable, zero-latency, theme-adaptive, and requires zero external asset loading.

---

## 2. Production Specification for Future Rive Asset (`musalli_figure.riv`)

Should a motion designer produce a dedicated Rive rig for a future release, the file must adhere to the following strict technical specification:

### Artboards
1. `MaleArtboard`: Dimensions $400 \times 320$, coordinate origin at $(0, 0)$.
2. `FemaleArtboard`: Dimensions $400 \times 320$, coordinate origin at $(0, 0)$.

### Bone Hierarchy & Pivot Points
- **Root (Pelvis / Hip)**: Pivot at $(230, 158)$ in standard standing.
  - **Spine / Torso**: Length 70 units; pivot at Hip.
    - **Neck & Head**: Length 36 units; pivot at Shoulder top. Blank oval face; male has white tupi; female has draped hijab.
    - **Right Upper Arm**: Length 42 units; pivot at Right Shoulder.
      - **Right Forearm**: Length 38 units; pivot at Right Elbow.
        - **Right Hand**: Length 16 units; pivot at Right Wrist. Includes separate `IndexFinger` bone.
    - **Left Upper Arm**: Length 42 units; pivot at Left Shoulder.
      - **Left Forearm**: Length 38 units; pivot at Left Elbow.
        - **Left Hand**: Length 16 units; pivot at Left Wrist.
  - **Thigh**: Length 55 units; pivot at Hip.
    - **Shin**: Length 55 units; pivot at Knee.
      - **Foot**: Length 30 units; pivot at Ankle. Includes `Toes` bone (bendable 90° for Sajda/Qadah).

### State Machine Inputs
- `postureIndex` (Number: 0 to 15 matching `Posture.values`).
- `gender` (Boolean: `false` = male, `true` = female).
- `viewMode` (Number: `0` = side view facing left, `1` = front view).
- `showHighlights` (Boolean: triggers glow on 7 contact points in Sajda).
- `speed` (Number: $0.75$ to $1.5$).

