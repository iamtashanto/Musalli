import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/helpers/domain/masbuq_engine.dart';

/// Interactive Masbuq Calculator screen ("মাসবুক ক্যালকুলেটর").
class MasbuqCalculatorScreen extends StatefulWidget {
  const MasbuqCalculatorScreen({super.key});

  @override
  State<MasbuqCalculatorScreen> createState() => _MasbuqCalculatorScreenState();
}

class _MasbuqCalculatorScreenState extends State<MasbuqCalculatorScreen> {
  String _selectedPrayer = 'dhuhr';
  int _joinedRakat = 2;
  bool _joinedBeforeRuku = true;

  final Map<String, (String label, int rakats)> _prayers = {
    'fajr': ('ফজর (২)', 2),
    'dhuhr': ('যোহর (৪)', 4),
    'asr': ('আসর (৪)', 4),
    'maghrib': ('মাগরিব (৩)', 3),
    'isha': ('ইশা (৪)', 4),
    'jumuah': ('জুমআ (২)', 2),
  };

  void _onSelectPrayer(String key) {
    unawaited(HapticFeedback.selectionClick());
    final total = _prayers[key]!.$2;
    setState(() {
      _selectedPrayer = key;
      if (_joinedRakat > total) {
        _joinedRakat = total;
      }
    });
  }

  void _onSelectRakat(int rakat) {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _joinedRakat = rakat);
  }

  void _onToggleRuku(bool beforeRuku) {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _joinedBeforeRuku = beforeRuku);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final totalRakats = _prayers[_selectedPrayer]!.$2;
    final plan = MasbuqEngine.calculate(
      prayerSlug: _selectedPrayer,
      joinedRakat: _joinedRakat,
      joinedBeforeRuku: _joinedBeforeRuku,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          const GlassSliverAppBar(title: 'মাসবুক ক্যালকুলেটর'),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.sm,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Guidance Box
                GlassCard(
                  padding: EdgeInsets.all(tokens.spacing.md),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colors.primaryEmerald.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.groups_rounded,
                          color: colors.primaryEmerald,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: tokens.spacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'মাসবুক কাকে বলে?',
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'যে মুসল্লি ইমামের সাথে প্রথম থেকে শরিক হতে পারেনি এবং এক বা একাধিক রাকাত ছুটে গেছে।',
                              style: typography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // 1. Choose Prayer
                Text(
                  '১. কোন নামাজে শরিক হয়েছেন?',
                  style: typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _prayers.entries.map((entry) {
                      final isSelected = entry.key == _selectedPrayer;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: GlassChip(
                          label: entry.value.$1,
                          selected: isSelected,
                          onTap: () => _onSelectPrayer(entry.key),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // 2. Choose Joined Rakat
                Text(
                  '২. ইমামের কত নম্বর রাকাতে জামাতে শরিক হয়েছেন?',
                  style: typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                Row(
                  children: List.generate(totalRakats, (i) {
                    final rakatNum = i + 1;
                    final isSelected = _joinedRakat == rakatNum;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: i == totalRakats - 1 ? 0 : 8,
                        ),
                        child: GlassCard(
                          onTap: () => _onSelectRakat(rakatNum),
                          borderGlow: isSelected,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${BengaliNumberFormatter.toBengali(rakatNum)}ম',
                                style: typography.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? colors.primaryEmerald
                                      : colors.textPrimary,
                                ),
                              ),
                              Text(
                                'রাকাত',
                                style: typography.label.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: tokens.spacing.md),

                // 3. Ruku timing toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'রুকু পেয়েছিলেন?',
                      style: typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    GlassSegmentedControl<bool>(
                      segments: const {
                        true: 'রুকুর আগে/রুকুতে',
                        false: 'রুকুর পরে',
                      },
                      selectedValue: _joinedBeforeRuku,
                      onValueChanged: _onToggleRuku,
                    ),
                  ],
                ),

                SizedBox(height: tokens.spacing.lg),

                // Result & Step-by-Step Instructions
                Text(
                  'আপনার করণীয় (ধাপে ধাপে):',
                  style: typography.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: tokens.spacing.sm),

                // Initial Action Box
                Callout(
                  title: 'ইমামের সালামের সময় করণীয়',
                  message: plan.initialAction,
                  variant: CalloutVariant.reference,
                ),

                SizedBox(height: tokens.spacing.md),

                // Make-up Rakat Cards
                if (plan.steps.isEmpty)
                  GlassCard(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Text(
                      'আপনার কোনো রাকাত কাযা নেই। ইমামের সাথে সাধারণ নিয়মে সালাম ফিরিয়ে নামাজ সম্পন্ন করুন।',
                      style: typography.bodyMedium.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  )
                else
                  ...plan.steps.map((step) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GlassCard(
                        borderGlow: true,
                        padding: EdgeInsets.all(tokens.spacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  step.title,
                                  style: typography.titleMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colors.primaryEmerald,
                                  ),
                                ),
                                if (step.mustSitAfterSajda)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.goldAccent.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        tokens.radii.full,
                                      ),
                                    ),
                                    child: Text(
                                      step.sittingType == 'first'
                                          ? 'বৈঠক (তাশাহহুদ)'
                                          : 'শেষ বৈঠক (সালাম)',
                                      style: typography.label.copyWith(
                                        color: colors.goldAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const Divider(height: 16),

                            // Recitations
                            Text(
                              'পড়বেন:',
                              style: typography.label.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...step.recitations.map(
                              (r) => Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.menu_book_rounded,
                                      size: 14,
                                      color: colors.primaryEmerald,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        r,
                                        style: typography.bodyMedium.copyWith(
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Fiqh note
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colors.surfaceGlassTint,
                                borderRadius: BorderRadius.circular(
                                  tokens.radii.sm,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: 15,
                                    color: colors.textSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      step.fiqhNote,
                                      style: typography.label.copyWith(
                                        color: colors.textSecondary,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                SizedBox(height: tokens.spacing.sm),

                // Fiqh Rule Summary & Reference
                Callout(
                  title: 'হানাফি ফিকহের মূলনীতি',
                  message: plan.generalRuleBn,
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReferenceChip(citation: plan.reference),
                ),

                SizedBox(height: tokens.spacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
