import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../helpers/database_helper.dart';
import '../models/heart_data.dart';
import '../providers/imp_data_provider.dart';

class BlueWidget extends StatefulWidget {
  @override
  _BlueWidgetState createState() => _BlueWidgetState();
}

class _BlueWidgetState extends State<BlueWidget> {
  // final FlutterBlue _flutterBlue = FlutterBlue.instance;
  bool isOn;
  List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  BluetoothDevice chosenDevice;
  int deviceNumber = 0;
  List<BluetoothService> _services;
  //-------------------------------------------------------------
  //UUIDs:
  Guid heartRateService = new Guid('0000180d-0000-1000-8000-00805f9b34fb');
  Guid heartRateChar = new Guid('00002a37-0000-1000-8000-00805f9b34fb');

  @override
  void initState() {
    FlutterBlue.instance.connectedDevices.then((ds) {
      ds[0].connect().then((_) {
        ds[0].discoverServices().then((ss) {
          _services = [...ss];
          ss
              .firstWhere((s) => s.uuid == heartRateService)
              .characteristics
              .firstWhere(
                  (c) => ((c.uuid == heartRateChar) && (c.isNotifying != true)))
              .setNotifyValue(true);
          //-----------------------------
          ss
              .firstWhere((s) => s.uuid == heartRateService)
              .characteristics
              .firstWhere(
                  (c) => ((c.uuid == heartRateChar) && (c.isNotifying != true)))
              .value
              .listen((e) {
            if ((e != null) && (e.length > 1)) {
              if ((e[1] != null) && (e[1] != 0)) {
                print('=====================' + e[1].toString());
                addHRtoDB(e[1]);
              }
            }
          });
        });
      });
    });
    super.initState();
  }

  void addHRtoDB(int hr) async {
    await DatabaseHelper.instance
        .insertHeartData(HeartData(rate: hr, date: DateTime.now()));
    await ImpDataProvider().updateImpDataProvider(heart: hr);
    print('-----------' + hr.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
    );
  }
}
