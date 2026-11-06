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
    required this.gender,
    required this.role,
    required this.surahChoice,
  });

  final ContentPrayerType prayer;
  final ContentRakatUnit unit;
  final SimGender gender;
  final SimRole role;
  final Map<int, String> surahChoice;
}

class SimulatorSetupSheet extends ConsumerStatefulWidget {
  const SimulatorSetupSheet({
    this.initialPrayerSlug,
    this.initialUnitIndex,
    this.initialGender,
    this.initialRole,
    super.key,
  });

  final String? initialPrayerSlug;
  final int? initialUnitIndex;
  final SimGender? initialGender;
  final SimRole? initialRole;

  @override
  ConsumerState<SimulatorSetupSheet> createState() =>
      _SimulatorSetupSheetState();
}

class _SimulatorSetupSheetState extends ConsumerState<SimulatorSetupSheet> {
  int _currentStep = 0; // 0: Prayer, 1: Unit, 2: Gender, 3: Role, 4: Surahs

  ContentPrayerType? _selectedPrayer;
  ContentRakatUnit? _selectedUnit;
  SimGender _selectedGender = SimGender.male;
  SimRole _selectedRole = SimRole.alone;
  final Map<int, String> _surahChoices = {};

  String _prayerSearchQuery = '';

  @override
  void initState() {
    super.initState();
    unawaited(_loadSavedPreferences());
  }

  Future<void> _loadSavedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedGenderStr = prefs.getString('sim_pref_gender');
      final savedRoleStr = prefs.getString('sim_pref_role');

      if (mounted) {
        setState(() {
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
      if (_selectedPrayer != null) {
        await prefs.setString('sim_pref_last_prayer', _selectedPrayer!.slug);
      }
    } catch (_) {}
  }

  void _onCompleteSetup() {
    if (_selectedPrayer == null || _selectedUnit == null) return;
    unawaited(HapticFeedback.mediumImpact());
    unawaited(_savePreferences());

    Navigator.of(context).pop(
      SimulatorSetupConfig(
        prayer: _selectedPrayer!,
        unit: _selectedUnit!,
        gender: _selectedGender,
        role: _selectedRole,
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
                  'ধাপ ${_currentStep + 1} / 5',
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
                    return _buildGenderStep();
                  case 3:
                    return _buildRoleStep();
                  case 4:
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
        return '৩. লিঙ্গ (পুরুষ / নারী)';
      case 3:
        return '৪. ভূমিকা (একাকী / ইমাম / মুক্তাদী)';
      case 4:
      default:
        return '৫. প্রতি রাকাতের সূরা নির্বাচন';
    }
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

    return ListView.builder(
      padding: EdgeInsets.all(tokens.spacing.md),
      itemCount: units.length,
      itemBuilder: (context, index) {
        final u = units[index];
        final isSelected = _selectedUnit == u;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassCard(
            onTap: () {
              setState(() {
                _selectedUnit = u;
                _currentStep = 2;
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
                      u.label,
                      style: typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected
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
                Icon(Icons.arrow_forward_rounded, color: colors.primaryEmerald),
              ],
            ),
          ),
        );
      },
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
                _currentStep = 3;
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
                _currentStep = 3;
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
                _currentStep = 4;
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
