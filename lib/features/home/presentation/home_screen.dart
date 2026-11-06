import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/motion/musalli_page_transitions.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/shared/content/content.dart';

/// Tab 1: Home (`হোম`) screen with live waqt countdown hero, prayer tracker strip,
/// simulator CTA card, continue learning card, ayah/hadith of the day, and quick actions.
class HomeScreen extends ConsumerStatefulWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Today's prayer completion state (Fajr, Dhuhr, Asr, Maghrib, Isha)
  final Set<String> _completedPrayers = {'fajr'};
  Timer? _ticker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _togglePrayer(String slug) {
    unawaited(HapticFeedback.lightImpact());
    setState(() {
      if (_completedPrayers.contains(slug)) {
        _completedPrayers.remove(slug);
      } else {
        _completedPrayers.add(slug);
      }
    });
  }

  ({String currentWaqt, String nextWaqt, String countdown, String timeWindow})
  _calculateWaqtInfo() {
    final hour = _now.hour;
    final minute = _now.minute;
    final totalMinutes = hour * 60 + minute;

    // Approximate Bangladesh waqt schedule
    if (totalMinutes >= 5 * 60 && totalMinutes < 12 * 60) {
      final rem = (12 * 60) - totalMinutes;
      final remH = rem ~/ 60;
      final remM = rem % 60;
      return (
        currentWaqt: 'ফজর',
        nextWaqt: 'যোহর',
        countdown:
            'বাকি ${BengaliNumberFormatter.toBengali(remH)} ঘণ্টা ${BengaliNumberFormatter.toBengali(remM)} মিনিট',
        timeWindow: 'ভোর ৫:০০ – সকাল ৬:১৫',
      );
    } else if (totalMinutes >= 12 * 60 && totalMinutes < 16 * 60 + 30) {
      final rem = (16 * 60 + 30) - totalMinutes;
      final remH = rem ~/ 60;
      final remM = rem % 60;
      return (
        currentWaqt: 'যোহর',
        nextWaqt: 'আসর',
        countdown:
            'বাকি ${BengaliNumberFormatter.toBengali(remH)} ঘণ্টা ${BengaliNumberFormatter.toBengali(remM)} মিনিট',
        timeWindow: 'দুপুর ১২:০০ – বিকাল ৪:৩০',
      );
    } else if (totalMinutes >= 16 * 60 + 30 && totalMinutes < 18 * 60 + 15) {
      final rem = (18 * 60 + 15) - totalMinutes;
      return (
        currentWaqt: 'আসর',
        nextWaqt: 'মাগরিব',
        countdown: 'বাকি ${BengaliNumberFormatter.toBengali(rem)} মিনিট',
        timeWindow: 'বিকাল ৪:৩০ – সন্ধ্যা ৬:১৫',
      );
    } else if (totalMinutes >= 18 * 60 + 15 && totalMinutes < 19 * 60 + 45) {
      final rem = (19 * 60 + 45) - totalMinutes;
      return (
        currentWaqt: 'মাগরিব',
        nextWaqt: 'এশা',
        countdown: 'বাকি ${BengaliNumberFormatter.toBengali(rem)} মিনিট',
        timeWindow: 'সন্ধ্যা ৬:১৫ – রাত ৭:৪৫',
      );
    } else {
      final rem = totalMinutes < 5 * 60
          ? (5 * 60) - totalMinutes
          : (24 * 60 - totalMinutes) + (5 * 60);
      final remH = rem ~/ 60;
      final remM = rem % 60;
      return (
        currentWaqt: 'এশা',
        nextWaqt: 'ফজর',
        countdown:
            'বাকি ${BengaliNumberFormatter.toBengali(remH)} ঘণ্টা ${BengaliNumberFormatter.toBengali(remM)} মিনিট',
        timeWindow: 'রাত ৭:৪৫ – রাত ৪:৪৫',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;
    final waqt = _calculateWaqtInfo();

    final prayersAsync = ref.watch(prayersListProvider);
    final hadithsAsync = ref.watch(hadithsListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          // Glass Sliver App Bar
          GlassSliverAppBar(
            title: 'মুসল্লি',
            actions: <Widget>[
              IconButton(
                tooltip: 'নামাজের সময়সূচি',
                icon: const Icon(Icons.schedule_rounded),
                onPressed: () => context.go('/times'),
              ),
              IconButton(
                tooltip: 'সেটিংস',
                icon: const Icon(Icons.tune_rounded),
                onPressed: () => context.go('/more'),
              ),
            ],
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.sm,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 1. Hero Glass Card: Waqt & Countdown
                FirstMountStaggeredEntrance(
                  index: 0,
                  child: GlassCard(
                    borderGlow: true,
                    padding: EdgeInsets.all(tokens.spacing.lg),
                    onTap: () => context.go('/times'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: colors.goldAccent,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'ঢাকা, বাংলাদেশ',
                                  style: typography.label.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colors.primaryEmerald.withValues(
                                  alpha: 0.15,
                                ),
                                borderRadius: BorderRadius.circular(
                                  tokens.radii.full,
                                ),
                              ),
                              child: Text(
                                'হানাফি অনুসারী',
                                style: typography.label.copyWith(
                                  color: colors.primaryEmerald,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: tokens.spacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'বর্তমান ওয়াক্ত',
                                  style: typography.bodyMedium.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  waqt.currentWaqt,
                                  style: typography.display.copyWith(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  waqt.timeWindow,
                                  style: typography.label.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'পরবর্তী: ${waqt.nextWaqt}',
                                  style: typography.bodyMedium.copyWith(
                                    color: colors.goldAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  waqt.countdown,
                                  style: typography.bodyMedium.copyWith(
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: tokens.spacing.md),
                        Divider(
                          color: colors.borderSubtle.withValues(alpha: 0.3),
                          height: 1,
                        ),
                        SizedBox(height: tokens.spacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '১৯ জিলকদ ১৪৪৫ হিজরি',
                              style: typography.label.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                            Text(
                              '২৩ জ্যৈষ্ঠ ১৪৩১ বঙ্গাব্দ',
                              style: typography.label.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // 2. "আজকের নামাজ" Tracker Strip
                FirstMountStaggeredEntrance(
                  index: 1,
                  child: GlassCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.spacing.md,
                      vertical: tokens.spacing.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'আজকের নামাজ ট্র্যাকার',
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              '${BengaliNumberFormatter.toBengali(_completedPrayers.length)}/৫ ওয়াক্ত',
                              style: typography.label.copyWith(
                                color: colors.primaryEmerald,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: tokens.spacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              [
                                ('fajr', 'ফজর'),
                                ('dhuhr', 'যোহর'),
                                ('asr', 'আসর'),
                                ('maghrib', 'মাগরিব'),
                                ('isha', 'এশা'),
                              ].map((item) {
                                final slug = item.$1;
                                final label = item.$2;
                                final isDone = _completedPrayers.contains(slug);

                                return GestureDetector(
                                  onTap: () => _togglePrayer(slug),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isDone
                                              ? colors.primaryEmerald
                                              : colors.surfaceGlassTint,
                                          border: Border.all(
                                            color: isDone
                                                ? colors.primaryEmerald
                                                : colors.borderSubtle,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Icon(
                                          isDone
                                              ? Icons.check_rounded
                                              : Icons.circle_outlined,
                                          size: 22,
                                          color: isDone
                                              ? Colors.white
                                              : colors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        label,
                                        style: typography.label.copyWith(
                                          color: isDone
                                              ? colors.primaryEmerald
                                              : colors.textSecondary,
                                          fontWeight: isDone
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // 3. Big CTA Card: "সিমুলেটরে নামাজ শিখুন"
                FirstMountStaggeredEntrance(
                  index: 2,
                  child: GlassCard(
                    borderGlow: true,
                    onTap: () => context.go('/simulator'),
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.primaryEmerald.withValues(
                              alpha: 0.15,
                            ),
                            border: Border.all(
                              color: colors.primaryEmerald.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.play_circle_filled_rounded,
                            size: 36,
                            color: colors.primaryEmerald,
                          ),
                        ),
                        SizedBox(width: tokens.spacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'সিমুলেটরে নামাজ শিখুন',
                                style: typography.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'অ্যানিমেটেড ফিগারের সাথে ধাপে ধাপে সহীহ নামাজ অনুশীলন করুন।',
                                style: typography.label.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: colors.primaryEmerald,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // 4. Quick Actions Grid
                FirstMountStaggeredEntrance(
                  index: 3,
                  child: Row(
                    children:
                        [
                          (
                            'কিবলা',
                            Icons.explore_rounded,
                            () => context.go('/times'),
                          ),
                          (
                            'তাসবীহ',
                            Icons.fingerprint_rounded,
                            () => context.go('/simulator'),
                          ),
                          (
                            'দোয়া',
                            Icons.favorite_border_rounded,
                            () => context.go('/learn'),
                          ),
                          (
                            'কুরআন',
                            Icons.menu_book_rounded,
                            () => context.go('/learn'),
                          ),
                        ].map((item) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: GlassCard(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                onTap: item.$3,
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      item.$2,
                                      size: 24,
                                      color: colors.primaryEmerald,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.$1,
                                      style: typography.label.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // 5. Featured Prayers Section
                SectionHeader(
                  title: 'দৈনিক নামাজ',
                  actionLabel: 'সব দেখুন',
                  onActionTap: () => context.go('/learn'),
                ),
                SizedBox(height: tokens.spacing.xs),

                prayersAsync.when(
                  loading: () => const GlassShimmerLoader(height: 120),
                  error: (err, _) => Text('Error: $err'),
                  data: (prayers) {
                    final daily = prayers
                        .where((p) => p.group == ContentPrayerGroup.dailyFard)
                        .toList();

                    return Column(
                      children: daily.map((p) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Hero(
                            tag: 'prayer-card-${p.slug}',
                            child: GlassCard(
                              onTap: () => context.push('/namaj/${p.slug}'),
                              padding: EdgeInsets.all(tokens.spacing.md),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: colors.primaryEmerald.withValues(
                                        alpha: 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        tokens.radii.md,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        BengaliNumberFormatter.toBengali(
                                          p.totalRakats,
                                        ),
                                        style: typography.titleMedium.copyWith(
                                          color: colors.primaryEmerald,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: tokens.spacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              p.nameBn,
                                              style: typography.titleMedium
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: colors.textPrimary,
                                                  ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '(${p.nameEn})',
                                              style: typography.label.copyWith(
                                                color: colors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          p.timeDescriptionBn,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: typography.bodyMedium.copyWith(
                                            color: colors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    p.nameAr,
                                    style: typography.arabicBody.copyWith(
                                      color: colors.primaryEmerald.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                SizedBox(height: tokens.spacing.md),

                // 6. Hadith of the Day
                hadithsAsync.when(
                  loading: () => const GlassShimmerLoader(height: 100),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (hadiths) {
                    if (hadiths.isEmpty) return const SizedBox.shrink();
                    final h = hadiths.first;

                    return GlassCard(
                      borderGlow: true,
                      padding: EdgeInsets.all(tokens.spacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'আজকের হাদিস',
                                style: typography.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colors.goldAccent,
                                ),
                              ),
                              ReferenceChip(
                                citation:
                                    '${h.reference.source} ${h.reference.number}',
                              ),
                            ],
                          ),
                          SizedBox(height: tokens.spacing.xs),
                          Text(
                            '"${h.textBn}"',
                            style: typography.bodyMedium.copyWith(
                              fontStyle: FontStyle.italic,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '— ${h.narratorBn}',
                            style: typography.label.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 100), // clearance for bottom navbar
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
