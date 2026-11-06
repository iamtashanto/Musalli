/// Namaj Simulator Controller & State Machine (Pure Dart - No Flutter imports).
///
/// Drives prayer playback, repeat progressions, auto/manual advances,
/// speed scaling, and broadcasts discrete events. Uses an injectable clock
/// interface for completely deterministic, isolated unit testing.

import 'dart:async';

import 'package:musalli/features/simulator/domain/types.dart';

/// Base class for all simulator state broadcast events.
sealed class SimulatorEvent {
  const SimulatorEvent();
}

/// Step changed to a new index in the timeline.
class StepChangedEvent extends SimulatorEvent {
  const StepChangedEvent({required this.stepIndex, required this.step});
  final int stepIndex;
  final SimStep step;
}

/// Repeat counter ticked within the current step (e.g. 2 of 3).
class RepeatTickEvent extends SimulatorEvent {
  const RepeatTickEvent({
    required this.currentRepeat,
    required this.totalRepeats,
  });
  final int currentRepeat;
  final int totalRepeats;
}

/// Rakat number changed.
class RakatChangedEvent extends SimulatorEvent {
  const RakatChangedEvent({required this.rakat});
  final int? rakat;
}

/// Playback paused or resumed.
class PlaybackStateChangedEvent extends SimulatorEvent {
  const PlaybackStateChangedEvent({required this.isPlaying});
  final bool isPlaying;
}

/// Simulation completed all steps in the timeline.
class SimulationCompletedEvent extends SimulatorEvent {
  const SimulationCompletedEvent({
    required this.totalSteps,
    required this.totalRakats,
  });
  final int totalSteps;
  final int totalRakats;
}

/// Injectable clock abstraction to decouple controller from real system time.
abstract class SimulatorClock {
  /// Schedules a callback after [duration]. Returns an object to cancel if needed.
  dynamic schedule(Duration duration, void Function() callback);

  /// Cancels a scheduled callback.
  void cancel(dynamic handle);
}

/// Default clock using standard `dart:async` Timer.
class DefaultSimulatorClock implements SimulatorClock {
  @override
  dynamic schedule(Duration duration, void Function() callback) {
    return Timer(duration, callback);
  }

  @override
  void cancel(dynamic handle) {
    if (handle is Timer) {
      handle.cancel();
    }
  }
}

/// Fake clock for synchronous, deterministic unit testing.
class FakeSimulatorClock implements SimulatorClock {
  final List<({Duration delay, void Function() callback, int id})> _scheduled =
      [];
  int _nextId = 1;

  @override
  dynamic schedule(Duration duration, void Function() callback) {
    final id = _nextId++;
    _scheduled.add((delay: duration, callback: callback, id: id));
    return id;
  }

  @override
  void cancel(dynamic handle) {
    _scheduled.removeWhere((item) => item.id == handle);
  }

  /// Triggers the next pending timer immediately.
  bool tickNext() {
    if (_scheduled.isEmpty) return false;
    final item = _scheduled.removeAt(0);
    item.callback();
    return true;
  }

  /// Triggers all pending timers.
  void tickAll() {
    while (_scheduled.isNotEmpty) {
      final item = _scheduled.removeAt(0);
      item.callback();
    }
  }

  bool get hasPending => _scheduled.isNotEmpty;
  int get pendingCount => _scheduled.length;
}

/// Pure Dart Simulator Controller state machine.
class SimulatorController {
  SimulatorController({
    required this.timeline,
    SimulatorClock? clock,
    bool autoMode = true,
    double speed = 1.0,
  }) : _clock = clock ?? DefaultSimulatorClock(),
       _isAutoMode = autoMode,
       _speed = speed {
    _currentRakat = timeline.isNotEmpty ? timeline[0].rakat : null;
  }

  final Timeline timeline;
  final SimulatorClock _clock;

  int _currentStepIndex = 0;
  int _currentRepeat = 1;
  bool _isPlaying = false;
  bool _isAutoMode = true;
  double _speed = 1.0;
  bool _isMuted = false;
  int? _currentRakat;
  dynamic _pendingTimerHandle;

  final StreamController<SimulatorEvent> _eventsController =
      StreamController<SimulatorEvent>.broadcast(sync: true);

  // Getters
  Stream<SimulatorEvent> get events => _eventsController.stream;
  int get currentStepIndex => _currentStepIndex;
  int get currentRepeat => _currentRepeat;
  bool get isPlaying => _isPlaying;
  bool get isAutoMode => _isAutoMode;
  double get speed => _speed;
  bool get isMuted => _isMuted;
  int? get currentRakat => _currentRakat;
  bool get isCompleted =>
      timeline.isNotEmpty && _currentStepIndex >= timeline.length - 1;

  SimStep? get currentStep =>
      timeline.isNotEmpty && _currentStepIndex < timeline.length
      ? timeline[_currentStepIndex]
      : null;

  int get totalSteps => timeline.length;

  /// Starts or resumes playback.
  void play() {
    if (timeline.isEmpty) return;
    if (_isPlaying) return;

    _isPlaying = true;
    _eventsController.add(const PlaybackStateChangedEvent(isPlaying: true));

    if (_isAutoMode) {
      _scheduleAutoAdvance();
    }
  }

  /// Pauses playback.
  void pause() {
    if (!_isPlaying) return;
    _isPlaying = false;
    _cancelPendingTimer();
    _eventsController.add(const PlaybackStateChangedEvent(isPlaying: false));
  }

  /// Toggles between play and pause.
  void togglePlayPause() {
    if (_isPlaying) {
      pause();
    } else {
      play();
    }
  }

  /// Sets playback speed (e.g. 0.75, 1.0, 1.25, 1.5).
  void setSpeed(double newSpeed) {
    if (newSpeed <= 0 || newSpeed == _speed) return;
    _speed = newSpeed;
    if (_isPlaying && _isAutoMode) {
      _cancelPendingTimer();
      _scheduleAutoAdvance();
    }
  }

  /// Enables or disables automatic step advancement.
  void setAutoMode(bool auto) {
    if (_isAutoMode == auto) return;
    _isAutoMode = auto;
    if (!_isAutoMode) {
      _cancelPendingTimer();
    } else if (_isPlaying) {
      _scheduleAutoAdvance();
    }
  }

  void toggleAutoMode() => setAutoMode(!_isAutoMode);

  /// Toggles mute state.
  void toggleMute() {
    _isMuted = !_isMuted;
  }

  /// Manually advances the repeat counter for current step.
  /// If repeats reach step total, advances to next step.
  void repeatTick() {
    final step = currentStep;
    if (step == null) return;

    if (_currentRepeat < step.repeat) {
      _currentRepeat++;
      _eventsController.add(
        RepeatTickEvent(
          currentRepeat: _currentRepeat,
          totalRepeats: step.repeat,
        ),
      );
    } else {
      next();
    }
  }

  /// Advances to next step.
  void next() {
    _cancelPendingTimer();
    if (_currentStepIndex < timeline.length - 1) {
      _currentStepIndex++;
      _currentRepeat = 1;
      _onStepUpdated();

      if (_isPlaying && _isAutoMode) {
        _scheduleAutoAdvance();
      }
    } else {
      // Completed last step
      _isPlaying = false;
      _eventsController.add(const PlaybackStateChangedEvent(isPlaying: false));
      _eventsController.add(
        SimulationCompletedEvent(
          totalSteps: timeline.length,
          totalRakats: timeline.metadata.totalRakats,
        ),
      );
    }
  }

  /// Moves back to previous step.
  void previous() {
    _cancelPendingTimer();
    if (_currentStepIndex > 0) {
      _currentStepIndex--;
      _currentRepeat = 1;
      _onStepUpdated();

      if (_isPlaying && _isAutoMode) {
        _scheduleAutoAdvance();
      }
    }
  }

  /// Replays the current step from repeat 1.
  void replayStep() {
    _cancelPendingTimer();
    _currentRepeat = 1;
    _onStepUpdated();

    if (_isPlaying && _isAutoMode) {
      _scheduleAutoAdvance();
    }
  }

  /// Seeks to a specific step index.
  void seek(int stepIndex) {
    if (stepIndex < 0 || stepIndex >= timeline.length) return;
    _cancelPendingTimer();
    _currentStepIndex = stepIndex;
    _currentRepeat = 1;
    _onStepUpdated();

    if (_isPlaying && _isAutoMode) {
      _scheduleAutoAdvance();
    }
  }

  /// Resets simulation back to step 0.
  void reset() {
    _cancelPendingTimer();
    _isPlaying = false;
    _currentStepIndex = 0;
    _currentRepeat = 1;
    _currentRakat = timeline.isNotEmpty ? timeline[0].rakat : null;
    _eventsController.add(const PlaybackStateChangedEvent(isPlaying: false));
    _onStepUpdated();
  }

  void _onStepUpdated() {
    final step = currentStep;
    if (step == null) return;

    _eventsController.add(
      StepChangedEvent(stepIndex: _currentStepIndex, step: step),
    );
    _eventsController.add(
      RepeatTickEvent(currentRepeat: _currentRepeat, totalRepeats: step.repeat),
    );

    if (step.rakat != _currentRakat) {
      _currentRakat = step.rakat;
      _eventsController.add(RakatChangedEvent(rakat: _currentRakat));
    }
  }

  void _scheduleAutoAdvance() {
    final step = currentStep;
    if (step == null) return;

    // Duration scaled by playback speed (e.g. 1.5x speed divides delay by 1.5)
    final baseMs = step.durationHintMs;
    final scaledMs = (baseMs / _speed).round().clamp(500, 60000);

    _pendingTimerHandle = _clock.schedule(Duration(milliseconds: scaledMs), () {
      if (_isPlaying && _isAutoMode) {
        next();
      }
    });
  }

  void _cancelPendingTimer() {
    if (_pendingTimerHandle != null) {
      _clock.cancel(_pendingTimerHandle);
      _pendingTimerHandle = null;
    }
  }

  /// Releases resources.
  void dispose() {
    _cancelPendingTimer();
    _eventsController.close();
  }
}
