import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/tracker/data/tracker_repository.dart';
import 'package:musalli/features/tracker/domain/tracker_models.dart';

class TrackerScreen extends ConsumerStatefulWidget {
  const TrackerScreen({super.key});

  @override
  ConsumerState<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends ConsumerState<TrackerScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final DateTime _selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final repo = ref.watch(trackerRepositoryProvider);

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text('নামাজ ট্র্যাকার', style: typography.titleLarge),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF10B981),
          labelColor: const Color(0xFF10B981),
          unselectedLabelColor: colors.textSecondary,
          tabs: const [
            Tab(icon: Icon(Icons.check_circle_outline), text: 'দৈনিক ট্র্যাকার'),
            Tab(icon: Icon(Icons.history_toggle_off), text: 'কাযা ক্যালকুলেটর'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: DAILY TRACKER
          StreamBuilder<DayPrayerRecord>(
            stream: repo.watchDayRecord(_selectedDate),
            builder: (context, snapshot) {
              final record = snapshot.data ?? DayPrayerRecord.empty('');
              return ListView(
                padding: EdgeInsets.all(tokens.spacing.md),
                children: [
                  // Motivation Hero Card
                  GlassCard(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0x2610B981),
                            shape: BoxShape.circle,
                          ),
                          child: const Text('🌙', style: TextStyle(fontSize: 28)),
                        ),
                        SizedBox(width: tokens.spacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('আজকের আদায়: ${BengaliNumbers.toBengali(record.completedCount)} / ৫ ফরজ', style: typography.titleMedium),
                              SizedBox(height: tokens.spacing.xxs),
                              Text(
                                record.isAllFardCompleted
                                    ? 'মাশাআল্লাহ! আজকের সকল ফরজ নামাজ সম্পন্ন হয়েছে।'
                                    : 'নামাজ জান্নাতের চাবিকাঠি — সময়মতো আদায় করুন।',
                                style: typography.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: tokens.spacing.md),

                  // Prayers List
                  _buildPrayerTile('ফজর', 'fajr', record.fajr, repo),
                  _buildPrayerTile('যোহর', 'dhuhr', record.dhuhr, repo),
                  _buildPrayerTile('আসর', 'asr', record.asr, repo),
                  _buildPrayerTile('মাগরিব', 'maghrib', record.maghrib, repo),
                  _buildPrayerTile('এশা', 'isha', record.isha, repo),
                  _buildPrayerTile('বিতর (ওয়াজিব)', 'witr', record.witr, repo),
                ],
              );
            },
          ),

          // TAB 2: QAZA CALCULATOR
          FutureBuilder<QazaRecord>(
            future: repo.getQazaRecord(),
            builder: (context, snapshot) {
              final qaza = snapshot.data ?? const QazaRecord();
              return ListView(
                padding: EdgeInsets.all(tokens.spacing.md),
                children: [
                  GlassCard(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Column(
                      children: [
                        Text('মোট অবশিষ্ট কাযা নামাজ', style: typography.bodyMedium),
                        SizedBox(height: tokens.spacing.xs),
                        Text(
                          '${BengaliNumbers.toBengali(qaza.total)} ওয়াক্ত',
                          style: typography.display.copyWith(color: const Color(0xFFF59E0B)),
                        ),
                        SizedBox(height: tokens.spacing.xs),
                        Text(
                          'প্রতিটি নামাজ আদায়ের পর নিচে আলতো চাপ দিয়ে সংখ্যা কমিয়ে নিন।',
                          style: typography.label,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: tokens.spacing.md),
                  _buildQazaCounter('ফজর কাযা', qaza.fajr, (v) {
                    repo.updateQazaRecord(QazaRecord(
                      fajr: v,
                      dhuhr: qaza.dhuhr,
                      asr: qaza.asr,
                      maghrib: qaza.maghrib,
                      isha: qaza.isha,
                      witr: qaza.witr,
                    ));
                    setState(() {});
                  }),
                  _buildQazaCounter('যোহর কাযা', qaza.dhuhr, (v) {
                    repo.updateQazaRecord(QazaRecord(
                      fajr: qaza.fajr,
                      dhuhr: v,
                      asr: qaza.asr,
                      maghrib: qaza.maghrib,
                      isha: qaza.isha,
                      witr: qaza.witr,
                    ));
                    setState(() {});
                  }),
                  _buildQazaCounter('আসর কাযা', qaza.asr, (v) {
                    repo.updateQazaRecord(QazaRecord(
                      fajr: qaza.fajr,
                      dhuhr: qaza.dhuhr,
                      asr: v,
                      maghrib: qaza.maghrib,
                      isha: qaza.isha,
                      witr: qaza.witr,
                    ));
                    setState(() {});
                  }),
                  _buildQazaCounter('মাগরিব কাযা', qaza.maghrib, (v) {
                    repo.updateQazaRecord(QazaRecord(
                      fajr: qaza.fajr,
                      dhuhr: qaza.dhuhr,
                      asr: qaza.asr,
                      maghrib: v,
                      isha: qaza.isha,
                      witr: qaza.witr,
                    ));
                    setState(() {});
                  }),
                  _buildQazaCounter('এশা কাযা', qaza.isha, (v) {
                    repo.updateQazaRecord(QazaRecord(
                      fajr: qaza.fajr,
                      dhuhr: qaza.dhuhr,
                      asr: qaza.asr,
                      maghrib: qaza.maghrib,
                      isha: v,
                      witr: qaza.witr,
                    ));
                    setState(() {});
                  }),
                  _buildQazaCounter('বিতর কাযা', qaza.witr, (v) {
                    repo.updateQazaRecord(QazaRecord(
                      fajr: qaza.fajr,
                      dhuhr: qaza.dhuhr,
                      asr: qaza.asr,
                      maghrib: qaza.maghrib,
                      isha: qaza.isha,
                      witr: v,
                    ));
                    setState(() {});
                  }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTile(String name, String key, PrayerStatus status, TrackerRepository repo) {
    final tokens = context.tokens;
    final typography = tokens.typography;

    return Padding(
      padding: EdgeInsets.only(bottom: tokens.spacing.xs),
      child: GlassCard(
        padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md, vertical: tokens.spacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Text(name, style: typography.titleMedium),
            ),
            Wrap(
              spacing: 6,
              children: PrayerStatus.values.map((s) {
                final isSelected = s == status;
                return ChoiceChip(
                  label: Text('${s.emoji} ${s.labelBn}', style: typography.label.copyWith(
                    color: isSelected ? Colors.white : tokens.colors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  )),
                  selected: isSelected,
                  selectedColor: Color(s.colorValue),
                  backgroundColor: tokens.colors.surfaceGlassTint,
                  onSelected: (val) {
                    if (val) {
                      unawaited(HapticFeedback.lightImpact());
                      repo.updatePrayerStatus(_selectedDate, key, s);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQazaCounter(String title, int count, ValueChanged<int> onCountChanged) {
    final tokens = context.tokens;
    final typography = tokens.typography;

    return Padding(
      padding: EdgeInsets.only(bottom: tokens.spacing.xs),
      child: GlassCard(
        padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md, vertical: tokens.spacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: typography.bodyLarge),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Color(0xFFEF4444)),
                  onPressed: count > 0 ? () => onCountChanged(count - 1) : null,
                ),
                Text(BengaliNumbers.toBengali(count), style: typography.titleMedium),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Color(0xFF10B981)),
                  onPressed: () => onCountChanged(count + 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

