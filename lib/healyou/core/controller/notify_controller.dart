import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/controller/water_item_controller.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/core/models/firebase/water_item_request.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';
import 'package:healyou/healyou/healYouMain.dart';
import 'package:healyou/healyou/presentations/screens/otherTarget/other_target_screen.dart';
import 'package:healyou/healyou/presentations/screens/setTarget/set_target_screen.dart';
import 'package:healyou/main.dart';
import 'package:intl/intl.dart';

class NotifyController {
  static ReceivedAction? initialAction;
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'heal_you',
              channelName: "Heal You",
              channelDescription: 'It help you improve your health!',
              importance: NotificationImportance.Max,
              playSound: true,
              onlyAlertOnce: true,
              channelShowBadge: true,
              criticalAlerts: true,
              defaultColor: ColorPalette.primaryColor)
        ],
        debug: true);
    AwesomeNotifications().isNotificationAllowed().then((isAllow) {
      if (!isAllow) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<bool> scheduleNotification(DateTime time, String title,
      String body, Target item, int reached) async {
    AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    int millisecondsSinceEpoch = time.millisecondsSinceEpoch ~/ 1000;
    return await awesomeNotifications.createNotification(
        content: NotificationContent(
            id: millisecondsSinceEpoch,
            channelKey: 'heal_you',
            title: title,
            payload: {"targetId": item.id, "reached": reached.toString()},
            body: body),
        schedule: NotificationCalendar(
            day: time.day,
            month: time.month,
            year: time.year,
            hour: time.hour,
            minute: time.minute));
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    WaterItemController waterItemController = Get.find();
    waterItemController.updateItems();
    ;
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final payload = receivedAction.payload ?? {};

    if (payload["targetId"] != null) {
      String? id = payload["targetId"];
      double reached = double.parse(payload["reached"]!);

      await TargetRequest.updateReached(id!, reached);
    }
  }
}
