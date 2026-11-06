import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _count = 0;
  int _target = 33;
  int _selectedPresetIndex = 0;

  static const List<({String titleAr, String titleBn, int count})> _presets = [
    (titleAr: 'سُبْحَانَ اللَّهِ', titleBn: 'সুবহানাল্লাহ', count: 33),
    (titleAr: 'الْحَمْدُ لِلَّهِ', titleBn: 'আলহামদুলিল্লাহ', count: 33),
    (titleAr: 'اللَّهُ أَكْبَرُ', titleBn: 'আল্লাহু আকবার', count: 34),
    (titleAr: 'أَسْتَغْفِرُ اللَّهَ', titleBn: 'আস্তাগফিরুল্লাহ', count: 100),
    (titleAr: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ', titleBn: 'দুরুদ শরীফ', count: 100),
  ];

  void _increment() {
    unawaited(HapticFeedback.lightImpact());
    setState(() {
      _count++;
      if (_count == _target) {
        unawaited(HapticFeedback.heavyImpact());
      }
    });
  }

  void _reset() {
    setState(() => _count = 0);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final preset = _presets[_selectedPresetIndex];

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text('ডিজিটাল তাসবীহ', style: typography.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'রিসেট',
            onPressed: _reset,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Presets row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md, vertical: tokens.spacing.sm),
              child: Row(
                children: _presets.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final p = entry.value;
                  final isSelected = idx == _selectedPresetIndex;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(p.titleBn, style: typography.label.copyWith(
                        color: isSelected ? Colors.white : colors.textPrimary,
                      )),
                      selected: isSelected,
                      selectedColor: const Color(0xFF10B981),
                      backgroundColor: colors.surfaceGlassTint,
                      onSelected: (val) {
                        if (val) {
                          setState(() {
                            _selectedPresetIndex = idx;
                            _target = p.count;
                            _count = 0;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: tokens.spacing.md),

            // Arabic Dhikr title
            Text(
              preset.titleAr,
              style: typography.arabicLarge.copyWith(color: const Color(0xFF10B981)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: tokens.spacing.xxs),
            Text(
              'টার্গেট: ${BengaliNumbers.toBengali(_target)} বার',
              style: typography.label,
            ),

            // Big Tap Area Button
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: _increment,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.surfaceGlassTint,
                      border: Border.all(
                        color: _count >= _target ? const Color(0xFF10B981) : colors.borderSubtle,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          blurRadius: 30,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          BengaliNumbers.toBengali(_count),
                          style: typography.display.copyWith(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: _count >= _target ? const Color(0xFF10B981) : colors.textPrimary,
                          ),
                        ),
                        Text('ট্যাপ করুন', style: typography.label),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(tokens.spacing.md),
              child: Text(
                'স্ক্রিনের যেকোনো বৃত্তে ট্যাপ করে জিকির গণনা করুন।',
                style: typography.label,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
