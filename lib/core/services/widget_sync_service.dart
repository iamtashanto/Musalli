import 'package:home_widget/home_widget.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';

class WidgetSyncService {
  WidgetSyncService._();
  static final WidgetSyncService instance = WidgetSyncService._();

  static const String appGroupId = 'group.com.tashanto.musalli';
  static const String androidWidgetName = 'MusalliPrayerWidget';

  Future<void> updateWidgets(DailyScheduleTimes schedule, String nextWaqtBn, Duration remaining) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);

      final remMin = remaining.inMinutes;
      final remHours = remMin ~/ 60;
      final remLeftoverMin = remMin % 60;
      final countdownStr = remHours > 0
          ? '${BengaliNumbers.toBengali(remHours)} ঘণ্টা ${BengaliNumbers.toBengali(remLeftoverMin)} মি.'
          : '${BengaliNumbers.toBengali(remLeftoverMin)} মিনিট';

      await HomeWidget.saveWidgetData<String>('next_waqt_title', nextWaqtBn);
      await HomeWidget.saveWidgetData<String>('countdown_text', countdownStr);
      await HomeWidget.saveWidgetData<String>('fajr_time', _formatTime(schedule.fajr));
      await HomeWidget.saveWidgetData<String>('dhuhr_time', _formatTime(schedule.dhuhr));
      await HomeWidget.saveWidgetData<String>('asr_time', _formatTime(schedule.asr));
      await HomeWidget.saveWidgetData<String>('maghrib_time', _formatTime(schedule.maghrib));
      await HomeWidget.saveWidgetData<String>('isha_time', _formatTime(schedule.isha));

      await HomeWidget.updateWidget(
        name: androidWidgetName,
        iOSName: 'MusalliWidget',
      );
    } catch (_) {}
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute < 10 ? '০${dt.minute}' : BengaliNumbers.toBengali(dt.minute);
    return '${BengaliNumbers.toBengali(h)}:$m';
  }
}
