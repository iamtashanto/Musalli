# Namaj Simulator Engine Specification

The **Namaj Simulator Engine** is a deterministic, pure Dart state machine and timeline generator that translates any canonical Islamic prayer configuration (`ContentSalahConfig`) into an ordered, chronological liturgical timeline of physical postures, audio recitations, and step-by-step instructions adhering strictly to the **Hanafi school of Fiqh** as practiced in Bangladesh.

---

## 1. Design Principles & Zero Flutter Dependency

- **Zero UI Dependency**: The domain engine (`lib/features/simulator/domain/`) contains **0 imports of Flutter** (`dart:ui`, `package:flutter/...`). It relies solely on Dart core libraries (`dart:async`, `dart:math`).
- **Deterministic & Pure**: `buildTimeline(config, ...)` is a pure algorithmic function. Given identical configuration, options, and gender, it always outputs the identical timeline.
- **Injectable Clock State Machine**: `SimulatorController` accepts an abstract `SimulatorClock`, enabling synchronous, instantaneous testing with `FakeSimulatorClock` without relying on real wall-clock timers.

---

## 2. Core Domain Types

### `enum Posture`
The 16 canonical liturgical postures rendered by the simulator figure:
1. `standing`: Standing upright facing Qibla (Niyyat & I’tidal).
2. `takbirHandsRaised`: Takbire Tahrima with hands raised (earlobes for men, shoulders for women).
3. `qiyamHandsFolded`: Qiyam with hands folded (below navel for men, on chest for women).
4. `ruku`: Bowing (90° level back for men, slight bow for women).
5. `qawma`: Standing upright after Ruku (Tasmi' & Tahmid).
6. `sajda`: Prostration with 7 contact points touching the mat.
7. `jalsa`: Sitting calmly between the two prostrations.
8. `qada`: Sitting for Tashahhud (Iftirash for men, Tawarruk for women).
9. `tashahhudFingerRaised`: Raising the right index (Shahadat) finger during the declaration of faith.
10. `salamRight`: Turning head to the right shoulder.
11. `salamLeft`: Turning head to the left shoulder.
12. `qunutTakbir`: Witr Rakat 3 Takbir before Dua Qunut with raised hands.
13. `eidTakbirRaised`: Eid additional Takbir raising hands.
14. `eidTakbirReleased`: Eid additional Takbir releasing hands to sides.
15. `janazaTakbir`: Janaza prayer Takbir (standing posture with folded hands).
16. `munajat`: Hands cupped together in supplication after Salam.

---

## 3. Hanafi Fiqh Rules Handled

1. **Rakat Structures (2, 3, 4 Rakats)**:
   - First sitting (Qa'dah Ula) occurs strictly after Rakat 2 in 3 and 4 rakat prayers. Only Tashahhud is recited.
   - Final sitting (Qa'dah Akhirah) occurs at `totalRakats`. Tashahhud, Durood Ibrahim, and Dua Masura are recited.
2. **Qira'at & Surah Rules**:
   - Sana (`dua-1`) is recited **only in Rakat 1**.
   - Ta'awwuz (`dua-taawwuz`) is recited **only in Rakat 1**.
   - Tasmiyah (`dua-bismillah`) is recited before Surah Al-Fatihah in **every rakat**.
   - Additional Surah is recited strictly in `qiratRakats` (Rakats 1 & 2 for Fard 3/4; all rakats for Sunnah/Nafl/Witr).
3. **Congregational Roles (`alone`, `imam`, `muqtadi`)**:
   - `muqtadi` (follower): Stands silently in Qiyam listening to the Imam without reciting Fatihah or Surah out loud (authentic Hanafi ruling), while still reciting Sana, tasbihat, and tashahhud.
4. **Witr Prayer with Qunut**:
   - In Rakat 3 after Qira'at before Ruku: Takbir with raised hands (`qunutTakbir`), fold hands again, and recite Dua Qunut (`dua-5`).
5. **Eid Extra Takbirs**:
   - Rakat 1: 3 extra Takbirs after Sana with hands raised and dropped to sides.
   - Rakat 2: 3 extra Takbirs after Qira'at before Ruku, followed by a 4th Takbir directly into Ruku.
6. **Salatul Janaza**:
   - Standing only; 4 Takbirs with Sana, Durood, Janaza Dua (adult/child variants), and concluding Salam pair. Zero Rukus and zero Sajdas.
7. **Salatut Tasbih (300 Tasbihs)**:
   - 75 Tasbihs per rakat distributed across 7 positions:
     - 15 times after Sana in Qiyam
     - 10 times after Surah in Qiyam
     - 10 times in Ruku
     - 10 times in Qawma
     - 10 times in 1st Sajda
     - 10 times in Jalsa
     - 10 times in 2nd Sajda
   - Total across 4 rakats = $75 \times 4 = 300$ tasbihs.

---

## 4. Gender Differences (`GenderVariantFlags`)

| Posture Parameter | Male Worshipper | Female Worshipper |
|---|---|---|
| Takbir Hand Height | Earlobes (`earlobes`) | Shoulders / Chest (`shoulders`) |
| Hand Folding in Qiyam | Below Navel (`below_navel`) | Above Breast / Chest (`chest`) |
| Ruku Back Angle | 90° Flat horizontal (`flat_90`) | Slight bow (`slight_bow`) |
| Sajda Form | Open elbows, belly separated from thighs | Compact, elbows tucked, belly near thighs |
| Sitting Position | Iftirash (left foot flat under, right upright) | Tawarruk (left hip on ground, feet out right) |
| Standing Feet Gap | 4 fingers gap (`four_fingers`) | Feet joined together (`joined`) |

---

## 5. Player State Machine (`SimulatorController`)

The `SimulatorController` manages playback state, transitions, seeking, and repeat counts:
- `play()`, `pause()`, `togglePlayPause()`
- `next()`, `previous()`, `replayStep()`, `seek(int index)`
- `repeatTick()`: Advances the tasbih repeat counter (e.g. 1/3, 2/3, 3/3 $\rightarrow$ next step)
- `setSpeed(double speed)`: Dynamically rescales transition delays (0.75x, 1.0x, 1.25x, 1.5x)
- `setAutoMode(bool auto)`: Switches between auto-advancement and user-driven manual stepping
- Broadcasts discrete events via `events` stream (`StepChangedEvent`, `RepeatTickEvent`, `RakatChangedEvent`, `PlaybackStateChangedEvent`, `SimulationCompletedEvent`).
