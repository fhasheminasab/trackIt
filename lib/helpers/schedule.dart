import 'dart:async';
import 'package:intl/intl.dart' as intl;

import '../providers/imp_data_provider.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
import '../helpers/notification_helper.dart';
import '../models/notification_model.dart';

class Schedule {
  // tasks:
  // add imp row to db every 24hrs.
  // read steps if cant subscribe, every 5mins
  // water reminder
  // check weather every hour
  // Schedule workot reminder

  test() {
    const minute = const Duration(seconds: 10);
    new Timer.periodic(minute, (Timer t) {
      doStuff();
    });
  }

  doStuff() {}

  setEveryDayTimers() {
    // this is the first time the app is starting,
    // we want to find midnight, but it might already be past midnight (still 12)
    // so if it's 12 we wait an hour, and then we start looking for 12 o'clock.
    const minute = const Duration(minutes: 1);
    DateTime now = DateTime.now();
    String firsthour = intl.DateFormat.H().format(now);
    if (firsthour == '00') {
      // thses happen when the app is installed and it's already 12
      new Timer.periodic(minute, (Timer t) {
        DateTime now = DateTime.now();
        String hour = intl.DateFormat.H().format(now);
        if (hour == '00') {
          //it's finally not 12 anymore, we can start looking for the next 12
          find12();
        }
      });
    }
  }

  find12() {
    // here we wanna find midnight so we can update our stuff at midnight
    const minute = const Duration(minutes: 1);
    new Timer.periodic(minute, (Timer t) {
      DateTime now = DateTime.now();
      String hour = intl.DateFormat.H().format(now);
      // String a = intl.DateFormat('hh').format(now); //alternative
      if (hour == '00') {
        //we found the perfect midnight, we can stop searching now.
        //and schedule the everyday tasks.
        doEveryDay();
        t.cancel();
      }
    });
  }

  doEveryDay() {
    const oneDay = const Duration(hours: 24);
    new Timer.periodic(oneDay, (Timer t) {
      doAsScheduled();
    });
  }

  doAsScheduled() async {
    ImpDataProvider().insertImpDataOfTheDay();
  }

  sentNotif() async {
    await NotificationPlugin.instance.showNotification(
      notif: NotificationModel.withId(
        id: 0,
        title: 'title<b>Test</b>',
        body: 'body<b>Test</b>',
        payload: 'payloaddd',
      ),
      onSelectNotification: (String payload) {
        print('payload:' + payload);
      },
    );
  }
  // final int helloAlarmID = 0;
  // await AndroidAlarmManager.initialize();
  // await AndroidAlarmManager.periodic(
  //     const Duration(hours: 24), helloAlarmID, printHello);

  // void printHello() {
  //   //test
  //   final DateTime now = DateTime.now();
  //   final int isolateId = Isolate.current.hashCode;
  //   print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  // }
}
