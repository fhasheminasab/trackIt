import 'package:flutter/foundation.dart';

class HeartData {
  int id;
  int rate;
  DateTime date;

  HeartData({
    @required this.rate,
    @required this.date,
  });
  HeartData.withId({
    @required this.id,
    @required this.rate,
    @required this.date,
  });

  //convert an instance to a map
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['rate'] = rate;
    map['date'] = date.toIso8601String();
    // map['date'] = date;
    return map;
  }

  //convert a map into an instance
  factory HeartData.fromMap(Map<String, dynamic> map) {
    return HeartData.withId(
      id: map['id'],
      rate: map['rate'],
      date: DateTime.parse(map['date']),
      // date: map['date'],
    );
  }
}
