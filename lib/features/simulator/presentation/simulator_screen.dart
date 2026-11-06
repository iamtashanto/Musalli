// Namaj Simulator Flagship Screen.
//
// Combines the deterministic domain engine, the 2D articulated animated figure,
// ArabicBlock with word/line highlight synced to audio, circular repeat counter,
// full transport controls, keep-awake (wakelock_plus), interruption handling,
// and TalkBack announcements.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/features/simulator/domain/engine.dart';
import 'package:musalli/features/simulator/domain/simulator_controller.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/simulator/presentation/figure/simulator_figure.dart';
import 'package:musalli/features/simulator/presentation/setup/simulator_setup_sheet.dart';
import 'package:musalli/features/simulator/presentation/widgets/completion_dialog.dart';
import 'package:musalli/features/simulator/presentation/widgets/recitation_panel.dart';
import 'package:musalli/features/simulator/presentation/widgets/simulator_controls.dart';
import 'package:musalli/features/simulator/presentation/widgets/step_list_sheet.dart';
import 'package:musalli/features/simulator/presentation/widgets/timeline_progress_bar.dart';
import 'package:musalli/shared/content/content.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SimulatorScreen extends ConsumerStatefulWidget {
  const SimulatorScreen({
    this.initialPrayerSlug,
    this.initialUnitStatus,
    this.initialGenderStr,
    this.initialRoleStr,
    this.initialPostureModeStr,
    super.key,
  });

  final String? initialPrayerSlug;
  final String? initialUnitStatus;
  final String? initialGenderStr;
  final String? initialRoleStr;
  final String? initialPostureModeStr;

  @override
  ConsumerState<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends ConsumerState<SimulatorScreen>
    with WidgetsBindingObserver {
  SimulatorController? _controller;
  StreamSubscription<SimulatorEvent>? _eventSubscription;
  final AudioPlayer _audioPlayer = AudioPlayer();

  ContentPrayerType? _prayer;
  ContentRakatUnit? _unit;
  SimGender _gender = SimGender.male;
  SimRole _role = SimRole.alone;
  PostureMode _postureMode = PostureMode.standing;

  FigureViewMode _viewMode = FigureViewMode.side;
  Stopwatch _sessionStopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_initSimulator());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_eventSubscription?.cancel());
    _controller?.dispose();
    unawaited(_audioPlayer.dispose());
    unawaited(WakelockPlus.disable());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller?.pause();
      unawaited(_audioPlayer.pause());
      unawaited(WakelockPlus.disable());
    }
  }

  Future<void> _initSimulator() async {
    final prayers = await ref.read(prayersListProvider.future);
    if (prayers.isEmpty) return;

    // Resolve prayer by slug or default to Fajr
    final prayerSlug = widget.initialPrayerSlug ?? 'fajr';
    final prayer =
        prayers.where((p) => p.slug == prayerSlug).firstOrNull ?? prayers.first;

    // Resolve unit or default to first unit (or Fard if available)
    ContentRakatUnit unit = prayer.rakatUnits.first;
    if (widget.initialUnitStatus != null) {
      final matched = prayer.rakatUnits
          .where((u) => u.status.name == widget.initialUnitStatus)
          .firstOrNull;
      if (matched != null) unit = matched;
    }

    SimGender gender = SimGender.male;
    if (widget.initialGenderStr == 'female') {
      gender = SimGender.female;
    }

    SimRole role = SimRole.alone;
    if (widget.initialRoleStr == 'imam') {
      role = SimRole.imam;
    } else if (widget.initialRoleStr == 'muqtadi') {
      role = SimRole.muqtadi;
    }

    PostureMode postureMode = PostureMode.standing;
    if (widget.initialPostureModeStr == 'sittingFloor') {
      postureMode = PostureMode.sittingFloor;
    } else if (widget.initialPostureModeStr == 'sittingChair') {
      postureMode = PostureMode.sittingChair;
    }

    _loadPrayer(
      prayer: prayer,
      unit: unit,
      gender: gender,
      role: role,
      postureMode: postureMode,
      surahChoices: const {},
    );
  }

  void _loadPrayer({
    required ContentPrayerType prayer,
    required ContentRakatUnit unit,
    List<ContentRakatUnit>? multipleUnits,
    required SimGender gender,
    required SimRole role,
    PostureMode postureMode = PostureMode.standing,
    required Map<int, String> surahChoices,
  }) {
    unawaited(_eventSubscription?.cancel());
    _controller?.dispose();
    unawaited(_audioPlayer.stop());

    _prayer = prayer;
    _unit = unit;
    _gender = gender;
    _role = role;
    _postureMode = postureMode;

    final Timeline timeline;
    if (multipleUnits != null && multipleUnits.length > 1) {
      timeline = buildCombinedTimeline(
        multipleUnits,
        gender: gender,
        role: role,
        surahChoice: surahChoices,
        prayerSlug: prayer.slug,
        prayerNameBn: prayer.nameBn,
      );
    } else {
      timeline = buildTimeline(
        unit.config,
        gender: gender,
        role: role,
        prayerSlug: prayer.slug,
        unitLabel: unit.label,
        surahChoice: surahChoices,
      );
    }

    _controller = SimulatorController(timeline: timeline);

    _sessionStopwatch = Stopwatch()..start();

    _eventSubscription = _controller!.events.listen(_onSimulatorEvent);

    if (mounted) setState(() {});
  }

  void _onSimulatorEvent(SimulatorEvent event) {
    if (!mounted) return;

    switch (event) {
      case StepChangedEvent(:final step):
        unawaited(HapticFeedback.lightImpact());
        unawaited(_playStepAudio(step));
        _announceAccessibility(step);
        setState(() {});

      case RakatChangedEvent():
        unawaited(HapticFeedback.mediumImpact());
        setState(() {});

      case PlaybackStateChangedEvent(:final isPlaying):
        if (isPlaying) {
          unawaited(WakelockPlus.enable());
        } else {
          unawaited(WakelockPlus.disable());
          unawaited(_audioPlayer.pause());
        }
        setState(() {});

      case SimulationCompletedEvent():
        unawaited(HapticFeedback.heavyImpact());
        unawaited(WakelockPlus.disable());
        unawaited(_audioPlayer.stop());
        _showCompletionDialog();
        setState(() {});

      case RepeatTickEvent():
        unawaited(HapticFeedback.selectionClick());
        setState(() {});
    }
  }

  Future<void> _playStepAudio(SimStep step) async {
    if (_controller?.isMuted == true) return;

    try {
      // Priority 1: Spoken takbir (e.g. Allahu Akbar)
      if (step.spokenTakbir != null) {
        final takbirAsset = step.spokenTakbir!.contains('সামি')
            ? 'assets/audio/qawmah.mp3'
            : step.spokenTakbir!.contains('সালাম')
            ? 'assets/audio/salam.mp3'
            : 'assets/audio/allahu-akbar.mp3';

        await _audioPlayer.setAsset(takbirAsset);
        await _audioPlayer.play();
        return;
      }

      // Priority 2: Recitation audio if step has recitation IDs
      if (step.recitationIds.isNotEmpty) {
        final recId = step.recitationIds.first;
        String? assetPath;

        if (recId == 'dua-1') assetPath = 'assets/audio/sana.mp3';
        if (recId == 'dua-2') assetPath = 'assets/audio/tashahhud.mp3';
        if (recId == 'dua-3') assetPath = 'assets/audio/durood.mp3';
        if (recId == 'dua-4') assetPath = 'assets/audio/dua-masura.mp3';
        if (recId == 'dua-5') assetPath = 'assets/audio/qunut.mp3';
        if (recId == 'dua-6') assetPath = 'assets/audio/ruku-tasbih.mp3';
        if (recId == 'dua-7') assetPath = 'assets/audio/sajda-tasbih.mp3';
        if (recId == 'dua-qawmah') assetPath = 'assets/audio/qawmah.mp3';
        if (recId == 'dua-jalsah') assetPath = 'assets/audio/jalsah.mp3';
        if (recId == 'taawwuz' || recId == 'dua-taawwuz') assetPath = 'assets/audio/taawwuz.mp3';
        if (recId == 'tasmiyah' || recId == 'dua-tasmiyah') assetPath = 'assets/audio/tasmiyah.mp3';
        if (recId.startsWith('surah-')) {
          final surahNum = recId.replaceFirst('surah-', '');
          assetPath = 'assets/audio/surah-$surahNum.mp3';
        }

        if (assetPath != null) {
          await _audioPlayer.setAsset(assetPath);
          await _audioPlayer.play();
        }
      }
    } catch (_) {}
  }

  void _announceAccessibility(SimStep step) {
    if (!mounted) return;
    final rakatInfo = step.rakat != null
        ? '${BengaliNumbers.toBengali(step.rakat)}ম রাকাত, '
        : '';
    unawaited(
      SemanticsService.sendAnnouncement(
        View.of(context),
        '$rakatInfo${step.titleBn}: ${step.instructionBn}',
        TextDirection.ltr,
      ),
    );
  }

  void _showCompletionDialog() {
    if (_controller == null || !mounted) return;

    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return CompletionDialog(
            timeline: _controller!.timeline,
            duration: _sessionStopwatch.elapsed,
            commonMistakes: _prayer?.commonMistakes ?? const [],
            onPracticeQuiz: () {
              // Navigate to practice quiz mode
              unawaited(context.push('/simulator/practice'));
            },
            onAnotherPrayer: _openSetupSheet,
          );
        },
      ),
    );
  }

  Future<void> _openSetupSheet() async {
    _controller?.pause();

    final result = await showModalBottomSheet<SimulatorSetupConfig>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SimulatorSetupSheet(
        initialPrayerSlug: _prayer?.slug,
        initialGender: _gender,
        initialRole: _role,
        initialPostureMode: _postureMode,
      ),
    );

    if (result != null && mounted) {
      _loadPrayer(
        prayer: result.prayer,
        unit: result.unit,
        multipleUnits: result.selectedUnits,
        gender: result.gender,
        role: result.role,
        postureMode: result.postureMode,
        surahChoices: result.surahChoice,
      );
    }
  }

  void _openStepList() {
    if (_controller == null) return;

    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => StepListSheet(
          timeline: _controller!.timeline,
          currentStepIndex: _controller!.currentStepIndex,
          onSelectStep: (idx) {
            _controller!.seek(idx);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    if (_controller == null || _prayer == null || _unit == null) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircularProgressIndicator(color: colors.primaryEmerald),
        ),
      );
    }

    final currentStep = _controller!.currentStep ?? _controller!.timeline[0];
    final currentRakat = _controller!.currentRakat;
    final totalRakats = _controller!.timeline.metadata.totalRakats;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            // 1. Top Glass App Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.md,
                vertical: tokens.spacing.xxs,
              ),
              child: GlassCard(
                padding: EdgeInsets.symmetric(
                  horizontal: tokens.spacing.md,
                  vertical: tokens.spacing.xs,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button + Prayer Name & Unit Label
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                color: colors.textPrimary,
                                tooltip: 'হোমে ফিরে যান',
                                onPressed: () {
                                  unawaited(HapticFeedback.lightImpact());
                                  if (Navigator.of(context).canPop()) {
                                    Navigator.of(context).maybePop();
                                  } else {
                                    context.go('/');
                                  }
                                },
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _prayer!.nameBn,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: typography.titleMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      _unit!.label,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: typography.label.copyWith(
                                        color: colors.primaryEmerald,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),

                        // Rakat Badge & Setup Button
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (currentRakat != null && totalRakats > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.primaryEmerald.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    tokens.radii.full,
                                  ),
                                  border: Border.all(
                                    color: colors.primaryEmerald.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'রাকাত ${BengaliNumbers.toBengali(currentRakat)}/${BengaliNumbers.toBengali(totalRakats)}',
                                  style: typography.label.copyWith(
                                    color: colors.primaryEmerald,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.tune_rounded),
                              color: colors.textSecondary,
                              tooltip: 'নামাজ পরিবর্তন ও সেটিংস',
                              onPressed: _openSetupSheet,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Timeline Progress Bar
                    TimelineProgressBar(
                      timeline: _controller!.timeline,
                      currentStepIndex: _controller!.currentStepIndex,
                      onSeekStep: (idx) => _controller!.seek(idx),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Center Stage (Figure + Camera Switch Pill)
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Center Figure
                  Center(
                    child: SimulatorFigure(
                      posture: currentStep.posture,
                      gender: _gender,
                      postureMode: _postureMode,
                      viewMode: _viewMode,
                      speed: _controller!.speed,
                    ),
                  ),

                  // Floating Camera Angle Switcher (Top Right of Stage)
                  Positioned(
                    top: 8,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _viewMode = _viewMode == FigureViewMode.side
                              ? FigureViewMode.front
                              : FigureViewMode.side;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surfaceLowRamFallback.withValues(
                            alpha: 0.85,
                          ),
                          borderRadius: BorderRadius.circular(
                            tokens.radii.full,
                          ),
                          border: Border.all(color: colors.borderSubtle),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.switch_camera_rounded,
                              size: 14,
                              color: colors.primaryEmerald,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _viewMode == FigureViewMode.side
                                  ? 'পার্শ্ব দৃশ্য'
                                  : 'সম্মুখ দৃশ্য',
                              style: typography.label.copyWith(
                                color: colors.primaryEmerald,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Recitation & Instructions Panel (Constrained scrollable to avoid bottom overflow)
            Flexible(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: RecitationPanel(
                    step: currentStep,
                    currentRepeat: _controller!.currentRepeat,
                    onRepeatTick: () => _controller!.repeatTick(),
                    onPlayAudio: (asset) async {
                      try {
                        var path = asset;
                        if (path.startsWith('/')) {
                          path = 'assets$path';
                        }
                        await _audioPlayer.setAsset(path);
                        await _audioPlayer.play();
                      } catch (_) {}
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            // 4. Playback Controls Bar
            Padding(
              padding: EdgeInsets.fromLTRB(
                tokens.spacing.md,
                0,
                tokens.spacing.md,
                MediaQuery.paddingOf(context).bottom + tokens.spacing.sm,
              ),
              child: SimulatorControls(
                isPlaying: _controller!.isPlaying,
                isAutoMode: _controller!.isAutoMode,
                speed: _controller!.speed,
                isMuted: _controller!.isMuted,
                viewMode: _viewMode,
                onPlayPause: () => _controller!.togglePlayPause(),
                onNext: () => _controller!.next(),
                onPrevious: () => _controller!.previous(),
                onReplayStep: () => _controller!.replayStep(),
                onSpeedChanged: (s) => _controller!.setSpeed(s),
                onAutoModeToggle: () => _controller!.toggleAutoMode(),
                onMuteToggle: () {
                  setState(() => _controller!.toggleMute());
                  if (_controller!.isMuted) {
                    unawaited(_audioPlayer.pause());
                  }
                },
                onViewModeToggle: () {
                  setState(() {
                    _viewMode = _viewMode == FigureViewMode.side
                        ? FigureViewMode.front
                        : FigureViewMode.side;
                  });
                },
                onOpenStepList: _openStepList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
