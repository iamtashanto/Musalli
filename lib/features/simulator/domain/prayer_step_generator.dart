import 'package:musalli/shared/content/content.dart';

/// Single visual and instructional step within a generated prayer guide.
class GeneratedPrayerStep {
  const GeneratedPrayerStep({
    required this.id,
    required this.rakat,
    required this.postureName,
    required this.instructionBn,
    this.maleRule,
    this.femaleRule,
    this.recitationId,
    this.recitationTitle,
    this.tasbihCount,
  });

  final String id;
  final int? rakat;
  final String postureName;
  final String instructionBn;
  final String? maleRule;
  final String? femaleRule;
  final String? recitationId;
  final String? recitationTitle;
  final int? tasbihCount;
}

/// Generated rakat container grouping steps for collapsible UI.
class GeneratedRakatGroup {
  const GeneratedRakatGroup({
    required this.rakatNumber,
    required this.labelBn,
    required this.steps,
    this.isIdenticalToPrevious = false,
  });

  final int rakatNumber;
  final String labelBn;
  final List<GeneratedPrayerStep> steps;
  final bool isIdenticalToPrevious;
}

/// Algorithmic step generator that transforms any [ContentSalahConfig] into
/// ordered, liturgical prayer steps according to the Hanafi school.
class PrayerStepGenerator {
  const PrayerStepGenerator();

  /// Builds grouped rakat steps for a prayer unit.
  List<GeneratedRakatGroup> generateRakatGroups(
    ContentSalahConfig config, {
    required bool isMale,
  }) {
    if (config.isJanaza) {
      return [
        GeneratedRakatGroup(
          rakatNumber: 1,
          labelBn: 'জানাযার ৪ তাকবীর (দাঁড়ানো অবস্থা)',
          steps: [
            GeneratedPrayerStep(
              id: 'janaza-1',
              rakat: null,
              postureName: '১ম তাকবীর ও ছানা',
              instructionBn: 'কিবলামুখী হয়ে দাঁড়িয়ে তাকবীরে তাহরীমা বলে হাত বাঁধুন এবং জানাজার বিশেষ ছানা পাঠ করুন।',
              maleRule: isMale
                  ? 'কান পর্যন্ত হাত তুলে নাভির নিচে হাত বাঁধুন।'
                  : null,
              femaleRule: !isMale
                  ? 'কাঁধ পর্যন্ত হাত তুলে বুকের উপর হাত বাঁধুন।'
                  : null,
              recitationId: 'dua-janaza-sana',
              recitationTitle: 'জানাজার ছানা',
            ),
            const GeneratedPrayerStep(
              id: 'janaza-2',
              rakat: null,
              postureName: '২য় তাকবীর ও দরূদ শরীফ',
              instructionBn:
                  'হাত না উঠিয়ে দ্বিতীয় তাকবীর বলে দরূদে ইব্রাহিম পাঠ করুন।',
              recitationId: 'dua-durood',
              recitationTitle: 'দরূদে ইব্রাহিম',
            ),
            const GeneratedPrayerStep(
              id: 'janaza-3',
              rakat: null,
              postureName: '৩য় তাকবীর ও জানাজার দোয়া',
              instructionBn: 'তৃতীয় তাকবীর বলে মাইয়্যিতের মাগফিরাতের জন্য মাসনূন দোয়া পাঠ করুন।',
              recitationId: 'dua-janaza',
              recitationTitle: 'জানাজার দোয়া',
            ),
            const GeneratedPrayerStep(
              id: 'janaza-4',
              rakat: null,
              postureName: '৪র্থ তাকবীর ও সালাম',
              instructionBn: 'চতুর্থ তাকবীর বলে উভয় কাঁধে সালাম ফিরিয়ে নামাজ সম্পন্ন করুন।',
              recitationId: 'dua-salam',
              recitationTitle: 'সালাম',
            ),
          ],
        ),
      ];
    }

    final groups = <GeneratedRakatGroup>[];
    final totalRakats = config.rakats;

    for (int r = 1; r <= totalRakats; r++) {
      final steps = <GeneratedPrayerStep>[];
      final isFirstRakat = r == 1;
      final isLastRakat = r == totalRakats;
      final hasSitting = r == config.firstSittingAfter || isLastRakat;
      final hasQirat = config.qiratRakats.contains(r);
      final hasQunutInThisRakat =
          config.hasQunut?.enabled == true && config.hasQunut?.rakat == r;

      if (isFirstRakat) {
        steps.add(
          GeneratedPrayerStep(
            id: 'r$r-takbir',
            rakat: r,
            postureName: 'তাকবীরে তাহরীমা ও হাত বাঁধা',
            instructionBn: 'কিবলামুখী হয়ে দাঁড়িয়ে নিয়্যত করে "আল্লাহু আকবার" বলে হাত বাঁধুন।',
            maleRule: isMale
                ? 'দুই হাত কানের লতি পর্যন্ত তুলুন এবং নাভির নিচে হাত বাঁধুন।'
                : null,
            femaleRule: !isMale
                ? 'দুই হাত কাঁধ বা বুক পর্যন্ত তুলুন এবং বুকের উপর হাত বাঁধুন।'
                : null,
            recitationId: 'takbir',
            recitationTitle: 'আল্লাহু আকবার',
          ),
        );
        steps.add(
          const GeneratedPrayerStep(
            id: 'r1-sana',
            rakat: 1,
            postureName: 'সানা পাঠ',
            instructionBn: 'নীরবে সানা (ছানা) পাঠ করুন।',
            recitationId: 'dua-sana',
            recitationTitle: 'সানা',
          ),
        );
      } else {
        steps.add(
          GeneratedPrayerStep(
            id: 'r$r-qiyam-start',
            rakat: r,
            postureName: 'দাঁড়ানো (কিয়াম)',
            instructionBn:
                'সিজদা থেকে সোজা হয়ে দাঁড়িয়ে হাত বেঁধে কিয়ামে স্থির হোন।',
          ),
        );
      }

      // Qiyam & Surahs
      steps.add(
        GeneratedPrayerStep(
          id: 'r$r-fatiha',
          rakat: r,
          postureName: 'সূরা আল-ফাতিহা',
          instructionBn: "তা'আউউজ ও তাসমিয়াহ পড়ে সূরা আল-ফাতিহা তিলাওয়াত করুন এবং শেষে আমীন বলুন।",
          recitationId: 'surah-1',
          recitationTitle: 'সূরা আল-ফাতিহা',
        ),
      );

      if (hasQirat) {
        steps.add(
          GeneratedPrayerStep(
            id: 'r$r-surah',
            rakat: r,
            postureName: 'অন্য সূরা মেলানো',
            instructionBn: 'সূরা ফাতিহার পর কুরআন মাজীদ থেকে অন্য একটি সূরা বা কমপক্ষে ৩টি ছোট আয়াত মিলান।',
            recitationId: 'surah-112',
            recitationTitle: 'সূরা আল-ইখলাস (বা অন্য সূরা)',
          ),
        );
      }

      if (hasQunutInThisRakat) {
        steps.add(
          GeneratedPrayerStep(
            id: 'r$r-qunut-takbir',
            rakat: r,
            postureName: 'কুনুতের তাকবীর ও হাত তোলা',
            instructionBn: 'সূরা শেষ করে "আল্লাহু আকবার" বলে কান পর্যন্ত হাত তুলে আবার হাত বাঁধুন এবং দোয়া কুনুত পড়ুন।',
            recitationId: 'dua-qunut',
            recitationTitle: 'দোয়া কুনুত',
          ),
        );
      }

      // Ruku
      steps.add(
        GeneratedPrayerStep(
          id: 'r$r-ruku',
          rakat: r,
          postureName: 'রুকু',
          instructionBn: '"আল্লাহু আকবার" বলে রুকুতে যান এবং কমপক্ষে ৩ বার রুকুর তাসবীহ পাঠ করুন।',
          maleRule: isMale
              ? 'পিঠ সমান্তরাল সোজা রাখুন এবং দুই হাতের আঙুল ছড়িয়ে হাঁটু আঁকড়ে ধরুন।'
              : null,
          femaleRule: !isMale
              ? 'সামান্য ঝুঁকুন যেন হাত হাঁটু পর্যন্ত পৌঁছায়, আঙুল মিলিয়ে রাখুন।'
              : null,
          recitationId: 'dua-ruku',
          recitationTitle: 'রুকুর তাসবীহ (সুবহানা রাব্বিয়াল আজীম)',
          tasbihCount: 3,
        ),
      );

      // Qawmah
      steps.add(
        GeneratedPrayerStep(
          id: 'r$r-qawmah',
          rakat: r,
          postureName: 'কাওমা (রুকু হতে সোজা হয়ে দাঁড়ানো)',
          instructionBn: '"সামি\'আল্লাহু লিমান হামিদাহ" বলে সোজা হয়ে দাঁড়িয়ে "রাব্বানা লাকাল হামদ" বলুন।',
          recitationId: 'dua-qawmah',
          recitationTitle: 'রাব্বানা লাকাল হামদ',
        ),
      );

      // Sajda 1
      steps.add(
        GeneratedPrayerStep(
          id: 'r$r-sajda-1',
          rakat: r,
          postureName: '১ম সিজদা',
          instructionBn: '"আল্লাহু আকবার" বলে প্রথমে হাঁটু, তারপর হাত, নাক ও কপাল মাটিতে রেখে ৩ বার তাসবীহ পড়ুন।',
          maleRule: isMale
              ? 'পেট উরু থেকে এবং বাহু মাটি থেকে ফাঁকা রেখে সিজদা করুন।'
              : null,
          femaleRule: !isMale
              ? 'জড়োসড়ো হয়ে বাহু মাটিতে এবং পেট উরুর সাথে মিলিয়ে সিজদা করুন।'
              : null,
          recitationId: 'dua-sajda',
          recitationTitle: "সিজদার তাসবীহ (সুবহানা রাব্বিয়াল আ'লা)",
          tasbihCount: 3,
        ),
      );

      // Jalsah
      steps.add(
        GeneratedPrayerStep(
          id: 'r$r-jalsah',
          rakat: r,
          postureName: 'জলসা (দুই সিজদার মধ্যবর্তী বৈঠক)',
          instructionBn: '"আল্লাহু আকবার" বলে সোজা হয়ে বসুন এবং স্থির হয়ে বসার দোয়া পাঠ করুন।',
          recitationId: 'dua-jalsah',
          recitationTitle: 'আল্লাহুম্মাগফিরলী',
        ),
      );

      // Sajda 2
      steps.add(
        GeneratedPrayerStep(
          id: 'r$r-sajda-2',
          rakat: r,
          postureName: '২য় সিজদা',
          instructionBn: '"আল্লাহু আকবার" বলে দ্বিতীয় সিজদায় যান এবং ৩ বার তাসবীহ পাঠ করুন।',
          recitationId: 'dua-sajda',
          recitationTitle: 'সিজদার তাসবীহ',
          tasbihCount: 3,
        ),
      );

      // Sitting
      if (hasSitting) {
        if (!isLastRakat) {
          steps.add(
            GeneratedPrayerStep(
              id: 'r$r-qaada-ula',
              rakat: r,
              postureName: 'প্রথম বৈঠক (ক্বায়দায়ে উলা)',
              instructionBn: 'শান্তভাবে বসে তাশাহহুদ (আত্তাহিয়্যাতু) পাঠ করুন। "আশহাদু আল লা ইলাহা" বলার সময় শাহাদাত আঙুল তুলুন।',
              maleRule: isMale
                  ? 'বাম পা বিছিয়ে তার উপর বসুন এবং ডান পা খাড়া রাখুন।'
                  : null,
              femaleRule: !isMale
                  ? 'উভয় পা ডান দিকে বের করে মাটির উপর বসুন (তাওয়াররুক)।'
                  : null,
              recitationId: 'dua-tashahhud',
              recitationTitle: 'তাশাহহুদ (আত্তাহিয়্যাতু)',
            ),
          );
        } else {
          steps.add(
            GeneratedPrayerStep(
              id: 'r$r-qaada-akhira',
              rakat: r,
              postureName: 'শেষ বৈঠক (ক্বায়দায়ে আখিরা)',
              instructionBn: 'তাশাহহুদ পাঠ করুন, এরপর দরূদে ইব্রাহিম এবং দোয়ায়ে মাছুরা পাঠ করুন।',
              recitationId: 'dua-durood',
              recitationTitle: 'তাশাহহুদ, দরূদ ও দোয়া মাছুরা',
            ),
          );

          if (config.endsWithSalam) {
            steps.add(
              GeneratedPrayerStep(
                id: 'r$r-salam',
                rakat: r,
                postureName: 'সালাম ফেরানো',
                instructionBn: 'প্রথমে ডান দিকে মুখ ফিরিয়ে "আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ" বলুন, অতঃপর বাম দিকে সালাম ফিরিয়ে নামাজ সমাপ্ত করুন।',
                recitationId: 'dua-salam',
                recitationTitle: 'সালাম',
              ),
            );
          }
        }
      }

      final isIdentical = r > 2 && !isLastRakat && groups.isNotEmpty;
      groups.add(
        GeneratedRakatGroup(
          rakatNumber: r,
          labelBn: '$rনং রাকাত',
          steps: steps,
          isIdenticalToPrevious: isIdentical,
        ),
      );
    }

    return groups;
  }
}
