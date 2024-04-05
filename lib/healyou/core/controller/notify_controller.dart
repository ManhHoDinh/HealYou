import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';

class NotifyController {
  static Future<bool> scheduleNotification(
      DateTime time, String title, String body) async {
    AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return await awesomeNotifications.createNotification(
        content: NotificationContent(
            id: Random().nextInt(100),
            channelKey: 'heal_you',
            title: title,
            body: body),
        schedule: NotificationCalendar(
            day: time.day,
            month: time.month,
            year: time.year,
            hour: time.hour,
            minute: time.minute));
  }
}
