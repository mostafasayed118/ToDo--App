import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    // log(response.payload.toString());
    // log(response.id.toString());
    streamController.add(notificationResponse);
  }

  //! Initialize Notification
  static Future<void> init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap);
  }

  //! basic Notification
  static void showBasicNotification() async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        'basic Notification',
        importance: Importance
            .max, //? Importance.high & Priority.high => to show on top of all notifications
        priority: Priority.high,
        enableVibration: true,
        enableLights: true,
        color: Colors.blue,
        icon: '@mipmap/ic_launcher',
        sound:
            RawResourceAndroidNotificationSound('sound.wav'.split('.').first),
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      1,
      'Basic Notification',
      'This is a basic Notification',
      notificationDetails,
      payload: 'basic Notification',
    );
  }

//! Repeated Notification
  static void showRepeatedNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 2',
        'Repeated Notification',
        importance: Importance
            .max, //? Importance.high & Priority.high => to show on top of all notifications
        priority: Priority.high,
        enableVibration: true,
        enableLights: true,
        color: Colors.blue,
        icon: '@mipmap/ic_launcher',
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      2,
      'Repeated Notification',
      'This is a Repeated Notification',
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: 'Repeated Notification',
    );
  }

//! Scheduled Notification
  static void showScheduledNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 3',
        'Scheduled Notification',
        importance: Importance
            .max, //? Importance.high & Priority.high => to show on top of all notifications
        priority: Priority.high,
        enableVibration: true,
        enableLights: true,
        color: Colors.blue,
        icon: '@mipmap/ic_launcher',
      ),
    );
    tz.initializeTimeZones();
    // log(tz.local.toString());
    // log("After ${tz.TZDateTime.now(tz.local).hour}");

    // final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    // tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // log(tz.local.toString());
    // log("After ${tz.TZDateTime.now(tz.local).hour}");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      'Scheduled Notification',
      'This is a  Scheduled Notification',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), //! Working
      // tz.TZDateTime(tz.local, 2024, DateTime.august, 12, 18, 28), //! not working
      notificationDetails,
      payload: 'Scheduled Notification',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //!  Daily Scheduled
  static void showDailyScheduledNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 4',
        'Daily Scheduled Notification',
        importance: Importance
            .max, //? Importance.high & Priority.high => to show on top of all notifications
        priority: Priority.high,
        enableVibration: true,
        enableLights: true,
        color: Colors.blue,
        icon: '@mipmap/ic_launcher',
      ),
    );
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    log(" currentTimeZone.year ${currentTimeZone.year}");
    log(" currentTimeZone.month ${currentTimeZone.month}");
    log(" currentTimeZone.day ${currentTimeZone.day}");
    log(" currentTimeZone.hour ${currentTimeZone.hour}");
    log(" currentTimeZone.minute ${currentTimeZone.minute}");
    log(" currentTimeZone.second ${currentTimeZone.second}");
    log('___________________________________________');
    var scheduleTime = tz.TZDateTime(
      tz.local,
      currentTimeZone.year,
      currentTimeZone.month,
      currentTimeZone.day,
      currentTimeZone.hour,
      30,
    );
    log(" scheduleTimeZone.year ${scheduleTime.year}");
    log(" scheduleTimeZone.month ${scheduleTime.month}");
    log(" scheduleTimeZone.day ${scheduleTime.day}");
    log(" scheduleTimeZone.hour ${scheduleTime.hour}");
    log(" scheduleTimeZone.minute ${scheduleTime.minute}");
    log(" scheduleTimeZone.second ${scheduleTime.second}");
    log("___________________________________________");
    if (scheduleTime.isBefore(currentTimeZone)) {
      scheduleTime = scheduleTime.add(const Duration(minutes: 28));
      log(" scheduleTimeZone.after ${scheduleTime.year}");
      log(" scheduleTimeZone.after ${scheduleTime.month}");
      log(" scheduleTimeZone.after ${scheduleTime.day}");
      log(" scheduleTimeZone.after ${scheduleTime.hour}");
      log(" scheduleTimeZone.after ${scheduleTime.minute}");
      log(" scheduleTimeZone.after ${scheduleTime.second}");
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      4,
      'Daily Scheduled Notification',
      'This is a Daily Scheduled Notification',
      scheduleTime, //!  working
      notificationDetails,
      payload: 'Daily Scheduled Notification',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
