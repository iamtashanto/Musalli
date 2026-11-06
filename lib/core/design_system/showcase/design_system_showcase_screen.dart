import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/backgrounds/animated_gradient_background.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

const FourLayerText _showcaseFatihaVerse = FourLayerText(
  id: 'fatiha-1',
  titleBn: 'সূরা আল-ফাতিহা — আয়াত ১',
  titleEn: 'Surah Al-Fatihah — Ayah 1',
  arabic: 'بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ ﴿١﴾',
  uccharonBn: 'বিসমিল্লাহির রাহমানির রাহীম।',
  banglish: 'Bismillahir Rahmanir Rahim.',
  meaningBn: 'পরম করুণাময় অতি দয়ালু আল্লাহর নামে শুরু করছি।',
  meaningEn: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
  referenceTextBn: 'সূরা আল-ফাতিহা ১:১',
  referenceTextEn: 'Surah Al-Fatihah 1:1',
);

/// Interactive showcase screen (available in the `dev` flavor) displaying every
/// Musalli design-system component in light/dark themes and `GlassQuality`
/// tiers, plus a 50-item `GlassCard` list to benchmark 60fps scrolling.
class DesignSystemShowcaseScreen extends ConsumerStatefulWidget {
  /// Creates a [DesignSystemShowcaseScreen].
  const DesignSystemShowcaseScreen({super.key});

  @override
  ConsumerState<DesignSystemShowcaseScreen> createState() =>
      _DesignSystemShowcaseScreenState();
}

class _DesignSystemShowcaseScreenState
    extends ConsumerState<DesignSystemShowcaseScreen> {
  String _segmentValue = 'fard';
  bool _chipSelected = true;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final glassQuality = ref.watch(glassQualityProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      body: AnimatedGradientBackground(
        child: CustomScrollView(
          key: const Key('design-system-showcase-scroll'),
          slivers: <Widget>[
            GlassSliverAppBar(
              title: 'ডিজাইন সিস্টেম শোকেস',
              subtitle: 'Theme: ${themeMode.name} • Glass: ${glassQuality.name}',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: 'Back',
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.brightness_6_rounded),
                  onPressed: () =>
                      ref.read(appThemeModeProvider.notifier).toggleLightDark(),
                  tooltip: 'Toggle Theme',
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(tokens.spacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  // 1. Glass Quality & Theme Switcher
                  const SectionHeader(
                    title: '১. গ্লাস কোয়ালিটি ও থিম নিয়ন্ত্রণ',
                    subtitle: 'উচ্চ, মাঝারি ও কম র‍্যাম মোডে গ্লাস সারফেস পরীক্ষা করুন',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  GlassSegmentedControl<GlassQuality>(
                    segments: const <GlassQuality, String>{
                      GlassQuality.high: 'High (Blur 24)',
                      GlassQuality.medium: 'Med (Blur 12)',
                      GlassQuality.low: 'Low (No Blur)',
                    },
                    selectedValue: glassQuality,
                    onValueChanged: (GlassQuality q) =>
                        ref.read(glassQualityProvider.notifier).setQuality(q),
                  ),
                  SizedBox(height: tokens.spacing.lg),

                  // 2. Semantic Ruling Badges & Reference Chips
                  const SectionHeader(
                    title: '২. ফিকহি ব্যাজ ও রেফারেন্স চিপ',
                    subtitle: 'ফরজ, ওয়াজিব, সুন্নাত, নফল ও হাদিস গ্রেডিং',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  Wrap(
                    spacing: tokens.spacing.xs,
                    runSpacing: tokens.spacing.xs,
                    children: const <Widget>[
                      RulingBadge(category: RulingCategory.fard),
                      RulingBadge(category: RulingCategory.wajib),
                      RulingBadge(category: RulingCategory.sunnah),
                      RulingBadge(category: RulingCategory.nafl),
                      RulingBadge(category: RulingCategory.special),
                      ReferenceChip(
                        citation: 'সহীহ বুখারী ৭৫৭',
                        grade: HadithGrade.sahih,
                      ),
                      ReferenceChip(
                        citation: 'জামে তিরমিজি ২৪৩',
                        grade: HadithGrade.hasan,
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacing.lg),

                  // 3. Buttons, Chips & Segmented Controls
                  const SectionHeader(
                    title: '৩. বাটন, চিপ ও সেগমেন্টেড কন্ট্রোল',
                    subtitle: 'Press scale 0.97 + Haptic feedback',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  Wrap(
                    spacing: tokens.spacing.sm,
                    runSpacing: tokens.spacing.sm,
                    children: <Widget>[
                      GlassButton(
                        label: 'প্রাইমারি বাটন',
                        icon: Icons.play_arrow_rounded,
                        onPressed: () {},
                      ),
                      GlassButton(
                        label: 'সেকেন্ডারি গ্লাস',
                        variant: GlassButtonVariant.secondary,
                        onPressed: () {},
                      ),
                      GlassButton(
                        label: 'গোস্ট বাটন',
                        variant: GlassButtonVariant.ghost,
                        onPressed: () {},
                      ),
                      GlassChip(
                        label: 'অজু চেকলিস্ট',
                        leadingIcon: Icons.check_circle_outline_rounded,
                        selected: _chipSelected,
                        onTap: () =>
                            setState(() => _chipSelected = !_chipSelected),
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  GlassSegmentedControl<String>(
                    segments: const <String, String>{
                      'fard': '৪ রাকাত ফরজ',
                      'sunnah': '৪ রাকাত সুন্নাত',
                      'witr': '৩ রাকাত বিতর',
                    },
                    selectedValue: _segmentValue,
                    onValueChanged: (String v) =>
                        setState(() => _segmentValue = v),
                  ),
                  SizedBox(height: tokens.spacing.lg),

                  // 4. Search Bar, Callouts, ProgressRing, EmptyState & Shimmer
                  const SectionHeader(
                    title: '৪. সার্চ বার, কলআউট, প্রোগ্রেস রিং ও লোডার',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  const GlassSearchBar(
                    hintText: 'নামাজ বা সূরা খুঁজুন...',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  const Callout(
                    title: 'হানাফি মাযহাবের মূলনীতি',
                    message:
                        'ফরজ নামাজের প্রথম দুই রাকাতে সূরা ফাতিহার পর অন্য একটি সূরা বা অন্তত তিন ছোট আয়াত মিলানো ওয়াজিব।',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  const Callout(
                    variant: CalloutVariant.warning,
                    title: 'সিজদায়ে সাহু সতর্কতা',
                    message:
                        'কোনো ওয়াজিব ভুলবশত ছুটে গেলে শেষ বৈঠকে তাশাহহুদের পর সিজদায়ে সাহু আদায় করা আবশ্যক।',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  Row(
                    children: <Widget>[
                      const ProgressRing(progress: 0.75),
                      SizedBox(width: tokens.spacing.md),
                      const Expanded(
                        child: GlassShimmerLoader(height: 60),
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  const EmptyState(
                    title: 'কোনো বুকমার্ক নেই',
                    message: 'আপনার পছন্দের দোয়া বা মাসআলা বুকমার্ক করলে এখানে দেখা যাবে।',
                  ),
                  SizedBox(height: tokens.spacing.lg),

                  // 5. 4-Layer ArabicBlock
                  const SectionHeader(
                    title: '৫. ৪-স্তর আরবি ব্লক (ArabicBlock)',
                    subtitle: 'আরবি, বাংলা উচ্চারণ, ব্যাংলিশ ও অর্থ টগলসহ',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  const ArabicBlock(
                    data: _showcaseFatihaVerse,
                    initialShowBanglish: true,
                    activeWordIndex: 1,
                  ),
                  SizedBox(height: tokens.spacing.lg),

                  // 6. 50 GlassCards 60fps Stress Test List
                  const SectionHeader(
                    title: '৬. ৫০টি GlassCard পারফরম্যান্স স্ট্রেস টেস্ট (60fps)',
                    subtitle: 'কম র‍্যাম ডিভাইসে মসৃণ স্ক্রলিং যাচাইয়ের তালিকা',
                  ),
                  SizedBox(height: tokens.spacing.sm),
                ]),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                tokens.spacing.md,
                0,
                tokens.spacing.md,
                tokens.spacing.xxl,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final itemNum = BengaliNumberFormatter.formatInt(index + 1);
                    return Padding(
                      padding: EdgeInsets.only(bottom: tokens.spacing.xs),
                      child: GlassListTile(
                        leadingIcon: Icons.verified_outlined,
                        title: 'গ্লাস কার্ড আইটেম #$itemNum',
                        subtitle:
                            'হানাফি ফিকহ • ৬০ এফপিএস স্ক্রলিং পরীক্ষা (#$itemNum/৫০)',
                        trailing: const RulingBadge(
                          category: RulingCategory.sunnah,
                        ),
                      ),
                    );
                  },
                  childCount: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

