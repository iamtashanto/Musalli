import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/design_system/motion/musalli_page_transitions.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/l10n/arb/app_localizations.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

const FourLayerText _sampleSana = FourLayerText(
  id: 'dua-sana',
  titleBn: 'সানা (তাকবীরে তাহরীমার পর পাঠ্য)',
  titleEn: 'Sana (Opening Supplication)',
  arabic:
      'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ وَتَبَارَكَ اسْمُكَ وَتَعَالَىٰ جَدُّكَ وَلَا إِلَـٰهَ غَيْرُكَ',
  uccharonBn:
      'সুবহানাকাল্লাহুম্মা ওয়া বিহামদিকা ওয়া তাবারাকাসমুকা ওয়া তাআলা জাদ্দুকা ওয়া লা ইলাহা গাইরুক।',
  banglish:
      "Subhanakallahumma wa bihamdika wa tabarakasmuka wa ta'ala jadduka wa la ilaha ghairuk.",
  meaningBn:
      'হে আল্লাহ! আমি আপনার পবিত্রতা ও প্রশংসা বর্ণনা করছি। আপনার নাম বরকতময়, আপনার মহত্ত্ব অতি উচ্চে এবং আপনি ছাড়া কোনো উপাস্য নেই।',
  meaningEn:
      'Glory be to You, O Allah, and praise be to You. Blessed is Your Name and exalted is Your Majesty, and there is none worthy of worship besides You.',
  referenceTextBn: 'সুনানে আবু দাউদ ৭৭৫ • জামে তিরমিজি ২৪৩',
  referenceTextEn: 'Sunan Abu Dawud 775 • Jami at-Tirmidhi 243',
  grade: HadithGrade.sahih,
);

/// Tab 1: Home (`হোম`) foundation screen with quick prayer cards (Hero enabled),
/// daily streak counter, and Hanafi fiqh indicator.
class HomeTabScreen extends ConsumerStatefulWidget {
  /// Creates a [HomeTabScreen].
  const HomeTabScreen({super.key});

  @override
  ConsumerState<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> {
  int _streakDays = 7;

  static const List<({String slug, String nameBn, String nameEn, int rakats, RulingCategory category})>
      _featuredPrayers = <({String slug, String nameBn, String nameEn, int rakats, RulingCategory category})>[
    (
      slug: 'fajr',
      nameBn: 'ফজরের নামাজ',
      nameEn: 'Fajr Prayer',
      rakats: 4,
      category: RulingCategory.fard,
    ),
    (
      slug: 'dhuhr',
      nameBn: 'যোহরের নামাজ',
      nameEn: 'Dhuhr Prayer',
      rakats: 12,
      category: RulingCategory.fard,
    ),
    (
      slug: 'asr',
      nameBn: 'আসরের নামাজ',
      nameEn: 'Asr Prayer',
      rakats: 8,
      category: RulingCategory.fard,
    ),
    (
      slug: 'maghrib',
      nameBn: 'মাগরিবের নামাজ',
      nameEn: 'Maghrib Prayer',
      rakats: 7,
      category: RulingCategory.fard,
    ),
    (
      slug: 'isha',
      nameBn: 'এশার নামাজ',
      nameEn: 'Isha Prayer',
      rakats: 17,
      category: RulingCategory.fard,
    ),
    (
      slug: 'witr',
      nameBn: 'বিতর নামাজ',
      nameEn: 'Witr Prayer',
      rakats: 3,
      category: RulingCategory.wajib,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = context.tokens;
    final locale = ref.watch(appLocaleProvider);
    final isBangla = locale.languageCode == 'bn';

    return CrescentRefreshWrapper(
      onRefresh: () async {
        await Future<void>.delayed(const Duration(milliseconds: 350));
        if (mounted) {
          setState(() => _streakDays += 1);
        }
      },
      child: CustomScrollView(
        key: const PageStorageKey<String>('home-tab-scroll'),
        slivers: <Widget>[
          GlassSliverAppBar(
            title: l10n.appTitle,
            subtitle: l10n.hanafiBadge,
            actions: <Widget>[
              IconButton(
                onPressed: () => ref.read(appLocaleProvider.notifier).toggleLocale(),
                tooltip: l10n.languageLabel,
                icon: const Icon(Icons.translate_rounded),
              ),
              IconButton(
                onPressed: () =>
                    ref.read(appThemeModeProvider.notifier).toggleLightDark(),
                tooltip: l10n.themeModeLabel,
                icon: const Icon(Icons.brightness_6_rounded),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              tokens.spacing.md,
              tokens.spacing.md,
              tokens.spacing.md,
              120,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                FirstMountStaggeredEntrance(
                  index: 0,
                  child: GlassCard(
                    enableBlur: true,
                    borderGlow: true,
                    child: Row(
                      children: <Widget>[
                        ProgressRing(
                          progress: 0.8,
                          isBangla: isBangla,
                        ),
                        SizedBox(width: tokens.spacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const RulingBadge(category: RulingCategory.fard),
                              SizedBox(height: tokens.spacing.xs),
                              Text(
                                l10n.appSubtitle,
                                style: tokens.typography.bodyMedium,
                              ),
                              SizedBox(height: tokens.spacing.xs),
                              Row(
                                children: <Widget>[
                                  Text(
                                    isBangla
                                        ? 'ধারাবাহিক আমল: '
                                        : 'Active Streak: ',
                                    style: tokens.typography.label,
                                  ),
                                  AnimatedNumberCounter(
                                    value: _streakDays,
                                    formatter: (int v) =>
                                        '${BengaliNumberFormatter.formatInt(v, isBangla: isBangla)} ${isBangla ? 'দিন' : 'days'}',
                                    style: tokens.typography.titleMedium.copyWith(
                                      color: tokens.colors.goldAccent,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: tokens.spacing.lg),
                FirstMountStaggeredEntrance(
                  index: 1,
                  child: SectionHeader(
                    title: isBangla
                        ? 'দৈনিক ৫ ওয়াক্ত ও বিতর নামাজ'
                        : 'Daily 5 Fard & Witr Prayers',
                    subtitle: isBangla
                        ? 'যেকোনো নামাজে ট্যাপ করে বিস্তারিত নিয়ম ও সিমুলেটর দেখুন'
                        : 'Tap any prayer to open the step-by-step guide',
                  ),
                ),
                SizedBox(height: tokens.spacing.sm),
                ...List<Widget>.generate(_featuredPrayers.length, (int idx) {
                  final prayer = _featuredPrayers[idx];
                  final title = isBangla ? prayer.nameBn : prayer.nameEn;
                  final rakatLabel =
                      '${BengaliNumberFormatter.formatInt(prayer.rakats, isBangla: isBangla)} ${isBangla ? 'রাকাত' : 'Rakats'}';

                  return Padding(
                    padding: EdgeInsets.only(bottom: tokens.spacing.sm),
                    child: FirstMountStaggeredEntrance(
                      index: idx + 2,
                      child: GlassListTile(
                        heroTag: 'prayer-card-${prayer.slug}',
                        leadingIcon: Icons.mosque_rounded,
                        title: title,
                        subtitle: rakatLabel,
                        trailing: RulingBadge(
                          category: prayer.category,
                          isBangla: isBangla,
                        ),
                        onTap: () => context.push('/namaj/${prayer.slug}'),
                      ),
                    ),
                  );
                }),
                SizedBox(height: tokens.spacing.md),
                FirstMountStaggeredEntrance(
                  index: 8,
                  child: ArabicBlock(
                    data: _sampleSana,
                    isBanglaLocale: isBangla,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tab 2: Learn (`শিখুন`) foundation screen with search bar and category tiles.
class LearnTabScreen extends ConsumerStatefulWidget {
  /// Creates a [LearnTabScreen].
  const LearnTabScreen({super.key});

  @override
  ConsumerState<LearnTabScreen> createState() => _LearnTabScreenState();
}

class _LearnTabScreenState extends ConsumerState<LearnTabScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = context.tokens;
    final isBangla = ref.watch(appLocaleProvider).languageCode == 'bn';

    final topics = <({String slug, String titleBn, String titleEn, String subBn, String subEn})>[
      (
        slug: 'fajr',
        titleBn: 'নামাজের ফরজ, ওয়াজিব ও সুন্নাত',
        titleEn: 'Fard, Wajib & Sunnah of Salah',
        subBn: 'হানাফি ফিকহ অনুযায়ী ১৪ ফরজ ও ১৪ ওয়াজিব',
        subEn: '14 Fard & 14 Wajib rulings according to Hanafi Fiqh',
      ),
      (
        slug: 'jumuah',
        titleBn: 'জুমআ ও দুই ঈদের নামাজ',
        titleEn: 'Jumuah & Eid Prayers',
        subBn: 'জুমআর শর্তাবলি ও ৬ অতিরিক্ত তাকবীরের নিয়ম',
        subEn: 'Conditions of Jumuah and 6 extra Eid takbirs',
      ),
      (
        slug: 'janaza',
        titleBn: 'জানাজার নামাজের নিয়ম ও দোয়া',
        titleEn: 'Janaza Prayer Guide & Duas',
        subBn: '৪ তাকবীর, সানা, দরূদ এবং বালেগ ও নাবালেগের দোয়া',
        subEn: '4 Takbirs, Sana, Durood & funeral supplications',
      ),
      (
        slug: 'tahajjud',
        titleBn: 'তাহাজ্জুদ, তারাবীহ ও নফল নামাজ',
        titleEn: 'Tahajjud, Tarawih & Nafl Salah',
        subBn: 'রাকাত সংখ্যা, সময় ও ফযীলত দলিলসহ',
        subEn: 'Rakat counts, times, and authentic virtues',
      ),
    ].where((t) {
      if (_query.trim().isEmpty) return true;
      final q = _query.toLowerCase();
      return t.titleBn.toLowerCase().contains(q) ||
          t.titleEn.toLowerCase().contains(q);
    }).toList(growable: false);

    return CustomScrollView(
      key: const PageStorageKey<String>('learn-tab-scroll'),
      slivers: <Widget>[
        GlassSliverAppBar(
          title: l10n.tabLearn,
          subtitle: l10n.hanafiBadge,
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            tokens.spacing.md,
            tokens.spacing.md,
            tokens.spacing.md,
            120,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              GlassSearchBar(
                hintText: l10n.searchPlaceholder,
                onChanged: (String v) => setState(() => _query = v),
              ),
              SizedBox(height: tokens.spacing.md),
              const Callout(
                title: 'পুরুষ ও মহিলাদের নামাজের পার্থক্য',
                message:
                    'হানাফি ফিকহ অনুযায়ী তাকবীরে হাত উঠানো, হাত বাঁধা, রুকু ও সিজদার সংকুচিত অবস্থানে পুরুষ ও মহিলাদের সুন্নাত পদ্ধতির পার্থক্য প্রতিটি অধ্যায়ে স্পষ্টভাবে দেখানো হয়েছে।',
              ),
              SizedBox(height: tokens.spacing.md),
              ...topics.map(
                (t) => Padding(
                  padding: EdgeInsets.only(bottom: tokens.spacing.sm),
                  child: GlassListTile(
                    leadingIcon: Icons.auto_stories_rounded,
                    title: isBangla ? t.titleBn : t.titleEn,
                    subtitle: isBangla ? t.subBn : t.subEn,
                    onTap: () => context.push('/namaj/${t.slug}'),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

/// Tab 3: Simulator (`সিমুলেটর`) foundation screen supporting query parameters
/// (`musalli://simulator?prayer=<slug>&unit=<id>`).
class SimulatorTabScreen extends ConsumerStatefulWidget {
  /// Creates a [SimulatorTabScreen].
  const SimulatorTabScreen({
    this.initialPrayerSlug,
    this.initialUnitId,
    super.key,
  });

  /// Deep-linked prayer slug (e.g. `fajr`, `zuhr`).
  final String? initialPrayerSlug;

  /// Deep-linked rakat unit identifier (e.g. `fard`, `sunnah`).
  final String? initialUnitId;

  @override
  ConsumerState<SimulatorTabScreen> createState() => _SimulatorTabScreenState();
}

class _SimulatorTabScreenState extends ConsumerState<SimulatorTabScreen> {
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = context.tokens;
    final isBangla = ref.watch(appLocaleProvider).languageCode == 'bn';
    final prayerSlug = widget.initialPrayerSlug ?? 'fajr';
    final unitId = widget.initialUnitId ?? 'fard';

    return CustomScrollView(
      key: const PageStorageKey<String>('simulator-tab-scroll'),
      slivers: <Widget>[
        GlassSliverAppBar(
          title: l10n.tabSimulator,
          subtitle: '2D Articulated Figure • Audio Synced',
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            tokens.spacing.md,
            tokens.spacing.md,
            tokens.spacing.md,
            120,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              GlassCard(
                enableBlur: true,
                borderGlow: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RulingBadge(
                          category: RulingCategory.fard,
                          customLabel: 'Prayer: $prayerSlug ($unitId)',
                          isBangla: isBangla,
                        ),
                        const ReferenceChip(
                          citation: 'সহীহ বুখারী ৬৩১',
                          grade: HadithGrade.sahih,
                        ),
                      ],
                    ),
                    SizedBox(height: tokens.spacing.md),
                    Text(
                      isBangla
                          ? 'ইন্টারঅ্যাক্টিভ নামাজ সিমুলেটর'
                          : 'Interactive Salah Simulator',
                      style: tokens.typography.titleLarge,
                    ),
                    SizedBox(height: tokens.spacing.xs),
                    Text(
                      isBangla
                          ? 'পুরুষ ও মহিলাদের আলাদা পোশাক ও নামাজের ভঙ্গিসহ প্রতিটি রাকাত, তাসবীহ ও কিরাত ধাপে ধাপে অনুশীলন করুন।'
                          : 'Step-by-step animated figure with separate male and female postures, synced recitations, and practice quiz mode.',
                      style: tokens.typography.bodyMedium,
                    ),
                    SizedBox(height: tokens.spacing.md),
                    GlassSegmentedControl<String>(
                      segments: <String, String>{
                        'male': isBangla ? 'পুরুষ (Male)' : 'Male',
                        'female': isBangla ? 'মহিলা (Female)' : 'Female',
                      },
                      selectedValue: _selectedGender,
                      onValueChanged: (String v) =>
                          setState(() => _selectedGender = v),
                    ),
                    SizedBox(height: tokens.spacing.md),
                    GlassButton(
                      label: l10n.simulatorQuickStart,
                      icon: Icons.play_arrow_rounded,
                      isExpanded: true,
                      onPressed: () {
                        unawaited(
                          GlassBottomSheet.show<void>(
                            context: context,
                            title: isBangla
                                ? 'সিমুলেটর সেটআপ ($prayerSlug)'
                                : 'Simulator Setup ($prayerSlug)',
                            child: Text(
                              isBangla
                                  ? 'নির্বাচিত নামাজ: $prayerSlug • ইউনিট: $unitId • ধরন: $_selectedGender'
                                  : 'Selected prayer: $prayerSlug • Unit: $unitId • Gender: $_selectedGender',
                              textAlign: TextAlign.center,
                              style: tokens.typography.bodyLarge,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

/// Tab 4: Prayer Times (`সময়`) foundation screen with offline Karachi/Hanafi
/// defaults and Bangla time display.
class TimesTabScreen extends ConsumerWidget {
  /// Creates a [TimesTabScreen].
  const TimesTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = context.tokens;
    final isBangla = ref.watch(appLocaleProvider).languageCode == 'bn';

    const waqts = <({String nameBn, String nameEn, String time})>[
      (nameBn: 'ফজর', nameEn: 'Fajr', time: '04:52 AM'),
      (nameBn: 'সূর্যোদয় (নিষিদ্ধ সময়)', nameEn: 'Sunrise', time: '06:08 AM'),
      (nameBn: 'যোহর', nameEn: 'Dhuhr', time: '12:04 PM'),
      (nameBn: 'আসর (হানাফি)', nameEn: 'Asr (Hanafi)', time: '04:18 PM'),
      (nameBn: 'মাগরিব', nameEn: 'Maghrib', time: '05:58 PM'),
      (nameBn: 'এশা', nameEn: 'Isha', time: '07:16 PM'),
    ];

    return CustomScrollView(
      key: const PageStorageKey<String>('times-tab-scroll'),
      slivers: <Widget>[
        GlassSliverAppBar(
          title: l10n.tabTimes,
          subtitle: isBangla
              ? 'ঢাকা • করাচি মেথড • হানাফি আসর'
              : 'Dhaka • Karachi Method • Hanafi Asr',
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            tokens.spacing.md,
            tokens.spacing.md,
            tokens.spacing.md,
            120,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              waqts
                  .map(
                    (w) => Padding(
                      padding: EdgeInsets.only(bottom: tokens.spacing.sm),
                      child: GlassListTile(
                        leadingIcon: Icons.access_time_filled_rounded,
                        title: isBangla ? w.nameBn : w.nameEn,
                        trailing: Text(
                          BengaliNumberFormatter.formatString(
                            w.time,
                            isBangla: isBangla,
                          ),
                          style: tokens.typography.titleMedium.copyWith(
                            color: tokens.colors.primaryEmerald,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}

/// Tab 5: More (`আরও`) foundation screen with settings, glass quality override,
/// and dev-only Design System Showcase entry.
class MoreTabScreen extends ConsumerWidget {
  /// Creates a [MoreTabScreen].
  const MoreTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = context.tokens;
    final flavor = ref.watch(flavorConfigProvider);
    final glassQuality = ref.watch(glassQualityProvider);
    final locale = ref.watch(appLocaleProvider);
    final isBangla = locale.languageCode == 'bn';

    return CustomScrollView(
      key: const PageStorageKey<String>('more-tab-scroll'),
      slivers: <Widget>[
        GlassSliverAppBar(
          title: l10n.tabMore,
          subtitle: '${flavor.applicationId} (${flavor.flavor.name})',
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            tokens.spacing.md,
            tokens.spacing.md,
            tokens.spacing.md,
            120,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.glassQualityLabel,
                      style: tokens.typography.titleMedium,
                    ),
                    SizedBox(height: tokens.spacing.xs),
                    GlassSegmentedControl<GlassQuality>(
                      segments: <GlassQuality, String>{
                        GlassQuality.high: l10n.glassQualityHigh,
                        GlassQuality.medium: l10n.glassQualityMedium,
                        GlassQuality.low: l10n.glassQualityLow,
                      },
                      selectedValue: glassQuality,
                      onValueChanged: (GlassQuality q) =>
                          ref.read(glassQualityProvider.notifier).setQuality(q),
                    ),
                  ],
                ),
              ),
              SizedBox(height: tokens.spacing.md),
              GlassListTile(
                leadingIcon: Icons.language_rounded,
                title: l10n.languageLabel,
                subtitle: isBangla ? 'বাংলা (Bangla)' : 'English',
                onTap: () => ref.read(appLocaleProvider.notifier).toggleLocale(),
              ),
              SizedBox(height: tokens.spacing.sm),
              GlassListTile(
                leadingIcon: Icons.dark_mode_rounded,
                title: l10n.themeModeLabel,
                subtitle: isBangla
                    ? 'লাইট ও ডার্ক থিম পরিবর্তন করুন'
                    : 'Switch between Light and Dark theme',
                onTap: () =>
                    ref.read(appThemeModeProvider.notifier).toggleLightDark(),
              ),
              if (flavor.isDev) ...<Widget>[
                SizedBox(height: tokens.spacing.md),
                GlassListTile(
                  leadingIcon: Icons.palette_rounded,
                  title: l10n.designSystemShowcaseTitle,
                  subtitle: isBangla
                      ? 'সকল গ্লাস কম্পোনেন্ট, টোকেন এবং ৫০টি কার্ডের ৬০fps তালিকা দেখুন'
                      : 'Inspect all glass components, tokens, and 50-card 60fps stress list',
                  onTap: () => context.push('/dev/design-system'),
                ),
              ],
            ]),
          ),
        ),
      ],
    );
  }
}

/// Placeholder Prayer Detail Screen opened via Hero card tap or deep link:
/// - `musalli://namaj/<slug>`
/// - `https://namajshikkha.tashanto.com/namaj/<slug>`
class PrayerDetailPlaceholderScreen extends ConsumerWidget {
  /// Creates a [PrayerDetailPlaceholderScreen].
  const PrayerDetailPlaceholderScreen({
    required this.slug,
    super.key,
  });

  /// Canonical prayer slug (e.g. `fajr`, `dhuhr`, `witr`).
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = context.tokens;
    final isBangla = ref.watch(appLocaleProvider).languageCode == 'bn';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${l10n.prayerDetailTitle}: $slug'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(tokens.spacing.md),
          children: <Widget>[
            GlassCard(
              heroTag: 'prayer-card-$slug',
              enableBlur: true,
              borderGlow: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RulingBadge(
                        category: slug == 'witr'
                            ? RulingCategory.wajib
                            : RulingCategory.fard,
                        isBangla: isBangla,
                      ),
                      Text(
                        'slug: $slug',
                        style: tokens.typography.label,
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  Text(
                    '${l10n.prayerDetailTitle} ($slug)',
                    style: tokens.typography.titleLarge,
                  ),
                  SizedBox(height: tokens.spacing.xs),
                  Text(
                    isBangla
                        ? 'এই পৃষ্ঠাটি ডিপ লিঙ্ক (musalli://namaj/$slug বা https://namajshikkha.tashanto.com/namaj/$slug) এবং Hero ট্রানজিশন সমর্থন করে।'
                        : 'This screen supports both deep linking (musalli://namaj/$slug & Universal Links) and Hero shared-element transitions.',
                    style: tokens.typography.bodyMedium,
                  ),
                  SizedBox(height: tokens.spacing.md),
                  GlassButton(
                    label: l10n.simulatorQuickStart,
                    icon: Icons.play_circle_fill_rounded,
                    onPressed: () =>
                        context.go('/simulator?prayer=$slug&unit=fard'),
                  ),
                ],
              ),
            ),
            SizedBox(height: tokens.spacing.md),
            ArabicBlock(
              data: _sampleSana,
              isBanglaLocale: isBangla,
            ),
          ],
        ),
      ),
    );
  }
}
