import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/services/notification_service.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedGender = 'male';
  String _selectedMadhab = 'hanafi';

  Future<void> _completeOnboarding() async {
    final db = ref.read(appDatabaseProvider);
    await db.setSetting('onboarding_completed_v1', 'true');
    await db.setSetting('user_gender', _selectedGender);
    await db.setSetting('user_madhab', _selectedMadhab);

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Scaffold(
      backgroundColor: tokens.colors.backgroundStart,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.md,
                vertical: tokens.spacing.sm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(4, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6),
                        width: isActive ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? tokens.colors.primaryEmerald
                              : tokens.colors.borderSubtle,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  if (_currentPage < 3)
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(
                        'এড়িয়ে যান',
                        style: tokens.typography.bodyMedium.copyWith(
                          color: tokens.colors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Page View
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  // Page 1: Welcome
                  _buildPage(
                    title: 'মুসল্লিতে স্বাগতম',
                    subtitle: 'আপনার সহিহ ও একাগ্র নামাজ শেখার পূর্ণাঙ্গ ডিজিটাল সঙ্গী।',
                    icon: Icons.mosque_rounded,
                    content: Column(
                      children: [
                        _buildFeatureBullet(
                          tokens,
                          Icons.accessibility_new_rounded,
                          'ইন্টারেক্টিভ সিমুলেটর',
                          'পুরুষ ও নারীর নামাজ ধাপে ধাপে রিয়েল-টাইম দৃশ্য ও অডিওর মাধ্যমে শিখুন।',
                        ),
                        SizedBox(height: tokens.spacing.md),
                        _buildFeatureBullet(
                          tokens,
                          Icons.offline_pin_rounded,
                          '১০০% অফলাইন ও ব্যক্তিগত',
                          'কোনো অ্যাকাউন্ট প্রয়োজন নেই, কোনো বিজ্ঞাপন বা ট্র্যাকিং নেই।',
                        ),
                        SizedBox(height: tokens.spacing.md),
                        _buildFeatureBullet(
                          tokens,
                          Icons.menu_book_rounded,
                          'সহিহ মাসআলা ও ৪-স্তর বিশিষ্ট পাঠ',
                          'আরবি, বাংলা উচ্চারণ, বাংলিশ ও অর্থসহ কুরআন-হাদিসের দলিল।',
                        ),
                      ],
                    ),
                  ),

                  // Page 2: Gender & Appearance
                  _buildPage(
                    title: 'নামাজের নিয়ম নির্বাচন',
                    subtitle: 'শরীয়তের বিধি অনুযায়ী পুরুষ ও নারীদের নামাজের অঙ্গবিন্যাস ভিন্ন হয়।',
                    icon: Icons.person_outline_rounded,
                    content: Column(
                      children: [
                        GlassCard(
                          borderGlow: _selectedGender == 'male',
                          child: RadioListTile<String>(
                            value: 'male',
                            groupValue: _selectedGender,
                            activeColor: tokens.colors.primaryEmerald,
                            title: Text('পুরুষদের জন্য', style: tokens.typography.titleMedium),
                            subtitle: Text(
                              'তাকবীরে তাহরীমায় কান পর্যন্ত হাত তোলা, নাভির নিচে হাত বাঁধা, সিজদায় ফাঁকা রাখা।',
                              style: tokens.typography.bodySmall.copyWith(color: tokens.colors.textSecondary),
                            ),
                            onChanged: (val) => setState(() => _selectedGender = val!),
                          ),
                        ),
                        SizedBox(height: tokens.spacing.md),
                        GlassCard(
                          borderGlow: _selectedGender == 'female',
                          child: RadioListTile<String>(
                            value: 'female',
                            groupValue: _selectedGender,
                            activeColor: tokens.colors.primaryEmerald,
                            title: Text('নারীদের জন্য', style: tokens.typography.titleMedium),
                            subtitle: Text(
                              'কাঁধ পর্যন্ত হাত তোলা, বুকের ওপর হাত বাঁধা, রুকু ও সিজদায় সংকুচিত হয়ে থাকা।',
                              style: tokens.typography.bodySmall.copyWith(color: tokens.colors.textSecondary),
                            ),
                            onChanged: (val) => setState(() => _selectedGender = val!),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Page 3: Madhab & Location
                  _buildPage(
                    title: 'মাজহাব ও সময় গণনা',
                    subtitle: 'বাংলাদেশে প্রচলিত হানাফি মাজহাব ও করাচি মেথড ডিফল্ট হিসেবে রাখা হয়েছে।',
                    icon: Icons.access_time_rounded,
                    content: Column(
                      children: [
                        GlassCard(
                          borderGlow: _selectedMadhab == 'hanafi',
                          child: RadioListTile<String>(
                            value: 'hanafi',
                            groupValue: _selectedMadhab,
                            activeColor: tokens.colors.primaryEmerald,
                            title: Text('হানাফি মাজহাব (বাংলাদেশ ডিফল্ট)', style: tokens.typography.titleMedium),
                            subtitle: Text(
                              'আসর দুই মিথলে (ছায়া দ্বিগুণ হলে শুরু), করাচি ইসলামিক বিশ্ববিদ্যালয় পদ্ধতি।',
                              style: tokens.typography.bodySmall.copyWith(color: tokens.colors.textSecondary),
                            ),
                            onChanged: (val) => setState(() => _selectedMadhab = val!),
                          ),
                        ),
                        SizedBox(height: tokens.spacing.md),
                        GlassCard(
                          borderGlow: _selectedMadhab == 'shafi',
                          child: RadioListTile<String>(
                            value: 'shafi',
                            groupValue: _selectedMadhab,
                            activeColor: tokens.colors.primaryEmerald,
                            title: Text('শাফেঈ / মালেকী / হাম্বলী', style: tokens.typography.titleMedium),
                            subtitle: Text(
                              'আসর এক মিথলে (ছায়া সমপরিমাণ হলে শুরু)।',
                              style: tokens.typography.bodySmall.copyWith(color: tokens.colors.textSecondary),
                            ),
                            onChanged: (val) => setState(() => _selectedMadhab = val!),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Page 4: Notifications
                  _buildPage(
                    title: 'নামাজের অ্যালার্ট ও আজান',
                    subtitle: 'ওয়াক্ত শুরু ও জামাতের প্রস্তুতি নিতে সঠিক সময় অ্যালার্ট ও নোটিফিকেশন দিন।',
                    icon: Icons.notifications_active_rounded,
                    content: Column(
                      children: [
                        GlassCard(
                          enableBlur: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'নোটিফিকেশন সুবিধা:',
                                style: tokens.typography.titleSmall.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: tokens.spacing.xs),
                              Text(
                                '• পাঁচ ওয়াক্তের আজান ও অ্যালার্ট\n'
                                '• ওয়াক্তের ১৫ মিনিট পূর্বে পূর্বসতর্কবার্তা\n'
                                '• শুক্রবার জুমার বিশেষ স্মরণ করিয়ে দেয়া (সূরা কাহাফ)\n'
                                '• ব্যাটারি অপ্টিমাইজেশন মুক্ত নির্ভরযোগ্য অ্যালার্ম',
                                style: tokens.typography.bodyMedium.copyWith(height: 1.6),
                              ),
                              SizedBox(height: tokens.spacing.md),
                              GlassButton(
                                label: 'নোটিফিকেশন পারমিশন দিন',
                                icon: Icons.notifications_rounded,
                                onPressed: () async {
                                  await NotificationService.instance.initialize();
                                  await NotificationService.instance.requestPermissions();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Navigation Controls
            Padding(
              padding: EdgeInsets.all(tokens.spacing.md),
              child: Row(
                children: [
                  if (_currentPage > 0) ...[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    SizedBox(width: tokens.spacing.sm),
                  ],
                  Expanded(
                    child: GlassButton(
                      label: _currentPage == 3 ? 'শুরু করুন ✨' : 'পরবর্তী',
                      icon: _currentPage == 3 ? Icons.check : Icons.arrow_forward_rounded,
                      onPressed: () {
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _completeOnboarding();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget content,
  }) {
    final tokens = context.tokens;
    return ListView(
      padding: EdgeInsets.all(tokens.spacing.md),
      children: [
        SizedBox(height: tokens.spacing.lg),
        Center(
          child: Container(
            padding: EdgeInsets.all(tokens.spacing.lg),
            decoration: BoxDecoration(
              color: tokens.colors.primaryEmerald.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 56, color: tokens.colors.primaryEmerald),
          ),
        ),
        SizedBox(height: tokens.spacing.lg),
        Text(
          title,
          textAlign: TextAlign.center,
          style: tokens.typography.display.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 26,
          ),
        ),
        SizedBox(height: tokens.spacing.xs),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: tokens.typography.bodyMedium.copyWith(color: tokens.colors.textSecondary),
        ),
        SizedBox(height: tokens.spacing.xl),
        content,
      ],
    );
  }

  Widget _buildFeatureBullet(
    MusalliDesignTokens tokens,
    IconData icon,
    String title,
    String description,
  ) {
    return GlassCard(
      enableBlur: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(tokens.spacing.xs),
            decoration: BoxDecoration(
              color: tokens.colors.primaryEmerald.withAlpha(40),
              borderRadius: BorderRadius.circular(tokens.radii.sm),
            ),
            child: Icon(icon, size: 24, color: tokens.colors.primaryEmerald),
          ),
          SizedBox(width: tokens.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tokens.typography.titleSmall.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2),
                Text(
                  description,
                  style: tokens.typography.bodySmall.copyWith(color: tokens.colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
