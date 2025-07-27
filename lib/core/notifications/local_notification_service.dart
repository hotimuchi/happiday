import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class LocalNotificationService {
  /// Планирует два уведомления: за день и в день события
  Future<void> scheduleBirthdayNotifications({
    required String eventId,
    required String name,
    required DateTime date,
    required TimeOfDay time,
  }) async {
    // За день до события
    final dayBefore = DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(const Duration(days: 1));
    final notificationTimeBefore = DateTime(
      dayBefore.year,
      dayBefore.month,
      dayBefore.day,
      time.hour,
      time.minute,
    );
    await scheduleNotificationAtDate(
      id: _buildNotificationId(eventId, 'before'),
      title: 'tomorrow'.tr(),
      body: name,
      scheduledDate: notificationTimeBefore,
    );
    // В сам день
    final notificationTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    await scheduleNotificationAtDate(
      id: _buildNotificationId(eventId, 'on'),
      title: 'today'.tr(),
      body: name,
      scheduledDate: notificationTime,
    );
  }

  /// Отменяет оба уведомления для события
  Future<void> cancelBirthdayNotifications(String eventId) async {
    await notificationsPlugin.cancel(_buildNotificationId(eventId, 'before'));
    await notificationsPlugin.cancel(_buildNotificationId(eventId, 'on'));
  }

  int _buildNotificationId(String eventId, String type) {
    return eventId.hashCode ^ type.hashCode;
  }

  /// Универсальный метод для планирования уведомления по DateTime
  Future<void> scheduleNotificationAtDate({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // Повторять ежегодно в этот день и время
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    // Timezone инициализация (для schedule)
    tz.initializeTimeZones();

    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    final location = tz.getLocation(timeZoneName);
    tz.setLocalLocation(location);

    // Android init settings
    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    // iOS init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Common init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initSettings,
      // Можно добавить обработчики для foreground на iOS
    );

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }
}
