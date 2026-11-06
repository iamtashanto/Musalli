import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/simulator/data/practice_repository.dart';
import 'package:musalli/features/simulator/domain/engine.dart';
import 'package:musalli/features/simulator/domain/practice/practice_engine.dart';
import 'package:musalli/features/simulator/domain/practice/practice_models.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/simulator/presentation/figure/simulator_figure.dart';
import 'package:musalli/features/simulator/presentation/practice/widgets/practice_results_dialog.dart';
import 'package:musalli/features/simulator/presentation/practice/widgets/shake_widget.dart';
import 'package:musalli/shared/content/salah_config.dart';

/// Full interactive Practice / Quiz Mode screen (/simulator/practice).
class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({
    super.key,
    this.prayerSlug = 'fajr',
    this.initialDifficulty = PracticeDifficulty.standard,
  });

  final String prayerSlug;
  final PracticeDifficulty initialDifficulty;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  late PracticeDifficulty _difficulty;
  late final PracticeEngine _engine;
  late List<PracticeQuestion> _questions;

  int _currentIndex = 0;
  int _correctCount = 0;
  int _wrongCount = 0;
  final List<WeakAreaItem> _weakAreas = [];

  String? _selectedOptionId;
  bool _isAnswerSubmitted = false;
  bool _showLearnerHint = false;

  final ShakeController _shakeController = ShakeController();
  final Stopwatch _sessionStopwatch = Stopwatch();

  // Expert Mode 15s Timer
  Timer? _countdownTimer;
  int _secondsRemaining = 15;

  @override
  void initState() {
    super.initState();
    _difficulty = widget.initialDifficulty;
    _engine = const PracticeEngine();
    _loadQuestions();
    _sessionStopwatch.start();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _sessionStopwatch.stop();
    super.dispose();
  }

  void _loadQuestions() {
    final config = _getConfigForPrayer(widget.prayerSlug);
    final timeline = buildTimeline(
      config,
      gender: SimGender.male,
      role: SimRole.alone,
      prayerSlug: widget.prayerSlug,
      unitLabel: 'fard',
    );

    _questions = _engine.generateQuestions(timeline, difficulty: _difficulty);
    _currentIndex = 0;
    _correctCount = 0;
    _wrongCount = 0;
    _weakAreas.clear();
    _isAnswerSubmitted = false;
    _selectedOptionId = null;
    _showLearnerHint = false;

    _startTimerForQuestion();
  }

  ContentSalahConfig _getConfigForPrayer(String slug) {
    return switch (slug) {
      'dhuhr' || 'asr' => const ContentSalahConfig(
        rakats: 4,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
      ),
      'maghrib' => const ContentSalahConfig(
        rakats: 3,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
        jahr: [1, 2],
      ),
      'isha' => const ContentSalahConfig(
        rakats: 4,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
        jahr: [1, 2],
      ),
      'witr' => const ContentSalahConfig(
        rakats: 3,
        qiratRakats: [1, 2, 3],
        firstSittingAfter: 2,
        hasQunut: QunutConfig(enabled: true, rakat: 3),
      ),
      _ => const ContentSalahConfig(
        rakats: 2,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
        jahr: [1, 2],
      ),
    };
  }

  void _startTimerForQuestion() {
    _countdownTimer?.cancel();
    if (_difficulty == PracticeDifficulty.expert && !_isAnswerSubmitted) {
      _secondsRemaining = 15;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 1) {
          setState(() => _secondsRemaining--);
        } else {
          timer.cancel();
          _handleTimeUp();
        }
      });
    }
  }

  void _handleTimeUp() {
    if (_isAnswerSubmitted) return;
    unawaited(HapticFeedback.heavyImpact());
    _shakeController.shake();

    final currentQ = _questions[_currentIndex];
    setState(() {
      _isAnswerSubmitted = true;
      _wrongCount++;
      _weakAreas.add(
        WeakAreaItem(
          questionType: currentQ.type,
          topicBn: currentQ.promptBn,
          adviceBn: 'সময় শেষ! সঠিক নিয়ম: ${currentQ.correctExplanationBn}',
          ruleSlug: currentQ.ruleSlug,
        ),
      );
    });
  }

  void _selectOption(PracticeOption option) {
    if (_isAnswerSubmitted) return;
    _countdownTimer?.cancel();

    final currentQ = _questions[_currentIndex];
    setState(() {
      _selectedOptionId = option.id;
      _isAnswerSubmitted = true;

      if (option.isCorrect) {
        _correctCount++;
        unawaited(HapticFeedback.lightImpact());
      } else {
        _wrongCount++;
        unawaited(HapticFeedback.heavyImpact());
        _shakeController.shake();

        _weakAreas.add(
          WeakAreaItem(
            questionType: currentQ.type,
            topicBn: currentQ.promptBn,
            adviceBn:
                '${currentQ.correctExplanationBn} (${currentQ.fiqhImpact.titleBn})',
            ruleSlug: currentQ.ruleSlug,
          ),
        );
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex + 1 < _questions.length) {
      setState(() {
        _currentIndex++;
        _selectedOptionId = null;
        _isAnswerSubmitted = false;
        _showLearnerHint = false;
      });
      _startTimerForQuestion();
    } else {
      unawaited(_finishQuiz());
    }
  }

  Future<void> _finishQuiz() async {
    _countdownTimer?.cancel();
    _sessionStopwatch.stop();

    final scorePercent = _questions.isNotEmpty
        ? ((_correctCount / _questions.length) * 100).round()
        : 0;

    final badge = _engine.evaluateBadge(
      prayerSlug: widget.prayerSlug,
      scorePercent: scorePercent,
      difficulty: _difficulty,
    );

    final prayerName = switch (widget.prayerSlug) {
      'fajr' => 'ফজর নামাজ',
      'dhuhr' => 'যোহর নামাজ',
      'asr' => 'আসর নামাজ',
      'maghrib' => 'মাগরিব নামাজ',
      'isha' => 'ইশা নামাজ',
      'witr' => 'বিতর নামাজ',
      _ => 'নামাজ',
    };

    final result = PracticeResult(
      prayerSlug: widget.prayerSlug,
      prayerNameBn: prayerName,
      difficulty: _difficulty,
      totalQuestions: _questions.length,
      correctCount: _correctCount,
      wrongCount: _wrongCount,
      timeTakenSeconds: _sessionStopwatch.elapsed.inSeconds,
      weakAreas: _weakAreas,
      unlockedBadge: badge,
    );

    final repo = ref.read(practiceRepositoryProvider);
    await repo.saveResult(result);

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PracticeResultsDialog(
        result: result,
        onRetry: () {
          Navigator.of(context).pop();
          _loadQuestions();
        },
        onExit: () {
          Navigator.of(context).pop();
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('অনুশীলন মোড')),
        body: const Center(child: Text('কোন প্রশ্ন পাওয়া যায়নি')),
      );
    }

    final currentQuestion = _questions[_currentIndex];
    final activePosture =
        currentQuestion.options
            .where((o) => o.isCorrect && o.posture != null)
            .firstOrNull
            ?.posture ??
        Posture.standing;

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text(
          'অনুশীলন: ${_difficulty.labelBn}',
          style: typography.titleMedium,
        ),
        centerTitle: true,
        actions: [
          // Difficulty Switcher Popup
          PopupMenuButton<PracticeDifficulty>(
            icon: const Icon(Icons.tune),
            tooltip: 'কঠিন্যের মাত্রা পরিবর্তন',
            onSelected: (d) {
              setState(() {
                _difficulty = d;
                _loadQuestions();
              });
            },
            itemBuilder: (context) => PracticeDifficulty.values
                .map(
                  (d) => PopupMenuItem(
                    value: d,
                    child: Row(
                      children: [
                        if (d == _difficulty)
                          const Icon(
                            Icons.check,
                            size: 16,
                            color: Color(0xFF10B981),
                          )
                        else
                          const SizedBox(width: 16),
                        SizedBox(width: tokens.spacing.xs),
                        Text(d.labelBn),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Progress & Expert Timer
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.md,
                vertical: tokens.spacing.xs,
              ),
              child: Row(
                children: [
                  Text(
                    'প্রশ্ন ${BengaliNumbers.toBengali(_currentIndex + 1)} / ${BengaliNumbers.toBengali(_questions.length)}',
                    style: typography.label.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(width: tokens.spacing.md),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: tokens.radii.borderFull,
                      child: LinearProgressIndicator(
                        value: (_currentIndex + 1) / _questions.length,
                        backgroundColor: colors.surfaceGlassTint,
                        color: const Color(0xFF10B981),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  if (_difficulty == PracticeDifficulty.expert) ...[
                    SizedBox(width: tokens.spacing.md),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: tokens.spacing.sm,
                        vertical: tokens.spacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: _secondsRemaining <= 5
                            ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                            : colors.surfaceGlassTint,
                        borderRadius: tokens.radii.borderSm,
                        border: Border.all(
                          color: _secondsRemaining <= 5
                              ? const Color(0xFFEF4444)
                              : colors.borderSubtle,
                        ),
                      ),
                      child: Text(
                        '⏱️ ${BengaliNumbers.toBengali(_secondsRemaining)} সে.',
                        style: typography.label.copyWith(
                          color: _secondsRemaining <= 5
                              ? const Color(0xFFEF4444)
                              : colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Figure Viewport at Top
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: tokens.spacing.md),
                decoration: BoxDecoration(
                  color: colors.surfaceGlassTint,
                  borderRadius: tokens.radii.borderMd,
                  border: Border.all(color: colors.borderSubtle),
                ),
                child: Center(
                  child: SimulatorFigure(
                    posture: activePosture,
                    gender: SimGender.male,
                  ),
                ),
              ),
            ),

            SizedBox(height: tokens.spacing.sm),

            // Interactive Question Card with Shake Animation
            Expanded(
              flex: 6,
              child: ShakeWidget(
                controller: _shakeController,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Question Type Badge
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: tokens.spacing.sm,
                            vertical: tokens.spacing.xxs,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981)
                                .withValues(alpha: 0.15),
                            borderRadius: tokens.radii.borderSm,
                          ),
                          child: Text(
                            currentQuestion.type.labelBn,
                            style: typography.label.copyWith(
                              color: const Color(0xFF10B981),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: tokens.spacing.xs),

                      // Question Prompt
                      Text(
                        currentQuestion.promptBn,
                        style: typography.titleMedium.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),

                      // Learner Hint if enabled
                      if (_difficulty == PracticeDifficulty.learner &&
                          currentQuestion.hintBn != null) ...[
                        SizedBox(height: tokens.spacing.xs),
                        GestureDetector(
                          onTap: () => setState(
                            () => _showLearnerHint = !_showLearnerHint,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lightbulb_outline,
                                size: 16,
                                color: Color(0xFFF59E0B),
                              ),
                              SizedBox(width: tokens.spacing.xxs),
                              Text(
                                _showLearnerHint
                                    ? 'ইঙ্গিত লুকান'
                                    : '💡 ইঙ্গিত দেখুন',
                                style: typography.label.copyWith(
                                  color: const Color(0xFFF59E0B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_showLearnerHint)
                          Padding(
                            padding: EdgeInsets.only(top: tokens.spacing.xxs),
                            child: Text(
                              currentQuestion.hintBn!,
                              style: typography.label.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ),
                      ],

                      SizedBox(height: tokens.spacing.md),

                      // Options List
                      ...currentQuestion.options.map((option) {
                        final isSelected = _selectedOptionId == option.id;
                        final isSubmitted = _isAnswerSubmitted;

                        Color btnBg = colors.surfaceGlassTint;
                        Color borderCol = colors.borderSubtle;
                        Color textCol = colors.textPrimary;

                        if (isSubmitted) {
                          if (option.isCorrect) {
                            btnBg = const Color(0xFF10B981)
                                .withValues(alpha: 0.2);
                            borderCol = const Color(0xFF10B981);
                            textCol = const Color(0xFF10B981);
                          } else if (isSelected) {
                            btnBg = const Color(0xFFEF4444)
                                .withValues(alpha: 0.2);
                            borderCol = const Color(0xFFEF4444);
                            textCol = const Color(0xFFEF4444);
                          }
                        }

                        return Padding(
                          padding: EdgeInsets.only(bottom: tokens.spacing.xs),
                          child: InkWell(
                            onTap: isSubmitted
                                ? null
                                : () => _selectOption(option),
                            borderRadius: tokens.radii.borderMd,
                            child: Container(
                              padding: EdgeInsets.all(tokens.spacing.sm),
                              decoration: BoxDecoration(
                                color: btnBg,
                                borderRadius: tokens.radii.borderMd,
                                border: Border.all(
                                  color: borderCol,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          option.labelBn,
                                          style: typography.bodyMedium.copyWith(
                                            color: textCol,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (option.arabicText != null) ...[
                                          SizedBox(height: tokens.spacing.xxs),
                                          Text(
                                            option.arabicText!,
                                            textDirection: TextDirection.rtl,
                                            style: typography.arabicBody
                                                .copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  if (isSubmitted && option.isCorrect)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF10B981),
                                      size: 22,
                                    )
                                  else if (isSubmitted &&
                                      isSelected &&
                                      !option.isCorrect)
                                    const Icon(
                                      Icons.cancel,
                                      color: Color(0xFFEF4444),
                                      size: 22,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                      // Explanation & Masail Impact upon submission
                      if (_isAnswerSubmitted) ...[
                        SizedBox(height: tokens.spacing.xs),
                        GlassCard(
                          padding: EdgeInsets.all(tokens.spacing.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    currentQuestion.fiqhImpact ==
                                            MistakeFiqhImpact.invalidatesSalah
                                        ? Icons.error
                                        : Icons.info_outline,
                                    size: 16,
                                    color:
                                        currentQuestion.fiqhImpact ==
                                            MistakeFiqhImpact.invalidatesSalah
                                        ? const Color(0xFFEF4444)
                                        : const Color(0xFFF59E0B),
                                  ),
                                  SizedBox(width: tokens.spacing.xs),
                                  Text(
                                    'মাসআলা বিধান: ${currentQuestion.fiqhImpact.titleBn}',
                                    style: typography.label.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          currentQuestion.fiqhImpact ==
                                              MistakeFiqhImpact.invalidatesSalah
                                          ? const Color(0xFFEF4444)
                                          : const Color(0xFFF59E0B),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: tokens.spacing.xxs),
                              Text(
                                currentQuestion.correctExplanationBn,
                                style: typography.bodyMedium.copyWith(
                                  color: colors.textPrimary,
                                ),
                              ),
                              SizedBox(height: tokens.spacing.xxs),
                              Text(
                                currentQuestion.fiqhImpact.rulingDetailBn,
                                style: typography.label.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: tokens.spacing.md),

                        // Next Question Action Button
                        ElevatedButton(
                          onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: tokens.spacing.sm,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: tokens.radii.borderMd,
                            ),
                          ),
                          child: Text(
                            _currentIndex + 1 < _questions.length
                                ? 'পরবর্তী প্রশ্ন ❯'
                                : 'ফলাফল দেখুন ✨',
                            style: typography.label.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
