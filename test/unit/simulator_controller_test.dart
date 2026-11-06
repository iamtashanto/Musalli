import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/simulator/domain/engine.dart';
import 'package:musalli/features/simulator/domain/simulator_controller.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/shared/content/salah_config.dart';

void main() {
  group('SimulatorController Tests with Fake Clock', () {
    late Timeline timeline;
    late FakeSimulatorClock fakeClock;
    late SimulatorController controller;

    setUp(() {
      const config = ContentSalahConfig(
        rakats: 2,
        qiratRakats: [1, 2],
        jahr: [1, 2],
      );

      timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'fajr',
      );

      fakeClock = FakeSimulatorClock();
      controller = SimulatorController(timeline: timeline, clock: fakeClock);
    });

    tearDown(() {
      controller.dispose();
    });

    test('Initial state is paused at step 0', () {
      expect(controller.currentStepIndex, 0);
      expect(controller.isPlaying, isFalse);
      expect(controller.isAutoMode, isTrue);
      expect(controller.currentRepeat, 1);
      expect(controller.currentStep?.id, 'step-niyyat');
    });

    test('Play starts timer and transitions state', () {
      final events = <SimulatorEvent>[];
      controller.events.listen(events.add);

      controller.play();

      expect(controller.isPlaying, isTrue);
      expect(fakeClock.hasPending, isTrue);
      expect(
        events.whereType<PlaybackStateChangedEvent>().first.isPlaying,
        isTrue,
      );
    });

    test('Fake clock tick advances to next step in auto mode', () {
      controller.play();
      expect(controller.currentStepIndex, 0);

      // Tick the fake clock
      final ticked = fakeClock.tickNext();
      expect(ticked, isTrue);
      expect(controller.currentStepIndex, 1);
      expect(controller.currentStep?.id, 'r1-takbir-tahrima');

      // Next tick advances to Rakat 1 Sana
      fakeClock.tickNext();
      expect(controller.currentStepIndex, 2);
      expect(controller.currentStep?.id, 'r1-sana');
    });

    test('Pause cancels pending timers', () {
      controller.play();
      expect(fakeClock.hasPending, isTrue);

      controller.pause();
      expect(controller.isPlaying, isFalse);
      expect(fakeClock.hasPending, isFalse);
    });

    test('Manual navigation (next, previous, seek) updates state', () {
      controller.next();
      expect(controller.currentStepIndex, 1);

      controller.next();
      expect(controller.currentStepIndex, 2);

      controller.previous();
      expect(controller.currentStepIndex, 1);

      controller.seek(5);
      expect(controller.currentStepIndex, 5);
    });

    test('Repeat tick increments counter until step repeats', () {
      // Seek to Ruku step (3 repeats)
      final rukuIndex = timeline.steps.indexWhere(
        (s) => s.posture == Posture.ruku,
      );
      expect(rukuIndex, isNonNegative);

      controller.seek(rukuIndex);
      expect(controller.currentStep?.repeat, 3);
      expect(controller.currentRepeat, 1);

      controller.repeatTick();
      expect(controller.currentRepeat, 2);

      controller.repeatTick();
      expect(controller.currentRepeat, 3);

      // 4th tick advances to Qawma step
      controller.repeatTick();
      expect(controller.currentStepIndex, rukuIndex + 1);
      expect(controller.currentRepeat, 1);
    });

    test('Auto-advance continues until completion event', () {
      bool completed = false;
      controller.events.listen((e) {
        if (e is SimulationCompletedEvent) {
          completed = true;
        }
      });

      controller.play();

      // Exhaustively tick all steps
      for (var i = 0; i < timeline.length + 5; i++) {
        if (!fakeClock.hasPending) break;
        fakeClock.tickNext();
      }

      expect(completed, isTrue);
      expect(controller.isPlaying, isFalse);
    });

    test('Speed scaling affects timer interval calculation', () {
      controller.setSpeed(2.0);
      expect(controller.speed, 2.0);

      controller.play();
      expect(fakeClock.hasPending, isTrue);
    });
  });
}
