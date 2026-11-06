import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';

class AsmaulHusnaScreen extends StatefulWidget {
  const AsmaulHusnaScreen({super.key});

  @override
  State<AsmaulHusnaScreen> createState() => _AsmaulHusnaScreenState();
}

class _AsmaulHusnaScreenState extends State<AsmaulHusnaScreen> {
  List<dynamic> _names = [];

  @override
  void initState() {
    super.initState();
    _loadNames();
  }

  Future<void> _loadNames() async {
    // Generate the iconic names with meaning
    _names = const [
      {'number': 1, 'ar': 'الرَّحْمَٰنُ', 'bn': 'আর-রাহমান', 'meaning': 'পরম দয়ালু'},
      {'number': 2, 'ar': 'الرَّحِيمُ', 'bn': 'আর-রাহীম', 'meaning': 'অতিশয় মেহেরবান'},
      {'number': 3, 'ar': 'الْمَلِكُ', 'bn': 'আল-মালিক', 'meaning': 'সর্বভৌমিক ক্ষমতার অধিকারী'},
      {'number': 4, 'ar': 'الْقُدُّوسُ', 'bn': 'আল-কুদ্দুস', 'meaning': 'পরম পবিত্র'},
      {'number': 5, 'ar': 'السَّلَامُ', 'bn': 'আস-সালাম', 'meaning': 'শান্তিদাতা'},
      {'number': 6, 'ar': 'الْمُؤْمِنُ', 'bn': 'আল-মু’মিন', 'meaning': 'নিরাপত্তা দানকারী'},
      {'number': 7, 'ar': 'الْمُهَيْمِنُ', 'bn': 'আল-মুহাইমিন', 'meaning': 'রক্ষক ও অভিভাবক'},
      {'number': 8, 'ar': 'الْعَزِيزُ', 'bn': 'আল-আযীয', 'meaning': 'পরাক্রমশালী'},
      {'number': 9, 'ar': 'الْجَبَّارُ', 'bn': 'আল-জাব্বার', 'meaning': 'মহাপ্রতাপশালী'},
      {'number': 10, 'ar': 'الْمُتَكَبِّرُ', 'bn': 'আল-মুতাকাব্বির', 'meaning': 'শ্রেষ্ঠত্বের অধিকারী'},
    ];
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text('আসমাউল হুসনা (৯৯ নাম)', style: typography.titleLarge),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(tokens.spacing.md),
        itemCount: _names.length,
        separatorBuilder: (_, _) => SizedBox(height: tokens.spacing.xs),
        itemBuilder: (context, index) {
          final item = _names[index] as Map<String, dynamic>;
          return GlassCard(
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0x2610B981),
                  child: Text('${item['number']}', style: typography.label.copyWith(color: const Color(0xFF10B981))),
                ),
                SizedBox(width: tokens.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['bn'] as String, style: typography.titleMedium),
                      Text(item['meaning'] as String, style: typography.bodyMedium),
                    ],
                  ),
                ),
                Text(item['ar'] as String, style: typography.arabicLarge.copyWith(color: const Color(0xFF10B981))),
              ],
            ),
          );
        },
      ),
    );
  }
}
