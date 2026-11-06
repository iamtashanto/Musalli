import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/helpers/domain/qasr_engine.dart';

/// Interactive Qasr Calculator Screen ("কসর ক্যালকুলেটর").
class QasrCalculatorScreen extends StatefulWidget {
  const QasrCalculatorScreen({super.key});

  @override
  State<QasrCalculatorScreen> createState() => _QasrCalculatorScreenState();
}

class _QasrCalculatorScreenState extends State<QasrCalculatorScreen> {
  double _distanceKm = 120;
  int _stayDays = 5;
  bool _isUncertainStay = false;

  final TextEditingController _distanceController = TextEditingController(
    text: '120',
  );

  @override
  void dispose() {
    _distanceController.dispose();
    super.dispose();
  }

  void _onPresetDistance(double km) {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _distanceKm = km;
      _distanceController.text = km.round().toString();
    });
  }

  void _onDistanceChanged(String val) {
    final parsed = double.tryParse(val);
    if (parsed != null && parsed >= 0) {
      setState(() => _distanceKm = parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final result = QasrEngine.calculate(
      distanceKm: _distanceKm,
      stayDays: _stayDays,
      isUncertainStay: _isUncertainStay,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          const GlassSliverAppBar(title: 'কসর ক্যালকুলেটর'),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.sm,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Guidance box
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
                          Icons.flight_takeoff_rounded,
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
                              'মুসাফিরের কসর নামাজ',
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'সফরের দূরত্ব ও থাকার মেয়াদের ভিত্তিতে হানাফি ফিকহের কসর হুকুম নির্ধারণ করুন।',
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

                // 1. Distance input
                Text(
                  '১. নিজ এলাকা থেকে গন্তব্যের দূরত্ব (কিলোমিটার)',
                  style: typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),

                GlassCard(
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.md,
                    vertical: tokens.spacing.xs,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_road_rounded,
                        color: colors.primaryEmerald,
                      ),
                      SizedBox(width: tokens.spacing.sm),
                      Expanded(
                        child: TextField(
                          controller: _distanceController,
                          keyboardType: TextInputType.number,
                          onChanged: _onDistanceChanged,
                          style: typography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'দূরত্ব লিখুন...',
                          ),
                        ),
                      ),
                      Text(
                        'কিমি',
                        style: typography.bodyMedium.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // Quick preset distance chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        [
                          (50.0, '৫০ কিমি'),
                          (77.25, '৭৭.২৫ কিমি (সীমা)'),
                          (120.0, '১২০ কিমি'),
                          (250.0, '২৫০ কিমি (ঢাকা-চট্টগ্রাম)'),
                        ].map((preset) {
                          final isSelected =
                              (_distanceKm - preset.$1).abs() < 0.1;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ActionChip(
                              label: Text(preset.$2),
                              backgroundColor: isSelected
                                  ? colors.primaryEmerald.withValues(alpha: 0.2)
                                  : colors.surfaceGlassTint,
                              labelStyle: typography.label.copyWith(
                                color: isSelected
                                    ? colors.primaryEmerald
                                    : colors.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              side: BorderSide(
                                color: isSelected
                                    ? colors.primaryEmerald
                                    : colors.borderSubtle,
                              ),
                              onPressed: () => _onPresetDistance(preset.$1),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // 2. Stay Days
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '২. গন্তব্যে কত দিন থাকার নিয়্যত?',
                      style: typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      _isUncertainStay
                          ? 'অনির্দিষ্ট'
                          : '${BengaliNumberFormatter.toBengali(_stayDays)} দিন',
                      style: typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primaryEmerald,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacing.xs),

                if (!_isUncertainStay)
                  Slider(
                    value: _stayDays.toDouble().clamp(1.0, 30.0),
                    min: 1,
                    max: 30,
                    divisions: 29,
                    activeColor: colors.primaryEmerald,
                    inactiveColor: colors.borderSubtle,
                    onChanged: (val) {
                      setState(() => _stayDays = val.round());
                    },
                  ),

                // Uncertain stay toggle
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'অনির্দিষ্ট মেয়াদ (কাজ শেষ হলেই চলে আসব, নিশ্চিত দিন নেই)',
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  value: _isUncertainStay,
                  activeColor: colors.primaryEmerald,
                  onChanged: (val) {
                    setState(() => _isUncertainStay = val ?? false);
                  },
                ),

                SizedBox(height: tokens.spacing.lg),

                // Assessment Result Card
                GlassCard(
                  borderGlow: true,
                  padding: EdgeInsets.all(tokens.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Verdict Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (result.isMusafir
                                      ? colors.primaryEmerald
                                      : colors.goldAccent)
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(
                            tokens.radii.full,
                          ),
                          border: Border.all(
                            color:
                                (result.isMusafir
                                        ? colors.primaryEmerald
                                        : colors.goldAccent)
                                    .withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          result.isMusafir
                              ? 'মুসাফির (কসর প্রযোজ্য)'
                              : 'মুকীম (পূর্ণ নামাজ)',
                          style: typography.label.copyWith(
                            color: result.isMusafir
                                ? colors.primaryEmerald
                                : colors.goldAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: tokens.spacing.md),

                      Text(
                        result.verdictTitle,
                        style: typography.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),

                      SizedBox(height: tokens.spacing.sm),

                      Text(
                        result.verdictSummary,
                        style: typography.bodyMedium.copyWith(
                          color: colors.textSecondary,
                          height: 1.5,
                        ),
                      ),

                      const Divider(height: 24),

                      // Prayer Adjustments Grid
                      Text(
                        'ওয়াক্ত অনুযায়ী রাকাত পরিবর্তন:',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      ...result.prayerAdjustments.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                entry.key,
                                style: typography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              Text(
                                entry.value,
                                style: typography.bodyMedium.copyWith(
                                  color: entry.value.contains('কসর')
                                      ? colors.primaryEmerald
                                      : colors.textSecondary,
                                  fontWeight: entry.value.contains('কসর')
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const Divider(height: 24),

                      // Important Rules
                      Text(
                        'জরুরি বিষয়সমূহ:',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...result.rules.map(
                        (rule) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  right: 6,
                                ),
                                child: Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 15,
                                  color: colors.primaryEmerald,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  rule,
                                  style: typography.bodyMedium.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: tokens.spacing.md),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReferenceChip(citation: result.reference),
                      ),
                    ],
                  ),
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
