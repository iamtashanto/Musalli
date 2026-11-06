import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';

class IslamicEvent {
  const IslamicEvent({
    required this.hijriMonth,
    required this.hijriDay,
    required this.nameBn,
    required this.descriptionBn,
  });

  final String hijriMonth;
  final int hijriDay;
  final String nameBn;
  final String descriptionBn;
}

const List<IslamicEvent> _bangladeshIslamicEvents = [
  IslamicEvent(
    hijriMonth: 'মুহাররম',
    hijriDay: 1,
    nameBn: 'হিজরি নববর্ষ (১লা মুহাররম)',
    descriptionBn: 'ইসলামিক চান্দ্রবর্ষের সূচনা ও সম্মানজনক চার মাসের অন্যতম।',
  ),
  IslamicEvent(
    hijriMonth: 'মুহাররম',
    hijriDay: 10,
    nameBn: 'পবিত্র আশুরা',
    descriptionBn: 'মুসা (আ.)-এর ফেরাউন থেকে নাজাত ও কারবালার ঐতিহাসিক শাহাদাত। ৯ ও ১০ বা ১০ ও ১১ই মুহাররম রোজা রাখা সুন্নত।',
  ),
  IslamicEvent(
    hijriMonth: 'রবিউল আউয়াল',
    hijriDay: 12,
    nameBn: 'ঈদে মিলাদুন্নবী (সা.)',
    descriptionBn: 'নবীজি হযরত মুহাম্মদ (সা.)-এর পৃথিবীতে শুভাগমন ও ওফাত দিবস।',
  ),
  IslamicEvent(
    hijriMonth: 'রজব',
    hijriDay: 27,
    nameBn: 'পবিত্র শবে মেরাজ (লাইলাতুল মেরাজ)',
    descriptionBn: 'নবীজি (সা.)-এর ঊর্ধ্বাকাশে ভ্রমণ ও উম্মতের জন্য পাঁচ ওয়াক্ত নামাজ উপহার হিসেবে প্রাপ্তি।',
  ),
  IslamicEvent(
    hijriMonth: 'শা\'বান',
    hijriDay: 15,
    nameBn: 'পবিত্র শবে বরাত (লাইলাতুল বারাআত)',
    descriptionBn: 'অর্ধ-শাবানের ফজিলতপূর্ণ রাত। তওবা, মাগফিরাত ও নফল ইবাদতের বিশেষ সময়।',
  ),
  IslamicEvent(
    hijriMonth: 'রমজান',
    hijriDay: 1,
    nameBn: 'রমজানুল মোবারকের সূচনা',
    descriptionBn: 'ফরজ রোজা, খতমে তারাবীহ ও কুরআন নাজিলের মহিমান্বিত মাস।',
  ),
  IslamicEvent(
    hijriMonth: 'রমজান',
    hijriDay: 27,
    nameBn: 'পবিত্র শবে কদর (লাইলাতুল কদর)',
    descriptionBn: 'হাজার মাসের চেয়ে উত্তম রজনী। শেষ দশকের বেজোড় রাতে ইবাদতের বিশেষ তাগিদ।',
  ),
  IslamicEvent(
    hijriMonth: 'শাওয়াল',
    hijriDay: 1,
    nameBn: 'পবিত্র ঈদুল ফিতর',
    descriptionBn: 'রোজাদারদের মহা আনন্দের দিন, ফিতরা আদায় ও ঈদের নামাজ। শাওয়ালের ৬ রোজা মুস্তাহাব।',
  ),
  IslamicEvent(
    hijriMonth: 'জিলহজ্জ',
    hijriDay: 9,
    nameBn: 'পবিত্র ইয়াওমে আরাফা (হজ্জ দিবস)',
    descriptionBn: 'হাজীদের আরাফাতের ময়দানে অবস্থান। অ-হাজীদের জন্য এই দিনে রোজা রাখা দুই বছরের গুনাহ মাফের উসিলা।',
  ),
  IslamicEvent(
    hijriMonth: 'জিলহজ্জ',
    hijriDay: 10,
    nameBn: 'পবিত্র ঈদুল আজহা (কোরবানি)',
    descriptionBn: 'হযরত ইব্রাহিম (আ.)-এর ত্যাগ ও আল্লাহর উদ্দেশ্যে কোরবানি। তাকবীরে তাশরিক পাঠ ওয়াজিব (৯ই জিলহজ্জ ফজর থেকে ১৩ই আসর পর্যন্ত)।',
  ),
];

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  int _hijriAdjustmentDays = 0; // Manual ±1 or ±2 adjustment for moon sighting in BD

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: tokens.colors.backgroundStart,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'হিজরি ক্যালেন্ডার ও দিনপঞ্জি',
          style: tokens.typography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.md),
        children: [
          // Current Hijri Date Card with Adjustment
          GlassCard(
            enableBlur: true,
            borderGlow: true,
            child: Column(
              children: [
                Text(
                  'আজকের আনুমানিক হিজরি তারিখ',
                  style: tokens.typography.label.copyWith(color: tokens.colors.textSecondary),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  _getFormattedHijriDate(now, _hijriAdjustmentDays),
                  style: tokens.typography.display.copyWith(
                    color: tokens.colors.primaryEmerald,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'ইংরেজি: ${BengaliNumberFormatter.toBengali(now.day)}/${BengaliNumberFormatter.toBengali(now.month)}/${BengaliNumberFormatter.toBengali(now.year)} খ্রিষ্টাব্দ',
                  style: tokens.typography.bodyMedium.copyWith(color: tokens.colors.textSecondary),
                ),
                SizedBox(height: tokens.spacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'চাঁদ দেখা সমন্বয়:',
                      style: tokens.typography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: tokens.spacing.sm),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 20,
                      onPressed: () => setState(() => _hijriAdjustmentDays--),
                    ),
                    Text(
                      '${_hijriAdjustmentDays >= 0 ? "+" : ""}${BengaliNumberFormatter.toBengali(_hijriAdjustmentDays)} দিন',
                      style: tokens.typography.bodyMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 20,
                      onPressed: () => setState(() => _hijriAdjustmentDays++),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),
          Text(
            'বাংলাদেশ ইসলামিক দিবস ও ঘটনাবলি',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          ..._bangladeshIslamicEvents.map(
            (event) => Padding(
              padding: EdgeInsets.only(bottom: tokens.spacing.sm),
              child: GlassCard(
                enableBlur: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            event.nameBn,
                            style: tokens.typography.titleSmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: tokens.colors.primaryEmerald,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: tokens.spacing.sm,
                            vertical: tokens.spacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: tokens.colors.surfaceGlassTint,
                            borderRadius: BorderRadius.circular(tokens.radii.full),
                            border: Border.all(color: tokens.colors.borderSubtle),
                          ),
                          child: Text(
                            '${BengaliNumberFormatter.toBengali(event.hijriDay)} ${event.hijriMonth}',
                            style: tokens.typography.label.copyWith(
                              color: tokens.colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: tokens.spacing.xs),
                    Text(
                      event.descriptionBn,
                      style: tokens.typography.bodyMedium.copyWith(
                        color: tokens.colors.textPrimary,
                        height: 1.4,
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

  String _getFormattedHijriDate(DateTime date, int adjustDays) {
    final adjusted = date.add(Duration(days: adjustDays));
    // Approximate Umm al-Qura calculation based on astronomical epoch
    // Reference epoch: 1 Muharram 1445 AH = July 19, 2023
    final baseDate = DateTime(2023, 7, 19);
    final daysDifference = adjusted.difference(baseDate).inDays;
    
    // Average synodic month is 29.530588 days
    const synodicMonth = 29.530588;
    final totalMonths = (daysDifference / synodicMonth).floor();
    final currentYear = 1445 + (totalMonths / 12).floor();
    final monthIndex = (totalMonths % 12 + 12) % 12;
    
    // Approximate day in current lunar month
    final daysIntoMonth = (daysDifference - (totalMonths * synodicMonth)).round() + 1;
    final day = daysIntoMonth.clamp(1, 30);

    const hijriMonthsBn = [
      'মুহাররম',
      'সফর',
      'রবিউল আউয়াল',
      'রবিউস সানি',
      'জমাদিউল আউয়াল',
      'জমাদিউস সানি',
      'রজব',
      'শা\'বান',
      'রমজান',
      'শাওয়াল',
      'জিলক্বদ',
      'জিলহজ্জ',
    ];

    final monthName = hijriMonthsBn[monthIndex];
    return '${BengaliNumberFormatter.toBengali(day)} $monthName, ${BengaliNumberFormatter.toBengali(currentYear)} হিজরি';
  }
}
