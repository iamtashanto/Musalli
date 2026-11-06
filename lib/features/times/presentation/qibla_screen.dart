import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/times/domain/services/qibla_calculator.dart';
import 'package:musalli/features/times/presentation/providers/times_providers.dart';
import 'package:sensors_plus/sensors_plus.dart';

class QiblaScreen extends ConsumerStatefulWidget {
  const QiblaScreen({super.key});

  @override
  ConsumerState<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends ConsumerState<QiblaScreen> {
  StreamSubscription<MagnetometerEvent>? _magSub;
  double _heading = 0.0;
  bool _hasHapticTriggered = false;

  @override
  void initState() {
    super.initState();
    _startCompass();
  }

  void _startCompass() {
    _magSub = magnetometerEventStream().listen((event) {
      final rad = math.atan2(event.y, event.x);
      var deg = rad * (180.0 / math.pi);
      deg = (deg + 360.0) % 360.0;

      // Low pass filter
      final smoothed = _heading + 0.15 * (deg - _heading);
      if (mounted) {
        setState(() => _heading = smoothed);
      }
    });
  }

  @override
  void dispose() {
    _magSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final settings = ref.watch(prayerTimesSettingsProvider).value;
    final lat = settings?.location.latitude ?? 23.8103;
    final lng = settings?.location.longitude ?? 90.4125;
    final qiblaBearing = QiblaCalculator.calculateBearing(lat, lng);

    final diff = ((qiblaBearing - _heading + 540) % 360) - 180;
    final isAligned = diff.abs() <= 3.0;

    if (isAligned && !_hasHapticTriggered) {
      unawaited(HapticFeedback.heavyImpact());
      _hasHapticTriggered = true;
    } else if (!isAligned) {
      _hasHapticTriggered = false;
    }

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text('কিবলা কম্পাস', style: typography.titleLarge),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: tokens.spacing.md),
            Text(
              '${settings?.location.nameBn ?? "ঢাকা"} থেকে কিবলার কোণ: ${BengaliNumbers.toBengali(qiblaBearing.round())}°',
              style: typography.titleMedium,
            ),
            SizedBox(height: tokens.spacing.xs),
            Text(
              isAligned ? '✨ সঠিক কিবলামুখী হয়েছেন!' : 'ডিভাইসটি ঘুরিয়ে সবুজ কা'বা চিহ্নের সাথে মিলান',
              style: typography.bodyMedium.copyWith(
                color: isAligned ? const Color(0xFF10B981) : colors.textSecondary,
                fontWeight: isAligned ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Compass Ring
                    Transform.rotate(
                      angle: -_heading * (math.pi / 180.0),
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.surfaceGlassTint,
                          border: Border.all(
                            color: isAligned ? const Color(0xFF10B981) : colors.borderSubtle,
                            width: isAligned ? 3 : 1.5,
                          ),
                          boxShadow: isAligned
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                                    blurRadius: 24,
                                    spreadRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // North marker
                            Positioned(
                              top: 12,
                              child: Text('উ', style: typography.titleMedium.copyWith(color: const Color(0xFFEF4444))),
                            ),
                            Positioned(
                              right: 12,
                              child: Text('পূ', style: typography.bodyMedium),
                            ),
                            Positioned(
                              bottom: 12,
                              child: Text('দ', style: typography.bodyMedium),
                            ),
                            Positioned(
                              left: 12,
                              child: Text('প', style: typography.bodyMedium),
                            ),
                            // Kaaba Marker
                            Transform.rotate(
                              angle: qiblaBearing * (math.pi / 180.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 36),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF10B981),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Text('🕋', style: TextStyle(fontSize: 22)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Pointer Needle
                    const Icon(
                      Icons.navigation,
                      size: 48,
                      color: Color(0xFF10B981),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(tokens.spacing.md),
              child: GlassCard(
                padding: EdgeInsets.all(tokens.spacing.sm),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Color(0xFF10B981)),
                    SizedBox(width: tokens.spacing.sm),
                    Expanded(
                      child: Text(
                        'কম্পাসের সঠিকতার জন্য ডিভাইসটিকে অনুভূমিক সমতলে রাখুন ও ধাতব বস্তু থেকে দূরে রাখুন।',
                        style: typography.label,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
