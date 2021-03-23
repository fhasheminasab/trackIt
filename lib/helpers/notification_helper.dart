import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/notification_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationPlugin {
  var initializationSettings;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static final NotificationPlugin instance = NotificationPlugin._instance();
  NotificationPlugin._instance() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings();
    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
  }

  setOnSelectNotification(Function onSelectNotification) async {
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        await onSelectNotification(payload);
      },
    );
    await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if(value.didNotificationLaunchApp){

        // ... code
        
      }
    });
  }

  // Future onSelectNotification(
  //     String payload, Function onNotificationClick) async {
  //   if (payload != null) {
  //     await onNotificationClick(payload);
  //   }
  // }

  Future showNotification({
    @required NotificationModel notif,
    @required Function onSelectNotification,
  }) async {
    await setOnSelectNotification(onSelectNotification);
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show channel id',
      'show channel name',
      'show description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: DefaultStyleInformation(true, true),
      enableLights: true,
      color: Colors.teal,
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      // you can also show periodically
      notif.id,
      notif.title,
      notif.body,
      platformChannelSpecifics,
      payload: notif.payload,
    );
  }

  Future scheduleNotification({
    @required NotificationModel notif,
    @required Function onSelectNotification,
  }) async {
    setOnSelectNotification(onSelectNotification);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Iran/Tehran'));
    //TODO: getu location automatically, so use:
    //flutter_native_timezone: ^1.0.4

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        notif.id,
        notif.title,
        notif.body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'scheduled channel id',
            'scheduled channel name',
            'scheduled channel description',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // Future<void> showWeeklyAtDayAndTime(
  //     Time time, Day day, int id, String title, String description) async {
  //   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'show weekly channel id',
  //     'show weekly channel name',
  //     'show weekly description',
  //   );
  //   // final iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   final platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     // iOS: iOSPlatformChannelSpecifics,
  //   );
  //   await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
  //     id,
  //     title,
  //     description,
  //     day,
  //     time,
  //     platformChannelSpecifics,
  //   );
  // }

  // Future<void> showDailyAtTime(
  //     Time time, int id, String title, String description) async {
  //   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'show weekly channel id',
  //     'show weekly channel name',
  //     'show weekly description',
  //   );
  //   // final iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   final platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     // iOS: iOSPlatformChannelSpecifics,
  //   );
  //   await _flutterLocalNotificationsPlugin.showDailyAtTime(
  //     id,
  //     title,
  //     description,
  //     time,
  //     platformChannelSpecifics,
  //   );
  // }

  void sentNotif({
    @required String title,
    @required String body,
    @required String payoad,
    @required Function onSelectNotification,
  }) async {
    await showNotification(
      notif: NotificationModel.withId(
        id: 0,
        title: '<b>' + title + '</b>',
        body: body,
        payload: payoad,
      ),
      onSelectNotification: (payload) async {
        onSelectNotification(payload);
      //   print('They saw the notification:' + payload);
      },
    );
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    final pendingNotifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // Future<void> scheduleAllNotifications(
  //     List<Notification> notifications) async {
  //   for (final notification in notifications) {
  //     await showDailyAtTime(
  //       Time(notification.hour, notification.minute),
  //       notification.notificationId,
  //       notification.title,
  //       notification.body,
  //     );
  //   }
  // }
}
