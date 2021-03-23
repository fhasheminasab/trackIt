import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../helpers/contact.dart';
import '../helpers/notification_helper.dart';
import '../helpers/database_helper.dart';
import '../models/imp_data.dart';
import '../models/settings.dart';

class ImpDataProvider with ChangeNotifier {
  // int numberOfHeart = 0;
  int maxHeartRate = 140;
  int minHeartRate = 55;
  //----------------------
  ImpData impDataOfTheDay = ImpData(
    date: null,
    calorie: 0,
    exercise: 0,
    heart: null,
    water: 10,
    // device: null,
  );
  //----------------------

  Future<void> updateImpDataProvider({
    int calorie,
    int exercise,
    int heart,
    int water,
    int decreseWater,
    // BluetoothDevice device,
  }) async {
    await fetchAndSetImpData();
    if (calorie != null) {
      impDataOfTheDay.calorie = calorie;
    }

    if (exercise != null) {
      if (exercise == 1) {
        impDataOfTheDay.exercise += 1;
      } else if (exercise == (-1)) {
        impDataOfTheDay.exercise -= 1;
      }
    }

    if (heart != null) {
      if (boolHeartRateAlert == true) {
        if (heart > maxHeartRate) {
          NotificationPlugin.instance.sentNotif(
            title: 'ALERT',
            body: 'Your heart rate is too high. cool down.',
            payoad: 'seen',
            onSelectNotification: (payload) async {
              // NowPlayingScreenCombined();
            },
          );
          if ((boolSendSMS == true) && (settings.smsNumber != '')) {
            Contact().sms(settings.smsNumber, settings.smsText);
          } else
          if ((boolMakeCall == true) && (settings.callNumber != '')) {
            Contact().call(settings.callNumber);
          }
        } else if (heart < minHeartRate) {
          NotificationPlugin.instance.sentNotif(
              title: 'ALERT',
              body: 'Your heart rate is too low. do something',
              payoad: 'seen',
              onSelectNotification: () async {});
          if ((boolSendSMS == true) && (settings.smsNumber != '')) {
            Contact().sms(settings.smsNumber, settings.smsText);
          } else
          if ((boolMakeCall == true) && (settings.callNumber != '')) {
            Contact().call(settings.callNumber);
          }
        }
      }
      // if (impDataOfTheDay.heart == null) {
      impDataOfTheDay.heart = heart;
      //   numberOfHeart++;
      // } else {
      //   int sum;
      //   sum = (impDataOfTheDay.heart) * numberOfHeart;
      //   sum += heart;
      //   numberOfHeart++;
      //   impDataOfTheDay.heart = (sum / numberOfHeart).round();
      // }
    }
    if (water != null) {
      impDataOfTheDay.water += water;
    }
    if ((decreseWater != null) && (impDataOfTheDay.water > 0)) {
      impDataOfTheDay.water -= decreseWater;
    }

    if (impDataOfTheDay.date == null) {
      impDataOfTheDay.date = DateTime.now();
    }
    await DatabaseHelper.instance.updateImpData(impDataOfTheDay);
    notifyListeners();
  }

  Future<void> insertImpDataOfTheDay({int isFirstTime}) async {
    // int isFT = await DatabaseHelper.instance.isFirstTime();
    ImpData newDay = new ImpData();
    newDay.date = DateTime.now();
    newDay.calorie = 0;
    newDay.exercise = 0;
    newDay.water = 0;
    if (isFirstTime == 1) {
      newDay.heart = 70;
    } else {
      newDay.heart = impDataOfTheDay.heart;
    }

    // newDay.device = impDataOfTheDay.device;
    await DatabaseHelper.instance.insertImpData(newDay);
    await fetchAndSetImpData();
  }

  Future<void> fetchAndSetImpData() async {
    impDataOfTheDay = await DatabaseHelper.instance.getImpDataOfTheDay();
    await fetchAndSetSettings();
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////////////
  ///
  // Settings PROVIDER:

  // inits:
  Settings settings = Settings(
    heartRateAlert: 0,
    waterGoal: 2000,
    smsNumber: '',
    smsNumberisoCode: '',
    smsText: '',
    callNumber: '',
    callNumberisoCode: '',
    sendSMS: 0,
    makeCall: 0,
  );
  //-------------------
  Future<void> fetchAndSetSettings() async {
    settings = await DatabaseHelper.instance.getSettings();
    notifyListeners();
  }

  Future<void> updateSettings({
    int heartRateAlert,
    int waterGoal,
    String smsNumber,
    String smsNumberisoCode,
    String smsText,
    String callNumber,
    String callNumberisoCode,
    int sendSMS,
    int makeCall,
  }) async {
    if (heartRateAlert != null) {
      settings.heartRateAlert = heartRateAlert;
      settings.makeCall = 0;
      settings.sendSMS = 0;
    }
    if (waterGoal != null) {
      settings.waterGoal = waterGoal;
    }
    if (smsNumber != null) {
      settings.smsNumber = smsNumber;
    }
    if (smsNumberisoCode != null) {
      settings.smsNumberisoCode = smsNumberisoCode;
    }
    if (smsText != null) {
      settings.smsText = smsText;
    }
    if (callNumber != null) {
      settings.callNumber = callNumber;
    }
    if (callNumberisoCode != null) {
      settings.callNumberisoCode = callNumberisoCode;
    }
    if (sendSMS != null) {
      settings.sendSMS = sendSMS;
    }
    if (makeCall != null) {
      settings.makeCall = makeCall;
    }
    await DatabaseHelper.instance.updateSettings(settings);
    notifyListeners();
  }

  bool get boolHeartRateAlert {
    if (settings.heartRateAlert == 1) {
      return true;
    } else
      return false;
  }

  bool get boolSendSMS {
    if (settings.sendSMS == 1) {
      return true;
    } else
      return false;
  }

  bool get boolMakeCall {
    if (settings.makeCall == 1) {
      return true;
    } else
      return false;
  }
  //////////////////////////////////////////////////////////////////////////////////////
  ///
  // WATER:

  int waterGlass100 = 100;
  double getPercentage() {
    if ((impDataOfTheDay.water) == 0) {
      return 0;
    } else
      return (impDataOfTheDay.water) / (settings.waterGoal);
  }

  double getheightFactor() {
    double perc = (getPercentage() + 0.05);
    if (perc > 1) {
      return 1;
    } else
      return perc;
  }

  addAGlass() {
    updateImpDataProvider(water: waterGlass100);
    notifyListeners();
  }

  subtractAGlass() {
    updateImpDataProvider(decreseWater: waterGlass100);
    notifyListeners();
  }
}
