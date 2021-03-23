import 'package:flutter/foundation.dart';

class NotificationModel {
  static const String notifId = 'id';
  static const String notifTitle = 'title';
  static const String notifBody = 'body';
  static const String notifPayload = 'payload';
  // static const String notifHour = 'hour';
  // static const String notifMinute = 'minute';

  // String id;
  // int notificationId;
  int id;
  String title;
  String body;
  String payload;
  // int hour;
  // int minute;

  NotificationModel({
    @required this.title,
    @required this.body,
    this.payload,
    // this.hour,
    // this.minute,
  });
  NotificationModel.withId(
      {@required this.id,
      @required this.title,
      @required this.body,
      this.payload
      // this.hour,
      // this.minute,
      });

  //convert an instance to a map
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map[notifId] = id;
    }
    map[notifTitle] = title;
    map[notifBody] = body;
    map[notifPayload] = payload;
    // map[notifHour] = hour;
    // map[notifMinute] = minute;
    return map;
  }

  //convert a map into an instance
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel.withId(
      id: map[notifId],
      title: map[notifTitle],
      body: map[notifBody],
      payload: map[notifPayload],
      // hour: map[notifHour],
      // minute: map[notifMinute],
    );
  }
}
