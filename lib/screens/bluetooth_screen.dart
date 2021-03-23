import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../root_page.dart';

class BluetoothScreen extends StatelessWidget {
  static const String routName = '/flutterBlue-screen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (ctx, snapshot) {
          final state = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == BluetoothState.on) {
            return FindDeviceScreen();
          }
          return BluetoothOffScreen(state: state);
        });
  }
}

//---------------------------------------------------------------

class BluetoothOffScreen extends StatelessWidget {
  final BluetoothState state;
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10),
          Icon(
            Icons.bluetooth_disabled,
            size: 200.0,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
            style: Theme.of(context)
                .primaryTextTheme
                .subhead
                .copyWith(color: Theme.of(context).primaryColorDark),
          ),
          state == BluetoothState.off
              ? Text(
                  'Turn it on',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subhead
                      .copyWith(color: Theme.of(context).primaryColorDark),
                )
              : Container(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
//---------------------------------------------------------------

class FindDeviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final blueProvider = Provider.of<BluetoothProvider>(context);
    return RefreshIndicator(
      onRefresh: () =>
          FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
      child: Container(
        height: 300,
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: <Widget>[
                StreamBuilder<List<BluetoothDevice>>(
                  stream: Stream.periodic(Duration(seconds: 2))
                      .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                  initialData: [],
                  builder: (c, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? Container(
                          height: 250,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: snapshot.data
                              .map((d) => ListTile(
                                    title: Text(d.name),
                                    subtitle: Text(d.id.toString()),
                                    trailing:
                                        StreamBuilder<BluetoothDeviceState>(
                                      stream: d.state,
                                      initialData:
                                          BluetoothDeviceState.disconnected,
                                      builder: (c, snapshot) {
                                        if (snapshot.data ==
                                            BluetoothDeviceState.connected) {
                                          return FlatButton(
                                              onPressed: () {
                                                // We need to see if we're on startup:
                                                bool startup;
                                                d.toString() == 'null'
                                                    ? startup = true
                                                    : startup = false;
                                                // ImpDataProvider()
                                                //     .impDataOfTheDay
                                                //     .device = d;

                                                // blueProvider.pickDevice(
                                                //     device: d); //DELETE?
                                                if (startup) {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          Rootpage.routName);
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text('Connected'));
                                          // return RaisedButton(
                                          //   child: Text('Details'),
                                          //   onPressed: () => Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               DeviceScreen(device: d))),
                                          // );
                                        }

                                        return Text(snapshot.data.toString());
                                      },
                                    ),
                                  ))
                              .toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
