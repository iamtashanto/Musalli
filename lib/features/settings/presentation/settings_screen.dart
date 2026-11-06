import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/features/tracker/data/tracker_repository.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  double _arabicFontSize = 26.0;
  bool _showBanglaPronunciation = true;
  bool _showBanglish = true;
  bool _showBanglaMeaning = true;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final locale = ref.watch(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final glassQuality = ref.watch(glassQualityProvider);

    return Scaffold(
      backgroundColor: tokens.colors.backgroundStart,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'সেটিংস ও পছন্দসমূহ',
          style: tokens.typography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.md),
        children: [
          // Section 1: Appearance & Display
          Text(
            'অ্যাপের রূপ ও ডিজাইন',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          GlassCard(
            enableBlur: true,
            child: Column(
              children: [
                // Language
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: const Text('ভাষা (Language)'),
                  subtitle: Text(locale.languageCode == 'bn' ? 'বাংলা' : 'English'),
                  trailing: TextButton(
                    onPressed: () => ref.read(appLocaleProvider.notifier).toggleLocale(),
                    child: Text(locale.languageCode == 'bn' ? 'Switch to English' : 'বাংলায় পরিবর্তন'),
                  ),
                ),
                const Divider(),
                // Theme Mode
                ListTile(
                  leading: const Icon(Icons.dark_mode_rounded),
                  title: const Text('ডার্ক / লাইট থিম'),
                  subtitle: Text(themeMode == ThemeMode.dark ? 'ডার্ক গ্লাস' : 'লাইট গ্লাস'),
                  trailing: Switch(
                    value: themeMode == ThemeMode.dark,
                    activeThumbColor: tokens.colors.primaryEmerald,
                    onChanged: (_) => ref.read(appThemeModeProvider.notifier).toggleLightDark(),
                  ),
                ),
                const Divider(),
                // Glass Blur Quality
                Padding(
                  padding: EdgeInsets.all(tokens.spacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('গ্লাস ব্লার কোয়ালিটি', style: tokens.typography.bodyMedium),
                          Text(
                            glassQuality.name.toUpperCase(),
                            style: tokens.typography.label.copyWith(color: tokens.colors.primaryEmerald),
                          ),
                        ],
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      Text(
                        'কম র‍্যামের ফোনে মসৃণ অভিজ্ঞতার জন্য Low বা Medium নির্বাচন করুন।',
                        style: tokens.typography.label.copyWith(color: tokens.colors.textSecondary),
                      ),
                      SizedBox(height: tokens.spacing.sm),
                      GlassSegmentedControl<GlassQuality>(
                        segments: const {
                          GlassQuality.high: 'উচ্চ (High)',
                          GlassQuality.medium: 'মাঝারি (Med)',
                          GlassQuality.low: 'কম (Low/Flat)',
                        },
                        selectedValue: glassQuality,
                        onValueChanged: (val) => ref.read(glassQualityProvider.notifier).setQuality(val),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Section 2: Arabic & 4-Layer Text Options
          Text(
            'কুরআন ও দোয়ার ৪-স্তর পাঠ সেটিংস',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          GlassCard(
            enableBlur: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md, vertical: tokens.spacing.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('আরবি ফন্ট সাইজ', style: tokens.typography.bodyMedium),
                      Text('${_arabicFontSize.toInt()} pt', style: tokens.typography.label),
                    ],
                  ),
                ),
                Slider(
                  min: 20.0,
                  max: 42.0,
                  divisions: 11,
                  activeColor: tokens.colors.primaryEmerald,
                  value: _arabicFontSize,
                  onChanged: (val) => setState(() => _arabicFontSize = val),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('বাংলা উচ্চারণ (উচ্চারণ)'),
                  subtitle: const Text('বাংলা হরফে আরবি উচ্চারণ দেখান'),
                  activeThumbColor: tokens.colors.primaryEmerald,
                  value: _showBanglaPronunciation,
                  onChanged: (val) => setState(() => _showBanglaPronunciation = val),
                ),
                SwitchListTile(
                  title: const Text('বাংলিশ (রোমান উচ্চারণ)'),
                  subtitle: const Text('ইংরেজি হরফে সঠিক উচ্চারণ নির্দেশিকা'),
                  activeThumbColor: tokens.colors.primaryEmerald,
                  value: _showBanglish,
                  onChanged: (val) => setState(() => _showBanglish = val),
                ),
                SwitchListTile(
                  title: const Text('বাংলা অনুবাদ ও অর্থ'),
                  subtitle: const Text('প্রতিটি আয়াত ও দোয়ার বাংলা তরজমা'),
                  activeThumbColor: tokens.colors.primaryEmerald,
                  value: _showBanglaMeaning,
                  onChanged: (val) => setState(() => _showBanglaMeaning = val),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Section 3: Notification & Alarms Link
          Text(
            'আজান ও নোটিফিকেশন',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          GlassCard(
            child: ListTile(
              leading: const Icon(Icons.notifications_active_rounded),
              title: const Text('নামাজের অ্যালার্ট ও আজান কনফিগারেশন'),
              subtitle: const Text('৫ ওয়াক্তের আলাদা আজান সুর, স্মরণবার্তা ও ব্যাটারি অপ্টিমাইজেশন'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push('/notifications/settings'),
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Section 4: Data & Backup
          Text(
            'ডেটা ও ব্যাকআপ',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          GlassCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.file_download_rounded),
                  title: const Text('ব্যাকআপ এক্সপোর্ট (JSON)'),
                  subtitle: const Text('আপনার ট্র্যাকার ও কাযা হিসাব ফাইল হিসেবে সেভ করুন'),
                  onTap: () async {
                    final jsonStr = await ref.read(trackerRepositoryProvider).exportBackupJson();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('ব্যাকআপ সম্পন্ন! (${jsonStr.length} বাইট সংরক্ষিত)'),
                          backgroundColor: tokens.colors.primaryEmerald,
                        ),
                      );
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.file_upload_rounded),
                  title: const Text('ব্যাকআপ রিস্টোর (JSON)'),
                  subtitle: const Text('পূর্বের সংরক্ষিত ব্যাকআপ থেকে ট্র্যাকার পুনরুদ্ধার করুন'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('রিস্টোর করার জন্য ফাইল সিলেক্ট করুন')),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: tokens.spacing.xl),
        ],
      ),
    );
  }
}
