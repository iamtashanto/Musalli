import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/extra/presentation/mosque_finder_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;

    return Scaffold(
      backgroundColor: tokens.colors.backgroundStart,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'আরও ফিচার ও সেবা',
          style: tokens.typography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.md),
        children: [
          // Section 1: Daily Companion Essentials
          Text(
            'দৈনন্দিন ইবাদতের সরঞ্জাম',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          _buildActionCard(
            context,
            icon: Icons.fingerprint_rounded,
            title: 'ডিজিটাল তাসবীহ',
            subtitle: 'হ্যাপটিক ভাইব্রেশন ও ৩৩/৯৯ জিকির কাউন্টার',
            onTap: () => context.push('/tasbih'),
          ),
          _buildActionCard(
            context,
            icon: Icons.wb_twilight_rounded,
            title: 'সকাল ও সন্ধ্যার আজকার',
            subtitle: 'সহিহ হাদিসভিত্তিক সকাল-সন্ধ্যার আমল ও হেফাজতের দোয়া',
            onTap: () => context.push('/adhkar'),
          ),
          _buildActionCard(
            context,
            icon: Icons.auto_stories_rounded,
            title: 'আসমাউল হুসনা (আল্লাহর ৯৯ নাম)',
            subtitle: 'অর্থ, ফজিলত ও তাৎপর্যসহ আল্লাহর পবিত্র গুণবাচক নাম',
            onTap: () => context.push('/asmaul-husna'),
          ),
          _buildActionCard(
            context,
            icon: Icons.explore_rounded,
            title: 'কিবলা কম্পাস',
            subtitle: 'ম্যাগনেটোমিটার সেন্সর ও সুনির্দিষ্ট ডিগ্রিসহ কিবলা নির্ণয়',
            onTap: () => context.push('/qibla'),
          ),
          _buildActionCard(
            context,
            icon: Icons.calendar_month_rounded,
            title: 'হিজরি ক্যালেন্ডার ও দিনপঞ্জি',
            subtitle: 'বাংলাদেশের ইসলামিক দিবস ও চাঁদ দেখা সমন্বয়',
            onTap: () => context.push('/calendar'),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Section 2: Salah Assistants & Helpers
          Text(
            'নামাজ ট্র্যাকার ও সহায়িকা',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          _buildActionCard(
            context,
            icon: Icons.track_changes_rounded,
            title: 'নামাজ ট্র্যাকার ও কাযা হিসাব',
            subtitle: 'দৈনিক ৫ ওয়াক্তের হিসাব এবং পূর্বের ছুটে যাওয়া কাযা ক্যালকুলেটর',
            onTap: () => context.push('/tracker'),
          ),
          _buildActionCard(
            context,
            icon: Icons.record_voice_over_rounded,
            title: 'হিফজ ও কিরাত মুখস্থ মোড',
            subtitle: 'স্পেসড রিপিটেশন ও শব্দ আড়াল করে সূরা মুখস্থের পরীক্ষা',
            onTap: () => context.push('/hifz/1'), // Opens Al-Fatiha or list
          ),
          _buildActionCard(
            context,
            icon: Icons.nights_stay_rounded,
            title: 'রমজান মোড',
            subtitle: 'সাহরি-ইফতারের লাইভ কাউন্টডাউন ও ৩০ দিনের রোজা ট্র্যাকার',
            onTap: () => context.push('/ramadan'),
          ),
          _buildActionCard(
            context,
            icon: Icons.calculate_rounded,
            title: 'যাকাত ক্যালকুলেটর',
            subtitle: 'স্বর্ণ-রুপার বর্তমান নিসাব এবং সম্পদ ও ঋণের হিসাব',
            onTap: () => context.push('/zakat'),
          ),
          _buildActionCard(
            context,
            icon: Icons.near_me_rounded,
            title: 'কাছের মসজিদ খুঁজুন',
            subtitle: 'ম্যাপের মাধ্যমে আপনার অবস্থানের নিকটস্থ মসজিদসমূহ দেখুন',
            onTap: () => MosqueFinderService.openNearbyMosques(),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Section 3: App Configuration & About
          Text(
            'অ্যাপ ও তথ্যাবলি',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          _buildActionCard(
            context,
            icon: Icons.notifications_active_rounded,
            title: 'আজান ও নোটিফিকেশন সেটিংস',
            subtitle: 'ওয়াক্তের অ্যালার্ম, সাউন্ড চয়েস ও ব্যাটারি গাইড',
            onTap: () => context.push('/notifications/settings'),
          ),
          _buildActionCard(
            context,
            icon: Icons.settings_rounded,
            title: 'অ্যাপ সেটিংস',
            subtitle: 'ভাষা, থিম, গ্লাস ব্লার, ৪-স্তর টেক্সট সাইজ ও ব্যাকআপ',
            onTap: () => context.push('/settings'),
          ),
          _buildActionCard(
            context,
            icon: Icons.info_outline_rounded,
            title: 'মুসল্লি সম্পর্কে ও উৎস',
            subtitle: 'দলিলসূত্র, নির্ভরযোগ্যতা ও ডেভেলপমেন্ট তথ্য',
            onTap: () => _showAboutDialog(context),
          ),

          SizedBox(height: tokens.spacing.xl),

          // Developer Credit Card
          Center(
            child: InkWell(
              onTap: () => launchUrl(
                Uri.parse('https://tashanto.com'),
                mode: LaunchMode.externalApplication,
              ),
              borderRadius: BorderRadius.circular(tokens.radii.md),
              child: Padding(
                padding: EdgeInsets.all(tokens.spacing.sm),
                child: Column(
                  children: [
                    Text(
                      'Crafted with ❤️ by TA Shanto',
                      style: tokens.typography.label.copyWith(
                        color: tokens.colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: tokens.spacing.xs),
                    Text(
                      'tashanto.com • namajshikkha.tashanto.com',
                      style: tokens.typography.bodySmall.copyWith(
                        color: tokens.colors.primaryEmerald,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: tokens.spacing.xl),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final tokens = context.tokens;
    return Padding(
      padding: EdgeInsets.only(bottom: tokens.spacing.sm),
      child: GlassCard(
        enableBlur: false,
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(tokens.spacing.xs),
            decoration: BoxDecoration(
              color: tokens.colors.primaryEmerald.withAlpha(30),
              borderRadius: BorderRadius.circular(tokens.radii.sm),
            ),
            child: Icon(icon, color: tokens.colors.primaryEmerald, size: 24),
          ),
          title: Text(
            title,
            style: tokens.typography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            subtitle,
            style: tokens.typography.bodySmall.copyWith(color: tokens.colors.textSecondary),
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final tokens = context.tokens;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: tokens.colors.backgroundStart,
        title: Row(
          children: [
            Icon(Icons.mosque_rounded, color: tokens.colors.primaryEmerald),
            SizedBox(width: tokens.spacing.sm),
            const Text('মুসল্লি (Musalli)'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ভার্সন: ১.০.০ (রিলিজ)'),
            const SizedBox(height: 8),
            const Text(
              'মুসল্লি একটি ১০০% অফলাইন-ফার্স্ট, ট্র্যাকিংমুক্ত এবং বিজ্ঞাপনবিহীন ইসলামিক অ্যাপ। সমস্ত মাসআলা ও দোয়া নির্ভরযোগ্য কুরআন এবং সিহাহ সিত্তাহ হাদিস গ্রন্থসমূহ হতে সংকলিত।',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text('ওয়েব সংস্করণ: https://namajshikkha.tashanto.com'),
            const SizedBox(height: 8),
            const Text('ডেভেলপার: তৌহিদুল আলম শান্ত (TA Shanto)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }
}
