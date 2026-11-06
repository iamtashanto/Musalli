import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';

/// Item in morning and evening adhkar checklist.
class AdhkarItem {
  const AdhkarItem({
    required this.id,
    required this.titleBn,
    required this.titleEn,
    required this.arabic,
    required this.transliterationBn,
    required this.meaningBn,
    required this.count,
    required this.reference,
    this.fazilatBn,
  });

  final String id;
  final String titleBn;
  final String titleEn;
  final String arabic;
  final String transliterationBn;
  final String meaningBn;
  final int count;
  final String reference;
  final String? fazilatBn;
}

const List<AdhkarItem> _morningAdhkar = [
  AdhkarItem(
    id: 'm_ayatul_kursi',
    titleBn: 'আয়াতুল কুরসী',
    titleEn: 'Ayatul Kursi',
    arabic:
        'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ...',
    transliterationBn:
        "আল্লাহু লা ইলাহা ইল্লা হুওয়াল হাইয়্যুল ক্বাইয়্যূম, লা তা'খুযুহু সিনাতুঁও ওয়ালা নাওম...",
    meaningBn:
        'আল্লাহ, তিনি ছাড়া কোনো উপাস্য নেই, তিনি চিরঞ্জীব, সবকিছুর ধারক। তাঁকে তন্দ্রাও স্পর্শ করে না, নিদ্রাও না...',
    count: 1,
    reference: 'সূরা আল-বাক্বারাহ: ২৫৫ • হাকিম ১/৫৬২',
    fazilatBn: 'যে ব্যক্তি সকালে এটি পড়বে সে সন্ধ্যা পর্যন্ত জিন ও শয়তান থেকে হেফাজতে থাকবে।',
  ),
  AdhkarItem(
    id: 'm_ikhlas_falaq_nas',
    titleBn: 'সূরা ইখলাস, ফালাক্ব ও নাস',
    titleEn: 'Surah Ikhlas, Falaq & Nas',
    arabic:
        'قُلْ هُوَ اللَّهُ أَحَدٌ ۝ ... قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ ... قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝',
    transliterationBn:
        'কুল হুওয়াল্লাহু আহাদ... কুল আউযু বিরাব্বিল ফালাক্ব... কুল আউযু বিরাব্বিন নাস...',
    meaningBn:
        'বলুন, তিনিই আল্লাহ এক-অদ্বিতীয়... বলুন, আমি আশ্রয় প্রার্থনা করছি উষার রবের কাছে... বলুন, আমি আশ্রয় প্রার্থনা করছি মানুষের প্রতিপালকের কাছে...',
    count: 3,
    reference: 'আবু দাউদ ৫০৮২ • তিরমিজি ৩৫৭৫',
    fazilatBn: 'সকাল ও সন্ধ্যায় ৩ বার পাঠ করলে সব অনিষ্টতা থেকে রক্ষার জন্য যথেষ্ট হয়।',
  ),
  AdhkarItem(
    id: 'm_sayyidul_istighfar',
    titleBn: 'সায়্যিদুল ইস্তিগফার (প্রধান তাওবা)',
    titleEn: 'Sayyidul Istighfar',
    arabic:
        'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
    transliterationBn:
        "আল্লাহুম্মা আনতা রব্বী লা ইলাহা ইল্লা আনতা, খালাক্বতানী ওয়া আনা আবদুকা, ওয়া আনা 'আলা 'আহদিকা ওয়া ওয়া'দিকা মাসতাত্বা'তু, আ'ঊযু বিকা মিন শাররি মা সনা'তু, আবূউ লাকা বিনি'মাতিকা 'আলাইয়্যা, ওয়া আবূউ বিযানবী ফাগফির লী, ফাইন্নাহূ লা ইয়াগফিরুয যুনূবা ইল্লা আনতা।",
    meaningBn:
        'হে আল্লাহ! আপনি আমার রব, আপনি ছাড়া সত্য কোনো উপাস্য নেই। আপনি আমাকে সৃষ্টি করেছেন এবং আমি আপনার বান্দা। আমি আমার সাধ্যানুযায়ী আপনার প্রতিশ্রুতিতে অঙ্গীকারবদ্ধ রয়েছি। আমি আমার কৃতকর্মের অনিষ্ট থেকে আপনার কাছে আশ্রয় চাই। আমার প্রতি আপনার অনুগ্রহ আমি স্বীকার করছি এবং আমার পাপও স্বীকার করছি। অতএব আমাকে ক্ষমা করে দিন, নিশ্চয় আপনি ছাড়া আর কেউ পাপ ক্ষমা করতে পারে না।',
    count: 1,
    reference: 'সহিহ বুখারি ৬৩০৬',
    fazilatBn: 'সকালে দৃঢ় বিশ্বাসের সাথে পড়ে সন্ধ্যায় পূর্বে মারা গেলে সে জান্নাতবাসী হবে।',
  ),
  AdhkarItem(
    id: 'm_asbahna',
    titleBn: 'সকালের সূচনা দোয়া',
    titleEn: 'Morning Acknowledgment',
    arabic:
        'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
    transliterationBn:
        'আসবাহনা ওয়া আসবাহাল মুলকু লিল্লাহ, ওয়াল হামদু লিল্লাহ, লা ইলাহা ইল্লাল্লাহু ওয়াহদাহু লা শারীকা লাহু, লাহুল মুলকু ওয়া লাহুল হামদু ওয়া হুওয়া আলা কুল্লি শাইয়িন ক্বাদীর।',
    meaningBn:
        'আমরা সকালে উপনীত হয়েছি এবং সমগ্র রাজত্বও সকালে আল্লাহর জন্যই উপনীত হয়েছে। সমস্ত প্রশংসা আল্লাহর। আল্লাহ ছাড়া সত্য কোনো উপাস্য নেই, তিনি একক, তাঁর কোনো শরিক নেই। রাজত্ব একমাত্র তাঁরই, সমস্ত প্রশংসাও তাঁর এবং তিনি সবকিছুর ওপর ক্ষমতাবান।',
    count: 1,
    reference: 'সহিহ মুসলিম ২৭২৩',
  ),
  AdhkarItem(
    id: 'm_bismillahil_lazi',
    titleBn: 'বিপদ-আপদ থেকে সুরক্ষার দোয়া',
    titleEn: 'Protection Supplication',
    arabic:
        'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    transliterationBn:
        "বিসমিল্লাহিল্লাযী লা ইয়াদ্বুররু মা'আসমিহী শাইয়ুন ফিল আরদ্বি ওয়ালা ফিস সামা-ই ওয়া হুয়াস সামী'উল 'আলীম।",
    meaningBn:
        'আল্লাহর নামে, যাঁর নামের বরকতে আসমান ও জমিনের কোনো কিছুই অনিষ্ট করতে পারে না; আর তিনি সর্বশ্রোতা, সর্বজ্ঞাতা।',
    count: 3,
    reference: 'আবু দাউদ ৫০৮৮ • তিরমিজি ৩৩৮৮',
    fazilatBn: 'সকালে ৩ বার পড়লে সন্ধ্যা পর্যন্ত কোনো আকস্মিক বিপদ আসবে না।',
  ),
];

const List<AdhkarItem> _eveningAdhkar = [
  AdhkarItem(
    id: 'e_ayatul_kursi',
    titleBn: 'আয়াতুল কুরসী',
    titleEn: 'Ayatul Kursi',
    arabic:
        'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ...',
    transliterationBn:
        'আল্লাহু লা ইলাহা ইল্লা হুওয়াল হাইয়্যুল ক্বাইয়্যূম...',
    meaningBn:
        'আল্লাহ, তিনি ছাড়া কোনো উপাস্য নেই, তিনি চিরঞ্জীব...',
    count: 1,
    reference: 'সূরা আল-বাক্বারাহ: ২৫৫ • হাকিম ১/৫৬২',
    fazilatBn: 'যে ব্যক্তি সন্ধ্যায় এটি পড়বে সে সকাল পর্যন্ত জিন ও শয়তান থেকে হেফাজতে থাকবে।',
  ),
  AdhkarItem(
    id: 'e_sayyidul_istighfar',
    titleBn: 'সায়্যিদুল ইস্তিগফার (প্রধান তাওবা)',
    titleEn: 'Sayyidul Istighfar',
    arabic:
        'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ...',
    transliterationBn:
        'আল্লাহুম্মা আনতা রব্বী লা ইলাহা ইল্লা আনতা...',
    meaningBn:
        'হে আল্লাহ! আপনি আমার রব, আপনি ছাড়া সত্য কোনো উপাস্য নেই...',
    count: 1,
    reference: 'সহিহ বুখারি ৬৩০৬',
    fazilatBn: 'সন্ধ্যায় দৃঢ় বিশ্বাসের সাথে পড়ে সকালের পূর্বে মারা গেলে সে জান্নাতবাসী হবে।',
  ),
  AdhkarItem(
    id: 'e_amsaina',
    titleBn: 'সন্ধ্যার সূচনা দোয়া',
    titleEn: 'Evening Acknowledgment',
    arabic:
        'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
    transliterationBn:
        'আমসাইনা ওয়া আমসাল মুলকু লিল্লাহ, ওয়াল হামদু লিল্লাহ, লা ইলাহা ইল্লাল্লাহু ওয়াহদাহু লা শারীকা লাহু...',
    meaningBn:
        'আমরা সন্ধ্যায় উপনীত হয়েছি এবং সমগ্র রাজত্বও সন্ধ্যায় আল্লাহর জন্যই উপনীত হয়েছে...',
    count: 1,
    reference: 'সহিহ মুসলিম ২৭২৩',
  ),
  AdhkarItem(
    id: 'e_bismillahil_lazi',
    titleBn: 'বিপদ-আপদ থেকে সুরক্ষার দোয়া',
    titleEn: 'Protection Supplication',
    arabic:
        'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    transliterationBn:
        "বিসমিল্লাহিল্লাযী লা ইয়াদ্বুররু মা'আসমিহী শাইয়ুন ফিল আরদ্বি ওয়ালা ফিস সামা-ই ওয়া হুয়াস সামী'উল 'আলীম।",
    meaningBn:
        'আল্লাহর নামে, যাঁর নামের বরকতে আসমান ও জমিনের কোনো কিছুই অনিষ্ট করতে পারে না; আর তিনি সর্বশ্রোতা, সর্বজ্ঞাতা।',
    count: 3,
    reference: 'আবু দাউদ ৫০৮৮ • তিরমিজি ৩৩৮৮',
  ),
  AdhkarItem(
    id: 'e_audhu_bikalimatillah',
    titleBn: 'বিষাক্ত প্রাণী ও অনিষ্ট থেকে রক্ষার দোয়া',
    titleEn: 'Protection from Harmful Creatures',
    arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
    transliterationBn: "আ'ঊযু বিকালিমা-তিল্লাহিত তা-ম্মা-তি মিন শাররি মা খালাক্বা।",
    meaningBn: 'আমি আল্লাহর নিখুঁত বাণীর মাধ্যমে তাঁর সৃষ্টির যাবতীয় অনিষ্ট থেকে আশ্রয় চাইছি।',
    count: 3,
    reference: 'সহিহ মুসলিম ২৭০৯',
    fazilatBn: 'সন্ধ্যায় ৩ বার পাঠ করলে রাতে কোনো বিষাক্ত কীট-পতঙ্গ ক্ষতি করতে পারবে না।',
  ),
];

class AdhkarScreen extends ConsumerStatefulWidget {
  const AdhkarScreen({super.key});

  @override
  ConsumerState<AdhkarScreen> createState() => _AdhkarScreenState();
}

class _AdhkarScreenState extends ConsumerState<AdhkarScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final Map<String, int> _completedCounts = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _increment(AdhkarItem item) {
    HapticFeedback.lightImpact();
    setState(() {
      final current = _completedCounts[item.id] ?? 0;
      if (current < item.count) {
        _completedCounts[item.id] = current + 1;
      }
    });
  }

  void _resetAll() {
    HapticFeedback.mediumImpact();
    setState(_completedCounts.clear);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Scaffold(
      backgroundColor: tokens.colors.backgroundStart,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'সকাল ও সন্ধ্যার আজকার',
          style: tokens.typography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'রিসেট করুন',
            icon: Icon(Icons.refresh_rounded, color: tokens.colors.textPrimary),
            onPressed: _resetAll,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: tokens.colors.primaryEmerald,
          labelColor: tokens.colors.primaryEmerald,
          unselectedLabelColor: tokens.colors.textSecondary,
          labelStyle: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: '🌅 সকালের আজকার'),
            Tab(text: '🌇 সন্ধ্যার আজকার'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(_morningAdhkar),
          _buildList(_eveningAdhkar),
        ],
      ),
    );
  }

  Widget _buildList(List<AdhkarItem> items) {
    final tokens = context.tokens;
    return ListView.builder(
      padding: EdgeInsets.all(tokens.spacing.md),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final done = _completedCounts[item.id] ?? 0;
        final isCompleted = done >= item.count;

        return Padding(
          padding: EdgeInsets.only(bottom: tokens.spacing.md),
          child: GlassCard(
            enableBlur: true,
            borderGlow: isCompleted,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.titleBn,
                        style: tokens.typography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isCompleted
                              ? tokens.colors.primaryEmerald
                              : tokens.colors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: tokens.spacing.sm,
                        vertical: tokens.spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? tokens.colors.primaryEmerald.withAlpha(51)
                            : tokens.colors.surfaceGlassTint,
                        borderRadius: BorderRadius.circular(tokens.radii.full),
                        border: Border.all(
                          color: isCompleted
                              ? tokens.colors.primaryEmerald
                              : tokens.colors.borderSubtle,
                        ),
                      ),
                      child: Text(
                        '${BengaliNumberFormatter.toBengali(done)} / ${BengaliNumberFormatter.toBengali(item.count)} বার',
                        style: tokens.typography.label.copyWith(
                          color: isCompleted
                              ? tokens.colors.primaryEmerald
                              : tokens.colors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacing.md),
                Text(
                  item.arabic,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: tokens.typography.arabicLarge.copyWith(
                    color: tokens.colors.textPrimary,
                    height: 1.8,
                  ),
                ),
                SizedBox(height: tokens.spacing.sm),
                Text(
                  item.transliterationBn,
                  style: tokens.typography.bodyMedium.copyWith(
                    color: tokens.colors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  item.meaningBn,
                  style: tokens.typography.bodyMedium.copyWith(
                    color: tokens.colors.textPrimary,
                  ),
                ),
                if (item.fazilatBn != null) ...[
                  SizedBox(height: tokens.spacing.sm),
                  Container(
                    padding: EdgeInsets.all(tokens.spacing.sm),
                    decoration: BoxDecoration(
                      color: tokens.colors.primaryEmerald.withAlpha(20),
                      borderRadius: BorderRadius.circular(tokens.radii.sm),
                    ),
                    child: Text(
                      'ফজিলত: ${item.fazilatBn!}',
                      style: tokens.typography.label.copyWith(
                        color: tokens.colors.primaryEmerald,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'রেফারেন্স: ${item.reference}',
                  style: tokens.typography.label.copyWith(
                    color: tokens.colors.textSecondary,
                  ),
                ),
                SizedBox(height: tokens.spacing.md),
                GlassButton(
                  label: isCompleted
                      ? 'সম্পূর্ণ হয়েছে ✅'
                      : 'পড়েছি (${BengaliNumberFormatter.toBengali(done + 1)}/${BengaliNumberFormatter.toBengali(item.count)})',
                  icon: isCompleted ? Icons.check_circle : Icons.touch_app_rounded,
                  onPressed: isCompleted ? null : () => _increment(item),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
