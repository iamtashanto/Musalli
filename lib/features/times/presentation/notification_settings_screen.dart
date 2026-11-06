import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/services/notification_service.dart';
import 'package:musalli/features/times/presentation/providers/notification_providers.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final config = ref.watch(notificationConfigProvider);
    final notifier = ref.read(notificationConfigProvider.notifier);

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text('নামাজের নোটিফিকেশন', style: typography.titleLarge),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.md),
        children: [
          // Test Notification Card
          GlassCard(
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(tokens.spacing.sm),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_active, color: Color(0xFF10B981)),
                ),
                SizedBox(width: tokens.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('নোটিফিকেশন পরীক্ষা', style: typography.titleMedium),
                      SizedBox(height: tokens.spacing.xxs),
                      Text('আযান বা সংকেতের শব্দ যাচাই করুন', style: typography.bodyMedium),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    unawaited(NotificationService.instance.sendTestNotification(config.soundType));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('টেস্ট নোটিফিকেশন পাঠানো হয়েছে!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('বাজিয়ে দেখুন'),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Sound Selection
          Text('আযান ও সংকেতের ধরন', style: typography.titleMedium),
          SizedBox(height: tokens.spacing.xs),
          GlassCard(
            padding: EdgeInsets.all(tokens.spacing.sm),
            child: Column(
              children: AdhanSoundType.values.map((type) {
                return RadioListTile<AdhanSoundType>(
                  value: type,
                  groupValue: config.soundType,
                  title: Text(type.labelBn, style: typography.bodyLarge),
                  activeColor: const Color(0xFF10B981),
                  onChanged: (val) {
                    if (val != null) {
                      unawaited(notifier.updateConfig(
                        config.copyWith(soundType: val),
                      ));
                    }
                  },
                );
              }).toList(),
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Waqts Toggles
          Text('ওয়াক্তভিত্তিক নোটিফিকেশন', style: typography.titleMedium),
          SizedBox(height: tokens.spacing.xs),
          GlassCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSwitch(
                  context: context,
                  title: 'ফজর',
                  value: config.fajrEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(fajrEnabled: v)),
                ),
                _buildSwitch(
                  context: context,
                  title: 'যোহর',
                  value: config.dhuhrEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(dhuhrEnabled: v)),
                ),
                _buildSwitch(
                  context: context,
                  title: 'আসর',
                  value: config.asrEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(asrEnabled: v)),
                ),
                _buildSwitch(
                  context: context,
                  title: 'মাগরিব',
                  value: config.maghribEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(maghribEnabled: v)),
                ),
                _buildSwitch(
                  context: context,
                  title: 'এশা',
                  value: config.ishaEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(ishaEnabled: v)),
                ),
                _buildSwitch(
                  context: context,
                  title: 'তাহাজ্জুদ এলার্ট (রাতের শেষ তৃতীয়াংশ)',
                  value: config.tahajjudEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(tahajjudEnabled: v)),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Additional Helpful Reminders
          Text('বিশেষ অনুস্মারক ও ফলো-আপ', style: typography.titleMedium),
          SizedBox(height: tokens.spacing.xs),
          GlassCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSwitch(
                  context: context,
                  title: 'নামাজ পড়েছেন কি? (৩০ মিনিট পর ফলো-আপ)',
                  subtitle: 'নোটিফিকেশন থেকেই সরাসরি ট্র্যাকার আপডেট করুন',
                  value: config.followUpEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(followUpEnabled: v)),
                ),
                _buildSwitch(
                  context: context,
                  title: 'জুমুআর বিশেষ নোটিফিকেশন',
                  subtitle: 'শুক্রবার সকালে সূরা কাহাফ ও মসজিদে দ্রুত যাওয়ার অনুস্মারক',
                  value: config.jumuahReminderEnabled,
                  onChanged: (v) => notifier.updateConfig(config.copyWith(jumuahReminderEnabled: v)),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Battery Optimization Guidance
          GlassCard(
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.battery_alert, color: Color(0xFFF59E0B)),
                    SizedBox(width: tokens.spacing.sm),
                    Expanded(
                      child: Text('ব্যাটারি অপ্টিমাইজেশন ও ব্যাকগ্রাউন্ড পারমিশন', style: typography.titleMedium),
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'Xiaomi, Vivo, Oppo ও Samsung ডিভাইসে সময়মতো আযান পেতে হলে অ্যাপটির জন্য "অটো-স্টার্ট" (Auto-start) চালু করুন এবং ব্যাটারি সেভার "No restrictions"-এ সেট করুন।',
                  style: typography.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitch({
    required BuildContext context,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final tokens = context.tokens;
    return SwitchListTile.adaptive(
      title: Text(title, style: tokens.typography.bodyLarge),
      subtitle: subtitle != null ? Text(subtitle, style: tokens.typography.label) : null,
      value: value,
      activeColor: const Color(0xFF10B981),
      onChanged: (val) => unawaited(Future<void>.sync(() => onChanged(val))),
    );
  }
}
