import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/prayer_times_calculator.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

enum AdhanSoundType {
  fullAdhan('পূর্ণ আযান', 'adhan_short'),
  shortBeep('সংক্ষিপ্ত বীফ', null),
  vibrateOnly('শুধু ভাইব্রেশন', null),
  silent('নীরব', null);

  const AdhanSoundType(this.labelBn, this.soundResource);
  final String labelBn;
  final String? soundResource;
}

class PrayerNotificationConfig {
  const PrayerNotificationConfig({
    this.fajrEnabled = true,
    this.dhuhrEnabled = true,
    this.asrEnabled = true,
    this.maghribEnabled = true,
    this.ishaEnabled = true,
    this.tahajjudEnabled = false,
    this.preReminderMinutes = 15,
    this.followUpEnabled = true,
    this.jumuahReminderEnabled = true,
    this.soundType = AdhanSoundType.fullAdhan,
    this.ramadanSehriIftarEnabled = true,
  });

  final bool fajrEnabled;
  final bool dhuhrEnabled;
  final bool asrEnabled;
  final bool maghribEnabled;
  final bool ishaEnabled;
  final bool tahajjudEnabled;
  final int preReminderMinutes;
  final bool followUpEnabled;
  final bool jumuahReminderEnabled;
  final AdhanSoundType soundType;
  final bool ramadanSehriIftarEnabled;

  Map<String, dynamic> toJson() => {
    'fajr': fajrEnabled,
    'dhuhr': dhuhrEnabled,
    'asr': asrEnabled,
    'maghrib': maghribEnabled,
    'isha': ishaEnabled,
    'tahajjud': tahajjudEnabled,
    'preReminder': preReminderMinutes,
    'followUp': followUpEnabled,
    'jumuah': jumuahReminderEnabled,
    'soundType': soundType.name,
    'ramadan': ramadanSehriIftarEnabled,
  };

  factory PrayerNotificationConfig.fromJson(Map<String, dynamic> map) {
    return PrayerNotificationConfig(
      fajrEnabled: map['fajr'] as bool? ?? true,
      dhuhrEnabled: map['dhuhr'] as bool? ?? true,
      asrEnabled: map['asr'] as bool? ?? true,
      maghribEnabled: map['maghrib'] as bool? ?? true,
      ishaEnabled: map['isha'] as bool? ?? true,
      tahajjudEnabled: map['tahajjud'] as bool? ?? false,
      preReminderMinutes: (map['preReminder'] as num?)?.toInt() ?? 15,
      followUpEnabled: map['followUp'] as bool? ?? true,
      jumuahReminderEnabled: map['jumuah'] as bool? ?? true,
      soundType: AdhanSoundType.values.firstWhere(
        (e) => e.name == map['soundType'],
        orElse: () => AdhanSoundType.fullAdhan,
      ),
      ramadanSehriIftarEnabled: map['ramadan'] as bool? ?? true,
    );
  }

  static const PrayerNotificationConfig defaultSettings = PrayerNotificationConfig();
}

/// Service handling multi-day prayer alerts, background actions, and channels.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const String channelAdhan = 'musalli_adhan_channel';
  static const String channelBeep = 'musalli_beep_channel';
  static const String channelSilent = 'musalli_silent_channel';
  static const String channelReminder = 'musalli_reminder_channel';

  static const String actionPrayed = 'ACTION_PRAYED';
  static const String actionLater = 'ACTION_LATER';

  Future<void> initialize({AppDatabase? db}) async {
    if (_initialized) return;

    tz.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));
    } catch (_) {}

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) async {
        if (response.actionId == actionPrayed) {
          final payload = response.payload;
          if (payload != null && db != null) {
            final now = DateTime.now();
            final dateKey = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
            final existing = await db.getSetting('tracker_day_$dateKey');
            final Map<String, dynamic> map = existing != null ? jsonDecode(existing) as Map<String, dynamic> : {};
            map[payload] = 'ontime';
            await db.setSetting('tracker_day_$dateKey', jsonEncode(map));
          }
        }
      },
    );

    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    final androidImpl = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      final granted = await androidImpl.requestNotificationsPermission();
      return granted ?? false;
    }
    final iosImpl = _notifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      final granted = await iosImpl.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }
    return true;
  }

  Future<void> schedulePrayerNotifications({
    required PrayerTimesSettings settings,
    required PrayerNotificationConfig config,
    int days = 14,
  }) async {
    if (!_initialized) await initialize();

    await _notifications.cancelAll();

    final now = DateTime.now();
    int notificationId = 1000;

    for (int dayOffset = 0; dayOffset < days; dayOffset++) {
      final targetDate = now.add(Duration(days: dayOffset));
      final schedule = PrayerTimesCalculator.calculateDailySchedule(targetDate, settings);

      final waqts = <({String slug, String nameBn, DateTime time, bool enabled})>[
        (slug: 'fajr', nameBn: 'ফজর', time: schedule.fajr, enabled: config.fajrEnabled),
        (slug: 'dhuhr', nameBn: 'যোহর', time: schedule.dhuhr, enabled: config.dhuhrEnabled),
        (slug: 'asr', nameBn: 'আসর', time: schedule.asr, enabled: config.asrEnabled),
        (slug: 'maghrib', nameBn: 'মাগরিব', time: schedule.maghrib, enabled: config.maghribEnabled),
        (slug: 'isha', nameBn: 'এশা', time: schedule.isha, enabled: config.ishaEnabled),
      ];

      for (final waqt in waqts) {
        if (!waqt.enabled) continue;
        if (waqt.time.isBefore(now)) continue;

        final tzTime = tz.TZDateTime.from(waqt.time, tz.local);

        // 1. Exact Waqt Adhan Notification
        await _notifications.zonedSchedule(
          notificationId++,
          '${waqt.nameBn} নামাজের ওয়াক্ত হয়েছে',
          'হাইয়া আলাস সালাহ — নামাজের দিকে আসুন।',
          tzTime,
          _buildNotificationDetails(config.soundType, isAdhan: true),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );

        // 2. Follow-up 30 min later with actions
        if (config.followUpEnabled) {
          final followUpTime = tzTime.add(const Duration(minutes: 30));
          if (followUpTime.isAfter(tz.TZDateTime.now(tz.local))) {
            await _notifications.zonedSchedule(
              notificationId++,
              'নামাজ পড়েছেন কি?',
              '${waqt.nameBn} নামাজ আদায় সম্পন্ন করে থাকলে মার্ক করুন।',
              followUpTime,
              _buildFollowUpDetails(waqt.slug),
              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
              payload: waqt.slug,
            );
          }
        }
      }

      // Friday Jumuah reminder at 11:30 AM
      if (config.jumuahReminderEnabled && targetDate.weekday == DateTime.friday) {
        final jumuahTime = DateTime(targetDate.year, targetDate.month, targetDate.day, 11, 30);
        if (jumuahTime.isAfter(now)) {
          final tzJumuah = tz.TZDateTime.from(jumuahTime, tz.local);
          await _notifications.zonedSchedule(
            notificationId++,
            'জুমুআর বরকতময় দিন 🕌',
            'আজ সূরা কাহাফ পাঠ ও দ্রুত মসজিদে যাওয়ার সুন্নাত স্মরণ করুন।',
            tzJumuah,
            _buildNotificationDetails(AdhanSoundType.shortBeep, isAdhan: false),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
        }
      }
    }
  }

  NotificationDetails _buildNotificationDetails(AdhanSoundType soundType, {required bool isAdhan}) {
    final AndroidNotificationDetails androidDetails;

    switch (soundType) {
      case AdhanSoundType.fullAdhan:
        androidDetails = const AndroidNotificationDetails(
          channelAdhan,
          'আযান ও ওয়াক্ত নোটিফিকেশন',
          channelDescription: 'ওয়াক্ত শুরু হলে পূর্ণ আযান ধ্বনি সহ নোটিফিকেশন।',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('adhan_short'),
          playSound: true,
          enableVibration: true,
        );
      case AdhanSoundType.shortBeep:
        androidDetails = const AndroidNotificationDetails(
          channelBeep,
          'সংক্ষিপ্ত বীফ এলার্ট',
          channelDescription: 'ওয়াক্তের মৃদু সংকেত।',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        );
      case AdhanSoundType.vibrateOnly:
        androidDetails = const AndroidNotificationDetails(
          channelBeep,
          'ভাইব্রেশন',
          channelDescription: 'শব্দহীন শুধু কম্পন।',
          importance: Importance.defaultImportance,
          enableVibration: true,
          playSound: false,
        );
      case AdhanSoundType.silent:
        androidDetails = const AndroidNotificationDetails(
          channelSilent,
          'নীরব নোটিফিকেশন',
          channelDescription: 'স্ক্রিনে শুধু ভিজ্যুয়াল নোটিফিকেশন।',
          importance: Importance.low,
          playSound: false,
          enableVibration: false,
        );
    }

    const iosDetails = DarwinNotificationDetails(
      sound: 'adhan_short.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  NotificationDetails _buildFollowUpDetails(String prayerSlug) {
    const androidDetails = AndroidNotificationDetails(
      channelReminder,
      'নামাজ ট্র্যাকার অনুস্মারক',
      channelDescription: 'নামাজ আদায়ের পর ট্র্যাকিং নিশ্চিত করতে অ্যাকশন নোটিফিকেশন।',
      importance: Importance.high,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(actionPrayed, 'পড়েছি ✅', showsUserInterface: false),
        AndroidNotificationAction(actionLater, 'পরে পড়ব ⏳', showsUserInterface: false),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'PRAYER_TRACKER_CATEGORY',
    );

    return const NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  Future<void> sendTestNotification(AdhanSoundType soundType) async {
    if (!_initialized) await initialize();

    await _notifications.show(
      999,
      'পরীক্ষামূলক আযান নোটিফিকেশন 📢',
      'আপনার ডিভাইসে নামাজের নোটিফিকেশন সফলভাবে সক্রিয় রয়েছে!',
      _buildNotificationDetails(soundType, isAdhan: true),
    );
  }
}
