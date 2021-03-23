//THE PROVIDER IS MERGED WITH ImpDataProvider

import 'package:flutter/foundation.dart';

// THE MODEL:

class Settings {
  int id;
  int heartRateAlert;
  int waterGoal;
  String smsNumber;
  String smsNumberisoCode;
  String smsText;
  String callNumber;
  String callNumberisoCode;
  int sendSMS;
  int makeCall;

  Settings({
    @required this.heartRateAlert,
    @required this.waterGoal,
    @required this.smsNumber,
    @required this.smsNumberisoCode,
    @required this.smsText,
    @required this.callNumber,
    @required this.callNumberisoCode,
    @required this.sendSMS,
    @required this.makeCall,
  });
  Settings.withId({
    @required this.id,
    @required this.heartRateAlert,
    @required this.waterGoal,
    @required this.smsNumber,
    @required this.smsNumberisoCode,
    @required this.smsText,
    @required this.callNumber,
    @required this.callNumberisoCode,
    @required this.sendSMS,
    @required this.makeCall,
  });
  //convert an instance to a map
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['heart_rate_alert'] = heartRateAlert;
    map['water_goal'] = waterGoal;
    map['sms_number'] = smsNumber;
    map['sms_number_isocode'] = smsNumberisoCode;
    map['sms_text'] = smsText;
    map['call_number'] = callNumber;
    map['call_number_isocode'] = callNumberisoCode;
    map['send_sms'] = sendSMS;
    map['make_call'] = makeCall;
    return map;
  }

  //convert a map into an instance
  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings.withId(
      id: map['id'],
      heartRateAlert: map['heart_rate_alert'],
      waterGoal: map['water_goal'],
      smsNumber: map['sms_number'],
      smsNumberisoCode: map['sms_number_isocode'],
      smsText: map['sms_text'],
      callNumber: map['call_number'],
      callNumberisoCode: map['call_number_isocode'],
      sendSMS: map['send_sms'],
      makeCall: map['make_call'],
    );
  }
}
