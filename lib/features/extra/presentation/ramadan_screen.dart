import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/times/presentation/providers/times_providers.dart';

class RamadanScreen extends ConsumerStatefulWidget {
  const RamadanScreen({super.key});

  @override
  ConsumerState<RamadanScreen> createState() => _RamadanScreenState();
}

class _RamadanScreenState extends ConsumerState<RamadanScreen> {
  Timer? _timer;
  DateTime _now = DateTime.now();
  final Set<int> _fastingDays = {};
  final Set<int> _tarawihDays = {};

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final schedule = ref.watch(todayScheduleProvider);

    return Scaffold(
      backgroundColor: tokens.colors.backgroundStart,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'রমজান স্পেশাল',
          style: tokens.typography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.md),
        children: [
          // Sehri & Iftar Live Banner
          Builder(
            builder: (context) {
              final fajr = schedule.fajr;
              // Sehri ends 5 minutes before Fajr as safety precaution (Imsak)
              final sehriEnd = fajr.subtract(const Duration(minutes: 5));
              final maghrib = schedule.maghrib;

              final isBeforeSehri = _now.isBefore(sehriEnd);
              final isFasting = _now.isAfter(sehriEnd) && _now.isBefore(maghrib);

              final targetTime = isBeforeSehri
                  ? sehriEnd
                  : (isFasting ? maghrib : sehriEnd.add(const Duration(days: 1)));
              final diff = targetTime.difference(_now);

              final hours = diff.inHours;
              final minutes = diff.inMinutes % 60;
              final seconds = diff.inSeconds % 60;

              final statusLabel = isBeforeSehri
                  ? 'সাহরির সময় বাকি'
                  : (isFasting ? 'ইফতারের সময় বাকি' : 'আগামী সাহরির সময় বাকি');

              return GlassCard(
                enableBlur: true,
                borderGlow: true,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isFasting ? Icons.wb_twilight_rounded : Icons.nightlight_round,
                          color: tokens.colors.primaryEmerald,
                          size: 24,
                        ),
                        SizedBox(width: tokens.spacing.xs),
                        Text(
                          statusLabel,
                          style: tokens.typography.titleMedium.copyWith(
                            color: tokens.colors.primaryEmerald,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: tokens.spacing.sm),
                    Text(
                      '${BengaliNumberFormatter.toBengali(hours.toString().padLeft(2, '0'))} ঘণ্টা ${BengaliNumberFormatter.toBengali(minutes.toString().padLeft(2, '0'))} মি. ${BengaliNumberFormatter.toBengali(seconds.toString().padLeft(2, '0'))} সে.',
                      style: tokens.typography.display.copyWith(
                        fontWeight: FontWeight.w800,
                        color: tokens.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: tokens.spacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'আজকের সাহরি শেষ',
                              style: tokens.typography.label.copyWith(color: tokens.colors.textSecondary),
                            ),
                            SizedBox(height: tokens.spacing.xs),
                            Text(
                              _formatTime(sehriEnd),
                              style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 36,
                          color: tokens.colors.borderSubtle,
                        ),
                        Column(
                          children: [
                            Text(
                              'আজকের ইফতার',
                              style: tokens.typography.label.copyWith(color: tokens.colors.textSecondary),
                            ),
                            SizedBox(height: tokens.spacing.xs),
                            Text(
                              _formatTime(maghrib),
                              style: tokens.typography.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: tokens.colors.primaryEmerald,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: tokens.spacing.lg),

          // Ramadan Duas
          Text(
            'রমজানের দোয়া',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          GlassCard(
            enableBlur: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'ইফতারের দোয়া',
                  style: tokens.typography.titleMedium.copyWith(
                    color: tokens.colors.primaryEmerald,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'ذَهَبَ الظَّمَأُ وَابْتَلَّتِ الْعُرُوقُ وَثَبَتَ الأَجْرُ إِنْ شَاءَ اللَّهُ',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: tokens.typography.arabicBody.copyWith(fontSize: 20),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'জাহাবাজ জামা-উ, ওয়াবতাল্লাতিল উরূকু, ওয়া ছাবাতাল আজরু ইনশাআল্লাহ।',
                  style: tokens.typography.label.copyWith(color: tokens.colors.textSecondary, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'অর্থ: পিপাসা দূরীভূত হয়েছে, শিরা-উপশিরা সিক্ত হয়েছে এবং ইনশাআল্লাহ প্রতিদান নিশ্চিত হয়েছে। (আবু দাউদ ২৩৫৭)',
                  style: tokens.typography.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(height: tokens.spacing.sm),

          GlassCard(
            enableBlur: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'লাইলাতুল কদরের দোয়া',
                  style: tokens.typography.titleMedium.copyWith(
                    color: tokens.colors.primaryEmerald,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: tokens.typography.arabicBody.copyWith(fontSize: 20),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'আল্লাহুম্মা ইন্নাকা আফুওয়ুন তুহিব্বুল আফওয়া ফা\'ফু আন্নী।',
                  style: tokens.typography.label.copyWith(color: tokens.colors.textSecondary, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  'অর্থ: হে আল্লাহ! নিশ্চয় আপনি ক্ষমাশীল, আপনি ক্ষমা করতে ভালোবাসেন। অতএব আমাকে ক্ষমা করে দিন। (তিরমিজি ৩৫১৩)',
                  style: tokens.typography.bodyMedium,
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Roza & Tarawih 30-Day Checkgrid
          Text(
            '৩০ দিনের রোজা ও তারাবীহ ট্র্যাকার',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.xs),
          Text(
            'প্রতিটি দিনে ট্যাপ করে রোজা ও তারাবীহ আদায় চিহ্নিত করুন',
            style: tokens.typography.label.copyWith(color: tokens.colors.textSecondary),
          ),
          SizedBox(height: tokens.spacing.md),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              final day = index + 1;
              final isFasted = _fastingDays.contains(day);
              final isTarawih = _tarawihDays.contains(day);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (!isFasted) {
                      _fastingDays.add(day);
                    } else if (!isTarawih) {
                      _tarawihDays.add(day);
                    } else {
                      _fastingDays.remove(day);
                      _tarawihDays.remove(day);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isFasted
                        ? tokens.colors.primaryEmerald.withAlpha(50)
                        : tokens.colors.surfaceGlassTint,
                    borderRadius: BorderRadius.circular(tokens.radii.sm),
                    border: Border.all(
                      color: isFasted
                          ? tokens.colors.primaryEmerald
                          : tokens.colors.borderSubtle,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        BengaliNumberFormatter.toBengali(day),
                        style: tokens.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isFasted ? tokens.colors.primaryEmerald : tokens.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isFasted ? Icons.check_circle : Icons.circle_outlined,
                            size: 10,
                            color: isFasted ? tokens.colors.primaryEmerald : tokens.colors.textSecondary,
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            isTarawih ? Icons.star : Icons.star_border,
                            size: 10,
                            color: isTarawih ? Colors.amber : tokens.colors.textSecondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: tokens.spacing.xl),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final ampm = time.hour >= 12 ? 'বিকাল/সন্ধ্যা' : 'সকাল/ভোর';
    return '${BengaliNumberFormatter.toBengali(hour)}:${BengaliNumberFormatter.toBengali(minute)} ($ampm)';
  }
}
