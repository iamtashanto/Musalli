// 5-Step Glass Setup Sheet for Namaj Simulator.
//
// Flow: Prayer -> Unit -> Gender -> Role -> Surahs per rakat.
// Remembers last choices via SharedPreferences.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/shared/content/content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimulatorSetupConfig {
  const SimulatorSetupConfig({
    required this.prayer,
    required this.unit,
    this.selectedUnits,
    required this.gender,
    required this.role,
    this.postureMode = PostureMode.standing,
    required this.surahChoice,
  });

  final ContentPrayerType prayer;
  final ContentRakatUnit unit;
  final List<ContentRakatUnit>? selectedUnits;
  final SimGender gender;
  final SimRole role;
  final PostureMode postureMode;
  final Map<int, String> surahChoice;

  bool get isMultiUnit => selectedUnits != null && selectedUnits!.length > 1;
}

class SimulatorSetupSheet extends ConsumerStatefulWidget {
  const SimulatorSetupSheet({
    this.initialPrayerSlug,
    this.initialUnitIndex,
    this.initialGender,
    this.initialRole,
    this.initialPostureMode,
    super.key,
  });

  final String? initialPrayerSlug;
  final int? initialUnitIndex;
  final SimGender? initialGender;
  final SimRole? initialRole;
  final PostureMode? initialPostureMode;

  @override
  ConsumerState<SimulatorSetupSheet> createState() =>
      _SimulatorSetupSheetState();
}

class _SimulatorSetupSheetState extends ConsumerState<SimulatorSetupSheet> {
  int _currentStep = 0; // 0: Prayer, 1: Unit, 2: Posture Mode, 3: Gender, 4: Role, 5: Surahs

  ContentPrayerType? _selectedPrayer;
  ContentRakatUnit? _selectedUnit;
  final Set<int> _selectedUnitIndices = {};
  bool _isFullPrayerSelected = false;
  PostureMode _selectedPostureMode = PostureMode.standing;
  SimGender _selectedGender = SimGender.male;
  SimRole _selectedRole = SimRole.alone;
  final Map<int, String> _surahChoices = {};

  String _prayerSearchQuery = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialPostureMode != null) {
      _selectedPostureMode = widget.initialPostureMode!;
    }
    unawaited(_loadSavedPreferences());
  }

  Future<void> _loadSavedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedGenderStr = prefs.getString('sim_pref_gender');
      final savedRoleStr = prefs.getString('sim_pref_role');
      final savedModeStr = prefs.getString('sim_pref_posture_mode');

      if (mounted) {
        setState(() {
          if (widget.initialPostureMode != null) {
            _selectedPostureMode = widget.initialPostureMode!;
          } else if (savedModeStr != null) {
            if (savedModeStr == 'sittingFloor') {
              _selectedPostureMode = PostureMode.sittingFloor;
            } else if (savedModeStr == 'sittingChair') {
              _selectedPostureMode = PostureMode.sittingChair;
            }
          }

          if (widget.initialGender != null) {
            _selectedGender = widget.initialGender!;
          } else if (savedGenderStr == 'female') {
            _selectedGender = SimGender.female;
          }

          if (widget.initialRole != null) {
            _selectedRole = widget.initialRole!;
          } else if (savedRoleStr != null) {
            if (savedRoleStr == 'imam') {
              _selectedRole = SimRole.imam;
            } else if (savedRoleStr == 'muqtadi') {
              _selectedRole = SimRole.muqtadi;
            }
          }
        });
      }
    } catch (_) {}
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sim_pref_gender', _selectedGender.name);
      await prefs.setString('sim_pref_role', _selectedRole.name);
      await prefs.setString('sim_pref_posture_mode', _selectedPostureMode.name);
      if (_selectedPrayer != null) {
        await prefs.setString('sim_pref_last_prayer', _selectedPrayer!.slug);
      }
    } catch (_) {}
  }

  void _onCompleteSetup() {
    if (_selectedPrayer == null) return;
    unawaited(HapticFeedback.mediumImpact());
    unawaited(_savePreferences());

    final units = _selectedPrayer!.rakatUnits;
    List<ContentRakatUnit> finalUnits = [];

    if (_isFullPrayerSelected || _selectedUnitIndices.length > 1) {
      if (_isFullPrayerSelected) {
        finalUnits = List.from(units);
      } else {
        final sortedIndices = _selectedUnitIndices.toList()..sort();
        finalUnits = sortedIndices.map((i) => units[i]).toList();
      }
    } else if (_selectedUnitIndices.length == 1) {
      finalUnits = [units[_selectedUnitIndices.first]];
    } else if (_selectedUnit != null) {
      finalUnits = [_selectedUnit!];
    } else if (units.isNotEmpty) {
      finalUnits = [units.first];
    }

    final primaryUnit = finalUnits.isNotEmpty ? finalUnits.first : (_selectedUnit ?? units.first);

    Navigator.of(context).pop(
      SimulatorSetupConfig(
        prayer: _selectedPrayer!,
        unit: primaryUnit,
        selectedUnits: finalUnits.length > 1 ? finalUnits : null,
        gender: _selectedGender,
        role: _selectedRole,
        postureMode: _selectedPostureMode,
        surahChoice: _surahChoices,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final prayersAsync = ref.watch(prayersListProvider);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceLowRamFallback,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(tokens.radii.lg),
        ),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Drag Handle
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 6),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.xs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (_currentStep > 0) ...[
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: colors.primaryEmerald,
                        onPressed: () => setState(() => _currentStep--),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      _getStepTitle(),
                      style: typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  'ধাপ ${_currentStep + 1} / 6',
                  style: typography.label.copyWith(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Step Content
          Expanded(
            child: prayersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('ত্রুটি: $err')),
              data: (prayers) {
                // If initial slug provided and prayer not selected yet
                if (_selectedPrayer == null &&
                    widget.initialPrayerSlug != null) {
                  _selectedPrayer = prayers
                      .where((p) => p.slug == widget.initialPrayerSlug)
                      .firstOrNull;
                  if (_selectedPrayer != null &&
                      _selectedPrayer!.rakatUnits.isNotEmpty) {
                    final unitIdx = (widget.initialUnitIndex ?? 0).clamp(
                      0,
                      _selectedPrayer!.rakatUnits.length - 1,
                    );
                    _selectedUnit = _selectedPrayer!.rakatUnits[unitIdx];
                  }
                }

                switch (_currentStep) {
                  case 0:
                    return _buildPrayerStep(prayers);
                  case 1:
                    return _buildUnitStep();
                  case 2:
                    return _buildPostureModeStep();
                  case 3:
                    return _buildGenderStep();
                  case 4:
                    return _buildRoleStep();
                  case 5:
                  default:
                    return _buildSurahsStep();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return '১. নামাজ নির্বাচন করুন';
      case 1:
        return '২. রাকাত বা ইউনিট নির্বাচন';
      case 2:
        return '৩. নামাজের ধরন (দাঁড়িয়ে / মাটিতে বসে / চেয়ারে)';
      case 3:
        return '৪. লিঙ্গ (পুরুষ / নারী)';
      case 4:
        return '৫. ভূমিকা (একাকী / ইমাম / মুক্তাদী)';
      case 5:
      default:
        return '৬. প্রতি রাকাতের সূরা নির্বাচন';
    }
  }

  Widget _buildPostureModeStep() {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final modes = [
      (
        mode: PostureMode.standing,
        icon: Icons.accessibility_new_rounded,
        title: 'স্বাভাবিক দাঁড়িয়ে নামাজ (Standing)',
        desc: 'দাঁড়াতে সক্ষমদের জন্য স্বাভাবিক কিয়াম, রুকু ও ভূমিতে সিজদা।',
      ),
      (
        mode: PostureMode.sittingFloor,
        icon: Icons.airline_seat_recline_normal_rounded,
        title: 'মাটিতে বসে নামাজ (Sitting on Floor)',
        desc: 'অসুস্থ বা দুর্বলদের জন্য মাটিতে বসে কিয়াম, ইশারায় রুকু ও সিজদা।',
      ),
      (
        mode: PostureMode.sittingChair,
        icon: Icons.chair_rounded,
        title: 'চেয়ারে বসে নামাজ (Sitting on Chair)',
        desc: 'মাটিতে বসতে অক্ষমদের জন্য চেয়ারে বসে ইশারায় রুকু ও সিজদা (মাথা বেশি ঝুঁকিয়ে)।',
      ),
    ];

    return ListView.builder(
      padding: EdgeInsets.all(tokens.spacing.md),
      itemCount: modes.length,
      itemBuilder: (context, index) {
        final m = modes[index];
        final isSelected = _selectedPostureMode == m.mode;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            onTap: () {
              unawaited(HapticFeedback.selectionClick());
              setState(() {
                _selectedPostureMode = m.mode;
                _currentStep = 3;
              });
            },
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primaryEmerald.withValues(alpha: 0.18)
                        : colors.textMuted.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    m.icon,
                    color: isSelected ? colors.primaryEmerald : colors.textPrimary,
                    size: 26,
                  ),
                ),
                SizedBox(width: tokens.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.title,
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? colors.primaryEmerald : colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        m.desc,
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: colors.primaryEmerald),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrayerStep(List<ContentPrayerType> prayers) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final filtered = prayers.where((p) {
      if (_prayerSearchQuery.trim().isEmpty) return true;
      final q = _prayerSearchQuery.toLowerCase();
      return p.nameBn.toLowerCase().contains(q) ||
          p.nameEn.toLowerCase().contains(q) ||
          p.slug.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(tokens.spacing.md),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'নামাজের নাম খুঁজুন...',
              prefixIcon: Icon(
                Icons.search_rounded,
                color: colors.primaryEmerald,
              ),
              filled: true,
              fillColor: colors.primaryEmerald.withValues(alpha: 0.06),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(tokens.radii.md),
                borderSide: BorderSide(color: colors.borderSubtle),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            ),
            onChanged: (val) => setState(() => _prayerSearchQuery = val),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final p = filtered[index];
              final isSelected = _selectedPrayer?.slug == p.slug;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GlassCard(
                  onTap: () {
                    setState(() {
                      _selectedPrayer = p;
                      _selectedUnit = p.rakatUnits.isNotEmpty
                          ? p.rakatUnits.first
                          : null;
                      _currentStep = 1;
                    });
                  },
                  padding: EdgeInsets.all(tokens.spacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.nameBn,
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? colors.primaryEmerald
                                  : colors.textPrimary,
                            ),
                          ),
                          Text(
                            '${p.nameAr} • ${p.rakatUnits.length}টি ইউনিট',
                            style: typography.label.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: colors.primaryEmerald,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUnitStep() {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final units = _selectedPrayer?.rakatUnits ?? [];
    final totalPrayerRakats = units.fold<int>(0, (sum, u) => sum + u.config.rakats);

    return Column(
      children: [
        // Full Prayer Shortcut Option Card
        Padding(
          padding: EdgeInsets.fromLTRB(
            tokens.spacing.md,
            tokens.spacing.md,
            tokens.spacing.md,
            tokens.spacing.xs,
          ),
          child: GlassCard(
            onTap: () {
              unawaited(HapticFeedback.selectionClick());
              setState(() {
                _isFullPrayerSelected = true;
                _selectedUnitIndices.clear();
                _selectedUnit = units.isNotEmpty ? units.first : null;
                _currentStep = 2;
              });
            },
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.primaryEmerald.withValues(alpha: 0.16),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: colors.primaryEmerald,
                    size: 24,
                  ),
                ),
                SizedBox(width: tokens.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'সম্পূর্ণ ${_selectedPrayer?.nameBn ?? ''} নামাজ',
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primaryEmerald,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: colors.primaryEmerald.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(tokens.radii.full),
                            ),
                            child: Text(
                              'সবগুলো (${BengaliNumbers.toBengali(totalPrayerRakats)} রাকাত)',
                              style: typography.label.copyWith(
                                color: colors.primaryEmerald,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'সুন্নাত, ফরজ ও ওয়াজিব সকল ইউনিট ধারাবাহিকভাবে পূর্ণাঙ্গ সিমুলেশন করুন।',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: colors.primaryEmerald),
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing.md,
            vertical: tokens.spacing.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'অথবা নির্দিষ্ট ইউনিট নির্বাচন করুন (মাল্টি-সিলেক্ট সম্ভব):',
                style: typography.label.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textSecondary,
                ),
              ),
              if (_selectedUnitIndices.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isFullPrayerSelected = false;
                      _selectedUnit = units[_selectedUnitIndices.first];
                      _currentStep = 2;
                    });
                  },
                  child: Text(
                    'পরবর্তী (${BengaliNumbers.toBengali(_selectedUnitIndices.length)}টি)',
                    style: typography.label.copyWith(
                      color: colors.primaryEmerald,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md),
            itemCount: units.length,
            itemBuilder: (context, index) {
              final u = units[index];
              final isChecked = _selectedUnitIndices.contains(index) ||
                  (!_isFullPrayerSelected && _selectedUnitIndices.isEmpty && _selectedUnit == u);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GlassCard(
                  onTap: () {
                    unawaited(HapticFeedback.selectionClick());
                    setState(() {
                      _isFullPrayerSelected = false;
                      if (_selectedUnitIndices.contains(index)) {
                        _selectedUnitIndices.remove(index);
                      } else {
                        _selectedUnitIndices.add(index);
                      }
                      if (_selectedUnitIndices.isNotEmpty) {
                        _selectedUnit = units[_selectedUnitIndices.first];
                      } else {
                        _selectedUnit = u;
                      }
                    });
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.md,
                    vertical: tokens.spacing.sm,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: colors.primaryEmerald,
                        onChanged: (val) {
                          unawaited(HapticFeedback.selectionClick());
                          setState(() {
                            _isFullPrayerSelected = false;
                            if (val == true) {
                              _selectedUnitIndices.add(index);
                            } else {
                              _selectedUnitIndices.remove(index);
                            }
                            if (_selectedUnitIndices.isNotEmpty) {
                              _selectedUnit = units[_selectedUnitIndices.first];
                            }
                          });
                        },
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              u.label,
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isChecked
                                    ? colors.primaryEmerald
                                    : colors.textPrimary,
                              ),
                            ),
                            Text(
                              u.status.name.toUpperCase(),
                              style: typography.label.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.play_circle_outline_rounded),
                        color: colors.primaryEmerald,
                        tooltip: 'শুধুমাত্র এটি সিমুলেশন করুন',
                        onPressed: () {
                          setState(() {
                            _isFullPrayerSelected = false;
                            _selectedUnitIndices.clear();
                            _selectedUnit = u;
                            _currentStep = 2;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderStep() {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Padding(
      padding: EdgeInsets.all(tokens.spacing.md),
      child: Column(
        children: [
          GlassCard(
            onTap: () {
              setState(() {
                _selectedGender = SimGender.male;
                _currentStep = 4;
              });
            },
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.primaryEmerald.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.male_rounded,
                    color: colors.primaryEmerald,
                    size: 28,
                  ),
                ),
                SizedBox(width: tokens.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'পুরুষ (Male)',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'কান পর্যন্ত হাত উত্তোলন, নাভির নিচে হাত বাঁধা, সমান্তরাল রুকু ও ছড়ানো সিজদা।',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: colors.primaryEmerald),
              ],
            ),
          ),
          SizedBox(height: tokens.spacing.md),
          GlassCard(
            onTap: () {
              setState(() {
                _selectedGender = SimGender.female;
                _currentStep = 4;
              });
            },
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.goldAccent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.female_rounded,
                    color: colors.goldAccent,
                    size: 28,
                  ),
                ),
                SizedBox(width: tokens.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'নারী (Female)',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'কাঁধ পর্যন্ত হাত তোলা, বুকের ওপর হাত বাঁধা, মৃদু রুকু, তাওয়াররুক বৈঠক ও জড়সড় সিজদা।',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: colors.goldAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleStep() {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final roles = [
      (
        role: SimRole.alone,
        title: 'একা (Munfarid)',
        desc: 'নিজে একাকী নামাজ আদায় করা।',
      ),
      (
        role: SimRole.imam,
        title: 'ইমাম (Imam)',
        desc: 'জামাতে উচ্চস্বরে বা নীরবে ইমামতি করা।',
      ),
      (
        role: SimRole.muqtadi,
        title: 'মুক্তাদী (Muqtadi)',
        desc: 'ইমামের পেছনে নীরবে কেরাত শ্রবণ করা।',
      ),
    ];

    return ListView.builder(
      padding: EdgeInsets.all(tokens.spacing.md),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        final r = roles[index];
        final isSelected = _selectedRole == r.role;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassCard(
            onTap: () {
              setState(() {
                _selectedRole = r.role;
                _currentStep = 5;
              });
            },
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.title,
                      style: typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? colors.primaryEmerald
                            : colors.textPrimary,
                      ),
                    ),
                    Text(
                      r.desc,
                      style: typography.label.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_rounded, color: colors.primaryEmerald),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSurahsStep() {
    final tokens = context.tokens;
    final typography = tokens.typography;

    final totalRakats = _selectedUnit?.config.rakats ?? 2;
    final qiratRakats = _selectedUnit?.config.qiratRakats.isNotEmpty == true
        ? _selectedUnit!.config.qiratRakats
        : List.generate(totalRakats, (i) => i + 1);

    return Padding(
      padding: EdgeInsets.all(tokens.spacing.md),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: qiratRakats.map((r) {
                final selected =
                    _surahChoices[r] ??
                    (r == 1
                        ? 'surah-108'
                        : r == 2
                        ? 'surah-112'
                        : r == 3
                        ? 'surah-113'
                        : 'surah-114');

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${BengaliNumbers.toBengali(r)}ম রাকাতের সূরা:',
                          style: typography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: [
                            GlassChip(
                              label: 'কাওসার (১০৮)',
                              selected: selected == 'surah-108',
                              onTap: () => setState(
                                () => _surahChoices[r] = 'surah-108',
                              ),
                            ),
                            GlassChip(
                              label: 'ইখলাস (১১২)',
                              selected: selected == 'surah-112',
                              onTap: () => setState(
                                () => _surahChoices[r] = 'surah-112',
                              ),
                            ),
                            GlassChip(
                              label: 'ফালাক (১১৩)',
                              selected: selected == 'surah-113',
                              onTap: () => setState(
                                () => _surahChoices[r] = 'surah-113',
                              ),
                            ),
                            GlassChip(
                              label: 'নাস (১১৪)',
                              selected: selected == 'surah-114',
                              onTap: () => setState(
                                () => _surahChoices[r] = 'surah-114',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: tokens.spacing.sm),
          GlassButton(
            label: 'সিমুলেশন শুরু করুন',
            icon: Icons.play_arrow_rounded,
            onPressed: _onCompleteSetup,
          ),
        ],
      ),
    );
  }
}
