import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/kids/data/kids_repository.dart';
import 'package:musalli/features/kids/domain/kids_models.dart';
import 'package:musalli/features/kids/domain/kids_service.dart';
import 'package:musalli/features/kids/presentation/widgets/parent_gate_dialog.dart';

/// Flagship Kids Mode Hub Screen (/kids).
///
/// Features large friendly buttons, simple Bangla, stars & stickers,
/// a 6-stage progressive learning path, parent lock, and strictly NO ads or external links.
class KidsHubScreen extends ConsumerStatefulWidget {
  const KidsHubScreen({super.key});

  @override
  ConsumerState<KidsHubScreen> createState() => _KidsHubScreenState();
}

class _KidsHubScreenState extends ConsumerState<KidsHubScreen> {
  final KidsService _service = const KidsService();

  void _onExitKidsMode() {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => ParentGateDialog(
          titleBn: 'কিডস মোড থেকে প্রস্থান 🛡️',
          onVerified: () {
            if (mounted) {
              context.pop();
            }
          },
        ),
      ),
    );
  }

  void _showStickerAlbum(KidsProgress progress) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;
    final allLessons = _service.getLessons();

    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: colors.backgroundStart,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(tokens.radii.lg),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(tokens.spacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🎖️ আমার স্টিকার অ্যালবাম', style: typography.titleLarge),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'অর্জিত স্টিকার: ${BengaliNumbers.toBengali(progress.collectedStickers.length)} / ${BengaliNumbers.toBengali(allLessons.length)}',
                  style: typography.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: tokens.spacing.md),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: allLessons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                    itemBuilder: (context, index) {
                      final lesson = allLessons[index];
                      final isUnlocked = progress.collectedStickers.contains(
                        lesson.stickerName,
                      );

                      return Container(
                        padding: EdgeInsets.all(tokens.spacing.xs),
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? const Color(0xFFF59E0B).withValues(alpha: 0.15)
                              : colors.surfaceGlassTint,
                          borderRadius: tokens.radii.borderMd,
                          border: Border.all(
                            color: isUnlocked
                                ? const Color(0xFFF59E0B)
                                : colors.borderSubtle,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isUnlocked ? lesson.stickerEmoji : '🔒',
                              style: const TextStyle(fontSize: 32),
                            ),
                            SizedBox(height: tokens.spacing.xxs),
                            Text(
                              isUnlocked ? lesson.stickerName : 'লক করা',
                              textAlign: TextAlign.center,
                              style: typography.label.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isUnlocked
                                    ? colors.textPrimary
                                    : colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchLesson(KidsLesson lesson) async {
    // Navigate to target lesson
    await context.push(lesson.targetRoute);

    // On return, award 3 stars and sticker if completed
    final repo = ref.read(kidsRepositoryProvider);
    await repo.completeLesson(
      lessonId: lesson.id,
      stars: 3,
      stickerName: lesson.stickerName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final progressAsync = ref.watch(kidsProgressStreamProvider);
    final progress = progressAsync.value ?? KidsProgress.initial;
    final lessons = _service.getLessons();

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      body: SafeArea(
        child: Column(
          children: [
            // Cheerful Top Banner
            Padding(
              padding: EdgeInsets.all(tokens.spacing.md),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: 'প্রস্থান',
                    onPressed: _onExitKidsMode,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ছোটদের সালাত একাডেমি 🌟',
                          style: typography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                        Text(
                          'এসো আনন্দের সাথে নামাজ শিখি!',
                          style: typography.label.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Sticker Album Button
                  ElevatedButton.icon(
                    onPressed: () => _showStickerAlbum(progress),
                    icon: const Text('🎖️', style: TextStyle(fontSize: 18)),
                    label: Text(
                      '${BengaliNumbers.toBengali(progress.totalStars)} ⭐',
                      style: typography.label.copyWith(
                        color: const Color(0xFFF59E0B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.surfaceGlassTint,
                      foregroundColor: colors.textPrimary,
                      elevation: 0,
                      side: BorderSide(color: colors.borderSubtle),
                      shape: RoundedRectangleBorder(
                        borderRadius: tokens.radii.borderFull,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progressive Learning Path (List of 6 stages)
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: tokens.spacing.md,
                  vertical: tokens.spacing.xs,
                ),
                itemCount: lessons.length,
                separatorBuilder: (_, _) => SizedBox(height: tokens.spacing.md),
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  final isUnlocked = _service.isLessonUnlocked(
                    lesson.id,
                    progress.completedLessonIds,
                  );
                  final isDone = progress.isCompleted(lesson.id);
                  final stars = progress.getStars(lesson.id);

                  return GlassCard(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            // Big Emoji Icon
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: isUnlocked
                                    ? const Color(0xFF10B981)
                                          .withValues(alpha: 0.15)
                                    : colors.surfaceGlassTint,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isUnlocked
                                      ? const Color(0xFF10B981)
                                      : colors.borderSubtle,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  isUnlocked ? lesson.iconEmoji : '🔒',
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                            ),
                            SizedBox(width: tokens.spacing.md),

                            // Title & Subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lesson.titleBn,
                                    style: typography.titleMedium.copyWith(
                                      color: isUnlocked
                                          ? colors.textPrimary
                                          : colors.textSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: tokens.spacing.xxs),
                                  Text(
                                    lesson.subtitleBn,
                                    style: typography.bodyMedium.copyWith(
                                      color: isUnlocked
                                          ? colors.textSecondary
                                          : colors.borderSubtle,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Stars if completed
                            if (isDone) ...[
                              Row(
                                children: List.generate(
                                  3,
                                  (i) => Icon(
                                    i < stars ? Icons.star : Icons.star_border,
                                    color: const Color(0xFFF59E0B),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        SizedBox(height: tokens.spacing.sm),

                        Text(
                          lesson.descriptionBn,
                          style: typography.label.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),

                        SizedBox(height: tokens.spacing.sm),

                        // Action Button
                        ElevatedButton(
                          onPressed: isUnlocked
                              ? () => _launchLesson(lesson)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDone
                                ? const Color(0xFF10B981)
                                : const Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: colors.surfaceGlassTint,
                            disabledForegroundColor: colors.borderSubtle,
                            padding: EdgeInsets.symmetric(
                              vertical: tokens.spacing.sm,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: tokens.radii.borderMd,
                            ),
                          ),
                          child: Text(
                            isUnlocked
                                ? (isDone ? 'আবার দেখি 🔁' : 'শুরু করি 🚀')
                                : 'আগের ধাপটি শেষ করুন 🔒',
                            style: typography.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
