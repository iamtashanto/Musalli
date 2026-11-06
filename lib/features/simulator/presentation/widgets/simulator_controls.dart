// Playback Controls Bar with morphing play/pause, prev/next, speed selector,
// auto/manual toggle, view switch, and step list sheet button.

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/simulator/presentation/figure/simulator_figure.dart';

class SimulatorControls extends StatelessWidget {
  const SimulatorControls({
    required this.isPlaying,
    required this.isAutoMode,
    required this.speed,
    required this.isMuted,
    required this.viewMode,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
    required this.onReplayStep,
    required this.onSpeedChanged,
    required this.onAutoModeToggle,
    required this.onMuteToggle,
    required this.onViewModeToggle,
    required this.onOpenStepList,
    super.key,
  });

  final bool isPlaying;
  final bool isAutoMode;
  final double speed;
  final bool isMuted;
  final FigureViewMode viewMode;

  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onReplayStep;
  final ValueChanged<double> onSpeedChanged;
  final VoidCallback onAutoModeToggle;
  final VoidCallback onMuteToggle;
  final VoidCallback onViewModeToggle;
  final VoidCallback onOpenStepList;

  void _cycleSpeed() {
    final speeds = [0.75, 1.0, 1.25, 1.5];
    final currentIndex = speeds.indexOf(speed);
    final nextIndex = (currentIndex + 1) % speeds.length;
    onSpeedChanged(speeds[nextIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing.md,
        vertical: tokens.spacing.sm,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary Transport Controls Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Replay Step
              IconButton(
                icon: const Icon(Icons.replay_rounded),
                color: colors.textSecondary,
                iconSize: 24,
                tooltip: 'ধাপটি পুনরায় চালান',
                onPressed: onReplayStep,
              ),

              // Previous Step
              IconButton(
                icon: const Icon(Icons.skip_previous_rounded),
                color: colors.textPrimary,
                iconSize: 32,
                tooltip: 'পূর্ববর্তী ধাপ',
                onPressed: onPrevious,
              ),

              // Primary Play / Pause Button (Morphing)
              GestureDetector(
                onTap: onPlayPause,
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.primaryEmerald, colors.tealDeep],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colors.primaryEmerald.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        key: ValueKey<bool>(isPlaying),
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ),

              // Next Step
              IconButton(
                icon: const Icon(Icons.skip_next_rounded),
                color: colors.textPrimary,
                iconSize: 32,
                tooltip: 'পরবর্তী ধাপ',
                onPressed: onNext,
              ),

              // Step List Drawer
              IconButton(
                icon: const Icon(Icons.format_list_bulleted_rounded),
                color: colors.textSecondary,
                iconSize: 24,
                tooltip: 'সকল ধাপের তালিকা',
                onPressed: onOpenStepList,
              ),
            ],
          ),

          const SizedBox(height: 6),
          const Divider(height: 12),

          // Secondary Preferences Bar (Speed, Auto/Manual, View Switch, Mute)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Speed Chip
              GestureDetector(
                onTap: _cycleSpeed,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primaryEmerald.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(tokens.radii.full),
                    border: Border.all(
                      color: colors.primaryEmerald.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.speed_rounded,
                        size: 14,
                        color: colors.primaryEmerald,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${BengaliNumbers.toBengali(speed.toString())}x',
                        style: typography.label.copyWith(
                          color: colors.primaryEmerald,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Auto vs Manual Toggle
              GestureDetector(
                onTap: onAutoModeToggle,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isAutoMode
                        ? colors.primaryEmerald.withValues(alpha: 0.15)
                        : colors.textMuted.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(tokens.radii.full),
                    border: Border.all(
                      color: isAutoMode
                          ? colors.primaryEmerald
                          : colors.borderSubtle,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isAutoMode
                            ? Icons.autorenew_rounded
                            : Icons.touch_app_rounded,
                        size: 14,
                        color: isAutoMode
                            ? colors.primaryEmerald
                            : colors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isAutoMode ? 'স্বয়ংক্রিয় (Auto)' : 'ম্যানুয়াল (Manual)',
                        style: typography.label.copyWith(
                          color: isAutoMode
                              ? colors.primaryEmerald
                              : colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // View Mode Toggle (Side / Front)
              GestureDetector(
                onTap: onViewModeToggle,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primaryEmerald.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(tokens.radii.full),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 14,
                        color: colors.primaryEmerald,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        viewMode == FigureViewMode.side ? 'পার্শ্ব' : 'সম্মুখ',
                        style: typography.label.copyWith(
                          color: colors.primaryEmerald,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Mute / Unmute Icon
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  size: 20,
                  color: isMuted ? colors.textMuted : colors.primaryEmerald,
                ),
                tooltip: isMuted ? 'শব্দ চালু করুন' : 'শব্দ বন্ধ করুন',
                onPressed: onMuteToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
