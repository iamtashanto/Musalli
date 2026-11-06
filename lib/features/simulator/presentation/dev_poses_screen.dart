// Dev Screen: Inspect and audit all 16 postures × gender × view angles.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/simulator/presentation/figure/simulator_figure.dart';

class DevPosesScreen extends StatefulWidget {
  const DevPosesScreen({super.key});

  @override
  State<DevPosesScreen> createState() => _DevPosesScreenState();
}

class _DevPosesScreenState extends State<DevPosesScreen> {
  Posture _currentPosture = Posture.standing;
  SimGender _gender = SimGender.male;
  FigureViewMode _viewMode = FigureViewMode.side;
  bool _isPlayingAll = false;
  Timer? _sequenceTimer;

  static const List<({Posture posture, String nameBn, String nameEn})>
  _postureList = [
    (posture: Posture.standing, nameBn: 'দাঁড়ানো (কিয়াম)', nameEn: 'Standing'),
    (
      posture: Posture.takbirHandsRaised,
      nameBn: 'তাকবীর (হাত তোলা)',
      nameEn: 'Takbir Raised',
    ),
    (
      posture: Posture.qiyamHandsFolded,
      nameBn: 'হাত বাঁধা (কিয়াম)',
      nameEn: 'Hands Folded',
    ),
    (posture: Posture.ruku, nameBn: 'রুকু', nameEn: 'Ruku'),
    (posture: Posture.qawma, nameBn: 'কওমা', nameEn: 'Qawma'),
    (posture: Posture.sajda, nameBn: 'সিজদা', nameEn: 'Sajda'),
    (posture: Posture.jalsa, nameBn: 'জলসা (বৈঠক)', nameEn: 'Jalsa'),
    (posture: Posture.qada, nameBn: "কা'দা (তাশাহহুদ)", nameEn: 'Qada'),
    (
      posture: Posture.tashahhudFingerRaised,
      nameBn: 'শাহাদাত আঙুল তোলা',
      nameEn: 'Finger Raised',
    ),
    (
      posture: Posture.salamRight,
      nameBn: 'ডান দিকে সালাম',
      nameEn: 'Salam Right',
    ),
    (
      posture: Posture.salamLeft,
      nameBn: 'বাম দিকে সালাম',
      nameEn: 'Salam Left',
    ),
    (
      posture: Posture.qunutTakbir,
      nameBn: 'কুনূত তাকবীর',
      nameEn: 'Qunut Takbir',
    ),
    (
      posture: Posture.eidTakbirRaised,
      nameBn: 'ঈদ তাকবীর (তোলা)',
      nameEn: 'Eid Raised',
    ),
    (
      posture: Posture.eidTakbirReleased,
      nameBn: 'ঈদ তাকবীর (ছেড়ে)',
      nameEn: 'Eid Released',
    ),
    (
      posture: Posture.janazaTakbir,
      nameBn: 'জানাজা তাকবীর',
      nameEn: 'Janaza Takbir',
    ),
    (posture: Posture.munajat, nameBn: 'মুনাজাত', nameEn: 'Munajat'),
  ];

  @override
  void dispose() {
    _sequenceTimer?.cancel();
    super.dispose();
  }

  void _togglePlayAll() {
    if (_isPlayingAll) {
      _sequenceTimer?.cancel();
      setState(() => _isPlayingAll = false);
    } else {
      setState(() => _isPlayingAll = true);
      _runSequence(0);
    }
  }

  void _runSequence(int index) {
    if (!_isPlayingAll) return;
    if (index >= _postureList.length) {
      setState(() => _isPlayingAll = false);
      return;
    }

    setState(() {
      _currentPosture = _postureList[index].posture;
    });

    _sequenceTimer = Timer(const Duration(milliseconds: 1400), () {
      if (mounted && _isPlayingAll) {
        _runSequence(index + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          const GlassSliverAppBar(title: '2D Figure Poses Inspector (Dev)'),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(tokens.spacing.md),
              child: Column(
                children: <Widget>[
                  // Controls Bar
                  GlassCard(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Column(
                      children: <Widget>[
                        // Gender & View Mode Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Gender Toggle
                            Row(
                              children: [
                                GlassChip(
                                  label: 'পুরুষ (Male)',
                                  selected: _gender == SimGender.male,
                                  onTap: () =>
                                      setState(() => _gender = SimGender.male),
                                ),
                                const SizedBox(width: 8),
                                GlassChip(
                                  label: 'নারী (Female)',
                                  selected: _gender == SimGender.female,
                                  onTap: () => setState(
                                    () => _gender = SimGender.female,
                                  ),
                                ),
                              ],
                            ),

                            // Camera View Mode
                            Row(
                              children: [
                                GlassChip(
                                  label: 'Side',
                                  selected: _viewMode == FigureViewMode.side,
                                  onTap: () => setState(
                                    () => _viewMode = FigureViewMode.side,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GlassChip(
                                  label: 'Front',
                                  selected: _viewMode == FigureViewMode.front,
                                  onTap: () => setState(
                                    () => _viewMode = FigureViewMode.front,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: tokens.spacing.md),

                        // Play All Transitions Button
                        GlassButton(
                          label: _isPlayingAll
                              ? 'থামুন (Stop Sequence)'
                              : 'সব ট্রানজিশন চালান (Play All Transitions)',
                          icon: _isPlayingAll
                              ? Icons.stop_rounded
                              : Icons.play_arrow_rounded,
                          variant: _isPlayingAll
                              ? GlassButtonVariant.secondary
                              : GlassButtonVariant.primary,
                          isExpanded: true,
                          onPressed: _togglePlayAll,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: tokens.spacing.md),

                  // Center Stage Figure
                  GlassCard(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: SimulatorFigure(
                        posture: _currentPosture,
                        gender: _gender,
                        viewMode: _viewMode,
                      ),
                    ),
                  ),

                  SizedBox(height: tokens.spacing.md),

                  // Postures Selector Grid
                  Text(
                    'সকল ১৬টি অঙ্গভঙ্গি (Posture Grid)',
                    style: typography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.xs),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _postureList.map((item) {
                      final isSelected = _currentPosture == item.posture;
                      return GlassChip(
                        label: '${item.nameBn} (${item.nameEn})',
                        selected: isSelected,
                        onTap: () {
                          _sequenceTimer?.cancel();
                          setState(() {
                            _isPlayingAll = false;
                            _currentPosture = item.posture;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: tokens.spacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
