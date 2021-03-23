import 'package:flutter_blue/flutter_blue.dart';
import 'helpers/my_colors.dart';
import 'providers/imp_data_provider.dart';
import 'screens/bluetooth_screen.dart';
import 'screens/home_screen.dart';
import 'helpers/database_helper.dart';
import 'helpers/schedule.dart';
import 'widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class Rootpage extends StatefulWidget {
  static const String routName = '/home-screen';

  @override
  _RootpageState createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
  Future<void> _insertInitData() async {
    int isFT = await DatabaseHelper.instance.isFirstTime();
    if (isFT == 1) {
      await DatabaseHelper.instance.insertInitData();
      Schedule().setEveryDayTimers();
      ImpDataProvider().insertImpDataOfTheDay(isFirstTime: isFT);
    }
  }
  //-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (ctx, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return FutureBuilder(
                future: _insertInitData(),
                builder: (ctx, snapshot) {
                  //____________________

                  if ((snapshot.connectionState == ConnectionState.waiting)) {
                    return Container(
                      color: MyColors().myDarkGreen,
                      child: Center(
                        child: CircularProgressIndicator(),
                        // TODO: use a splash screen instead of this (?)
                      ),
                    );
                  }
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('TrackIt'),
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.bluetooth),
                            onPressed: () {
                              return showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return Container(
                                      // height: 250,
                                      color: Theme.of(context).backgroundColor,
                                      child: BluetoothScreen(),
                                    );
                                  });
                            })
                      ],
                    ),
                    backgroundColor: Theme.of(context).backgroundColor,
                    body: HomeScreen(),
                    drawer: AppDrawer(),
                  );
                });
          } else
            return BluetoothOffScreen(state: state);
        });
  }

  //-------------------------------------------------------------

}
