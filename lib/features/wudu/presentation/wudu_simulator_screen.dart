import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/wudu/domain/wudu_engine.dart';
import 'package:musalli/features/wudu/domain/wudu_models.dart';
import 'package:musalli/features/wudu/presentation/figure/wudu_figure_painter.dart';

/// Flagship Wudu Simulator Screen with Step-by-Step interactive animation & Practice Quiz.
class WuduSimulatorScreen extends StatefulWidget {
  const WuduSimulatorScreen({super.key});

  @override
  State<WuduSimulatorScreen> createState() => _WuduSimulatorScreenState();
}

class _WuduSimulatorScreenState extends State<WuduSimulatorScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final WuduEngine _engine;
  late final WuduTimeline _timeline;
  late final List<WuduPracticeQuestion> _quizQuestions;

  int _currentStepIndex = 0;
  bool _isPlaying = false;
  Timer? _autoPlayTimer;

  // Quiz state
  int _quizIndex = 0;
  int? _selectedQuizOption;
  bool _isQuizAnswerSubmitted = false;
  int _quizScore = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _engine = const WuduEngine();
    _timeline = _engine.buildTimeline();
    _quizQuestions = _engine.generatePracticeQuestions();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _toggleAutoPlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    _autoPlayTimer?.cancel();
    if (_isPlaying) {
      _autoPlayTimer = Timer.periodic(const Duration(seconds: 8), (_) {
        if (_currentStepIndex + 1 < _timeline.length) {
          setState(() {
            _currentStepIndex++;
          });
        } else {
          _autoPlayTimer?.cancel();
          setState(() {
            _isPlaying = false;
          });
        }
      });
    }
  }

  void _goToStep(int index) {
    if (index >= 0 && index < _timeline.length) {
      setState(() {
        _currentStepIndex = index;
      });
    }
  }

  void _onQuizOptionSelected(int optionIndex) {
    if (_isQuizAnswerSubmitted) return;

    final q = _quizQuestions[_quizIndex];
    setState(() {
      _selectedQuizOption = optionIndex;
      _isQuizAnswerSubmitted = true;
      if (optionIndex == q.correctIndex) {
        _quizScore++;
        unawaited(HapticFeedback.lightImpact());
      } else {
        unawaited(HapticFeedback.heavyImpact());
      }
    });
  }

  void _nextQuizQuestion() {
    if (_quizIndex + 1 < _quizQuestions.length) {
      setState(() {
        _quizIndex++;
        _selectedQuizOption = null;
        _isQuizAnswerSubmitted = false;
      });
    } else {
      // Quiz finished modal
      _showQuizResultDialog();
    }
  }

  void _showQuizResultDialog() {
    final tokens = context.tokens;
    final percent = ((_quizScore / _quizQuestions.length) * 100).round();

    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: GlassCard(
            padding: EdgeInsets.all(tokens.spacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'অজু অনুশীলন সম্পন্ন!',
                  style: tokens.typography.titleLarge,
                ),
                SizedBox(height: tokens.spacing.md),
                Text(
                  '${BengaliNumbers.toBengali(percent)}%',
                  style: tokens.typography.display.copyWith(
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${BengaliNumbers.toBengali(_quizScore)} / ${BengaliNumbers.toBengali(_quizQuestions.length)} সঠিক',
                  style: tokens.typography.bodyMedium.copyWith(
                    color: tokens.colors.textSecondary,
                  ),
                ),
                SizedBox(height: tokens.spacing.lg),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _quizIndex = 0;
                      _selectedQuizOption = null;
                      _isQuizAnswerSubmitted = false;
                      _quizScore = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: tokens.radii.borderMd,
                    ),
                  ),
                  child: const Text('আবার চেষ্টা করুন'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text('অজু সিমুলেটর', style: typography.titleMedium),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF10B981),
          labelColor: const Color(0xFF10B981),
          unselectedLabelColor: colors.textSecondary,
          tabs: const [
            Tab(icon: Icon(Icons.water_drop_outlined), text: 'অজু শিখুন'),
            Tab(icon: Icon(Icons.quiz_outlined), text: 'অজু অনুশীলন'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: LEARN / SIMULATOR
          _buildSimulatorTab(context),

          // TAB 2: PRACTICE / QUIZ
          _buildPracticeTab(context),
        ],
      ),
    );
  }

  Widget _buildSimulatorTab(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;
    final step = _timeline[_currentStepIndex];

    final (rulingBadgeBg, rulingBadgeText) = switch (step.ruling) {
      WuduRuling.fard => (
        const Color(0xFF10B981).withValues(alpha: 0.15),
        const Color(0xFF10B981),
      ),
      WuduRuling.sunnat => (
        const Color(0xFF3B82F6).withValues(alpha: 0.15),
        const Color(0xFF3B82F6),
      ),
      WuduRuling.mustahab => (
        const Color(0xFFF59E0B).withValues(alpha: 0.15),
        const Color(0xFFF59E0B),
      ),
    };

    return SafeArea(
      child: Column(
        children: [
          // Header Indicators
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.xs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Step Pill
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.sm,
                    vertical: tokens.spacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceGlassTint,
                    borderRadius: tokens.radii.borderSm,
                    border: Border.all(color: colors.borderSubtle),
                  ),
                  child: Text(
                    'ধাপ ${BengaliNumbers.toBengali(_currentStepIndex + 1)} / ${BengaliNumbers.toBengali(_timeline.length)}',
                    style: typography.label.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Ruling Badge (Fard vs Sunnat)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.sm,
                    vertical: tokens.spacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: rulingBadgeBg,
                    borderRadius: tokens.radii.borderSm,
                  ),
                  child: Text(
                    step.ruling.labelBn,
                    style: typography.label.copyWith(
                      color: rulingBadgeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Repeat count
                Text(
                  '${BengaliNumbers.toBengali(step.repeatCount)} বার',
                  style: typography.label.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),

          // Wudu Articulated Figure Viewport with Water Animation
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: tokens.spacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceGlassTint,
                borderRadius: tokens.radii.borderMd,
                border: Border.all(color: colors.borderSubtle),
              ),
              child: ClipRRect(
                borderRadius: tokens.radii.borderMd,
                child: WuduFigureWidget(step: step),
              ),
            ),
          ),

          SizedBox(height: tokens.spacing.xs),

          // Instructions & Duas Card
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    step.titleBn,
                    style: typography.titleMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.xxs),
                  Text(
                    step.subtitleBn,
                    style: typography.label.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.xs),
                  Text(
                    step.instructionBn,
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),

                  // Dua box if present
                  if (step.arabicDua != null) ...[
                    SizedBox(height: tokens.spacing.sm),
                    GlassCard(
                      padding: EdgeInsets.all(tokens.spacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            step.arabicDua!,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: typography.arabicBody.copyWith(
                              fontSize: 18,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                          if (step.pronunciationBn != null) ...[
                            SizedBox(height: tokens.spacing.xxs),
                            Text(
                              'উচ্চারণ: ${step.pronunciationBn!}',
                              style: typography.label.copyWith(
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                          if (step.meaningBn != null) ...[
                            SizedBox(height: tokens.spacing.xxs),
                            Text(
                              'অর্থ: ${step.meaningBn!}',
                              style: typography.label.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Control Navigation Bar
          Container(
            padding: EdgeInsets.all(tokens.spacing.sm),
            decoration: BoxDecoration(
              color: colors.surfaceGlassTint,
              border: Border(top: BorderSide(color: colors.borderSubtle)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: _currentStepIndex > 0
                      ? () => _goToStep(_currentStepIndex - 1)
                      : null,
                ),
                FloatingActionButton.small(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  onPressed: _toggleAutoPlay,
                  child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: _currentStepIndex + 1 < _timeline.length
                      ? () => _goToStep(_currentStepIndex + 1)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeTab(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;
    if (_quizQuestions.isEmpty) {
      return const Center(child: Text('কোন প্রশ্ন পাওয়া যায়নি'));
    }

    final q = _quizQuestions[_quizIndex];

    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Question Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'প্রশ্ন ${BengaliNumbers.toBengali(_quizIndex + 1)} / ${BengaliNumbers.toBengali(_quizQuestions.length)}',
                style: typography.label.copyWith(color: colors.textSecondary),
              ),
              if (q.isFardQuestion)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.xs,
                    vertical: tokens.spacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: tokens.radii.borderSm,
                  ),
                  child: Text(
                    'অজুর ফরজ সম্পর্কিত',
                    style: typography.label.copyWith(
                      color: const Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: tokens.spacing.sm),

          // Question Prompt
          Text(
            q.promptBn,
            style: typography.titleMedium.copyWith(color: colors.textPrimary),
          ),

          SizedBox(height: tokens.spacing.md),

          // Options List
          ...q.options.asMap().entries.map((entry) {
            final idx = entry.key;
            final label = entry.value;
            final isSelected = _selectedQuizOption == idx;
            final isSubmitted = _isQuizAnswerSubmitted;

            Color btnBg = colors.surfaceGlassTint;
            Color borderCol = colors.borderSubtle;
            Color textCol = colors.textPrimary;

            if (isSubmitted) {
              if (idx == q.correctIndex) {
                btnBg = const Color(0xFF10B981).withValues(alpha: 0.2);
                borderCol = const Color(0xFF10B981);
                textCol = const Color(0xFF10B981);
              } else if (isSelected) {
                btnBg = const Color(0xFFEF4444).withValues(alpha: 0.2);
                borderCol = const Color(0xFFEF4444);
                textCol = const Color(0xFFEF4444);
              }
            }

            return Padding(
              padding: EdgeInsets.only(bottom: tokens.spacing.xs),
              child: InkWell(
                onTap: isSubmitted ? null : () => _onQuizOptionSelected(idx),
                borderRadius: tokens.radii.borderMd,
                child: Container(
                  padding: EdgeInsets.all(tokens.spacing.md),
                  decoration: BoxDecoration(
                    color: btnBg,
                    borderRadius: tokens.radii.borderMd,
                    border: Border.all(color: borderCol, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          style: typography.bodyMedium.copyWith(
                            color: textCol,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isSubmitted && idx == q.correctIndex)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF10B981),
                          size: 22,
                        )
                      else if (isSubmitted &&
                          isSelected &&
                          idx != q.correctIndex)
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

          // Explanation upon submission
          if (_isQuizAnswerSubmitted) ...[
            SizedBox(height: tokens.spacing.sm),
            GlassCard(
              padding: EdgeInsets.all(tokens.spacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Color(0xFF10B981),
                      ),
                      SizedBox(width: tokens.spacing.xs),
                      Text(
                        'সঠিক ব্যাখ্যা',
                        style: typography.label.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacing.xxs),
                  Text(
                    q.explanationBn,
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: tokens.spacing.md),

            ElevatedButton(
              onPressed: _nextQuizQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: tokens.spacing.sm),
                shape: RoundedRectangleBorder(
                  borderRadius: tokens.radii.borderMd,
                ),
              ),
              child: Text(
                _quizIndex + 1 < _quizQuestions.length
                    ? 'পরবর্তী প্রশ্ন ❯'
                    : 'ফলাফল দেখুন ✨',
                style: typography.label.copyWith(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
