import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart' as pn;
import 'package:provider/provider.dart';
import '../providers/imp_data_provider.dart';
import '../helpers/my_colors.dart';
import '../widgets/text_overlay.dart';

class SettingsScren extends StatefulWidget {
  static const String routName = '/settings-screen';
  @override
  _SettingsScrenState createState() => _SettingsScrenState();
}

class _SettingsScrenState extends State<SettingsScren> {
  final _formKeyCall = GlobalKey<FormState>();
  final _formKeySMS = GlobalKey<FormState>();
  final String initialCountry = 'IR';
  final pn.PhoneNumber number = pn.PhoneNumber(isoCode: 'IR');
  String finalNumber;
  String finalNumberisocode;
  String _callNumber = '';
  String _callNumberisoCode = '';
  String _smsNumber = '';
  String _smsNumberisoCode = '';
  String _smsText;
  // final TextEditingController controller = TextEditingController();
  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  bool _perfectWalkAlertIsSwitched() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ImpDataProvider>(context, listen: false)
            .fetchAndSetImpData(),
        builder: (ctx, snapshot) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text('Settings'),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: saveSettings,
            //   child: Icon(
            //     Icons.save,
            //     color: Colors.white,
            //     // color: MyColors().bgColor,
            //   ),
            // ),
            body: SingleChildScrollView(
              child: Consumer<ImpDataProvider>(builder: (ctx, impdata, _) {
                Future<void> _trySubmitSMS(context) async {
                  final isValid = _formKeySMS.currentState.validate();
                  FocusScope.of(context).unfocus();
                  if (isValid) {
                    _formKeySMS.currentState.save();
                    await impdata.updateSettings(
                      smsNumber: _smsNumber,
                      smsNumberisoCode: _smsNumberisoCode,
                      smsText: _smsText,
                    );

                    Navigator.pop(context);
                  }
                }

                Future<void> _trySubmitCall(context) async {
                  final isValid = _formKeyCall.currentState.validate();
                  FocusScope.of(context).unfocus();
                  if (isValid) {
                    _formKeyCall.currentState.save();
                    await impdata.updateSettings(
                        callNumber: _callNumber,
                        callNumberisoCode: _callNumberisoCode);
                    Navigator.pop(context);
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      child: TextOverlay(
                          'Settings', 50, 'set things as you like', 17),
                    ),
                    const Divider(),
                    Level1Card(
                      text: 'HeartRate anomally alert',
                      subText: 'notify when it\'s <55 or >140',
                      switchFunc: (newValue) {
                        setState(() {
                          if (newValue) {
                            impdata.updateSettings(heartRateAlert: 1);
                          } else {
                            impdata.updateSettings(heartRateAlert: 0);
                          }
                        });
                      },
                      isSwitched: impdata.boolHeartRateAlert,
                    ),
                    GestureDetector(
                      onTap: impdata.boolMakeCall
                          ? () {
                              showDialog(
                                  context: ctx,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        height: 300,
                                        padding: EdgeInsets.all(20),
                                        // decoration: BoxDecoration(
                                        //   borderRadius:
                                        //       BorderRadius.all(Radius.circular(20)),
                                        // ),
                                        color: MyColors().bgColor,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // SizedBox(height: 10),

                                            Text(
                                              'Who do you want to call?',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              '(in case of a heart rate anommaly)',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      MyColors().myLightGray),
                                            ),
                                            SizedBox(height: 20),
                                            Form(
                                              key: _formKeyCall,
                                              child: pn
                                                  .InternationalPhoneNumberInput(
                                                hintText: '09123456780',
                                                textStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                inputDecoration:
                                                    InputDecoration(
                                                  // labelText: 'Emergency number',
                                                  // labelStyle:
                                                  // TextStyle(fontSize: 22),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                autoFocus: impdata.settings
                                                            .callNumber ==
                                                        ''
                                                    ? true
                                                    : false,

                                                // onInputValidated: (bool value) {
                                                //   validCallNumber = value;
                                                // },
                                                selectorConfig:
                                                    pn.SelectorConfig(
                                                  selectorType: pn
                                                      .PhoneInputSelectorType
                                                      .BOTTOM_SHEET,
                                                  backgroundColor:
                                                      MyColors().bgColor,
                                                ),
                                                ignoreBlank: false,
                                                autoValidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                selectorTextStyle: TextStyle(
                                                    color: Colors.black),
                                                initialValue: impdata.settings
                                                            .callNumber ==
                                                        ''
                                                    ? number
                                                    : pn.PhoneNumber(
                                                        phoneNumber: (impdata
                                                            .settings
                                                            .callNumber),
                                                        isoCode: impdata
                                                            .settings
                                                            .callNumberisoCode),
                                                onInputChanged:
                                                    (pn.PhoneNumber number) {
                                                  finalNumber =
                                                      number.phoneNumber;
                                                  finalNumberisocode =
                                                      number.isoCode;
                                                },
                                                inputBorder:
                                                    OutlineInputBorder(),
                                                onSaved: (_) {
                                                  _callNumber = finalNumber;
                                                  _callNumberisoCode =
                                                      finalNumberisocode;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            FlatButton(
                                              child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  alignment: Alignment.center,
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    color: MyColors().myAmber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(
                                                            0x29000000),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Text('Submit')),
                                              onPressed: () async {
                                                await _trySubmitCall(context);
                                                // if (validCallNumber == true) {
                                                // await impdata.updateSettings(
                                                //     callNumber: callNumber);
                                                //   Navigator.pop(context);
                                                // }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          : () {},
                      child: Level2Card(
                        text: 'Call for help',
                        subText: impdata.settings.callNumber == ''
                            ? 'Tap to set a number'
                            : 'call ${impdata.settings.callNumber}',
                        active: impdata.boolHeartRateAlert ? true : false,
                        switchFunc: (newValue) {
                          if (impdata.boolHeartRateAlert) {
                            setState(() {
                              if (newValue) {
                                impdata.updateSettings(makeCall: 1);
                                //disable the other
                                impdata.updateSettings(sendSMS: 0);
                              } else {
                                impdata.updateSettings(makeCall: 0);
                              }
                            });
                          }
                        },
                        isSwitched: impdata.boolHeartRateAlert
                            ? impdata.boolMakeCall
                            : false,
                      ),
                    ),
                    GestureDetector(
                      onTap: impdata.boolSendSMS
                          ? () {
                              showDialog(
                                  context: ctx,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        height: 420,
                                        padding: EdgeInsets.all(20),
                                        // decoration: BoxDecoration(
                                        //   borderRadius:
                                        //       BorderRadius.all(Radius.circular(20)),
                                        // ),
                                        color: MyColors().bgColor,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // SizedBox(height: 10),

                                              Text(
                                                'Who do you want to text?',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                '(in case of a heart rate anommaly)',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        MyColors().myLightGray),
                                              ),
                                              SizedBox(height: 20),
                                              Form(
                                                key: _formKeySMS,
                                                child: Column(
                                                  children: [
                                                    pn.InternationalPhoneNumberInput(
                                                      hintText: '09123456780',
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      inputDecoration:
                                                          InputDecoration(
                                                        // labelText: 'Emergency number',
                                                        // labelStyle:
                                                        // TextStyle(fontSize: 22),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      autoFocus: impdata
                                                                  .settings
                                                                  .smsNumber ==
                                                              ''
                                                          ?true:false,

                                                      // onInputValidated: (bool value) {
                                                      //   validSMSNumber = value;
                                                      // },
                                                      selectorConfig:
                                                          pn.SelectorConfig(
                                                        selectorType: pn
                                                            .PhoneInputSelectorType
                                                            .BOTTOM_SHEET,
                                                        backgroundColor:
                                                            MyColors().bgColor,
                                                      ),
                                                      ignoreBlank: false,
                                                      autoValidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      selectorTextStyle:
                                                          TextStyle(
                                                              color:
                                                                  Colors.black),
                                                      initialValue: impdata
                                                                  .settings
                                                                  .smsNumber ==
                                                              ''
                                                          ? number
                                                          : pn.PhoneNumber(
                                                              phoneNumber:
                                                                  (impdata
                                                                      .settings
                                                                      .smsNumber),
                                                              isoCode: impdata
                                                                  .settings
                                                                  .smsNumberisoCode),
                                                      onInputChanged:
                                                          (pn.PhoneNumber
                                                              number) {
                                                        finalNumber =
                                                            number.phoneNumber;
                                                        finalNumberisocode =
                                                            number.isoCode;
                                                      },
                                                      inputBorder:
                                                          OutlineInputBorder(),
                                                      onSaved: (_) {
                                                        _smsNumber =
                                                            finalNumber;
                                                        _smsNumberisoCode =
                                                            finalNumberisocode;
                                                      },
                                                    ),
                                                    SizedBox(height: 30),
                                                    TextFormField(
                                                      minLines: 2,
                                                      maxLines: 5,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      // hint: '09123456780',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'SMS Text:',
                                                        // labelStyle:
                                                        // TextStyle(fontSize: 22),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      // validator: null,

                                                      initialValue: impdata
                                                          .settings.smsText,
                                                      onSaved: (input) {
                                                        _smsText = input;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              FlatButton(
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    alignment: Alignment.center,
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                      color: MyColors().myAmber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                              0x29000000),
                                                          offset: Offset(0, 3),
                                                          blurRadius: 6,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text('Submit')),
                                                onPressed: () async {
                                                  await _trySubmitSMS(context);
                                                  // if (validSMSNumber == true) {
                                                  // await impdata.updateSettings(
                                                  //     callNumber: smsNumber);
                                                  //   Navigator.pop(context);
                                                  // }
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          : () {},
                      child: Level2Card(
                        text: 'Send SMS for help',
                        subText: impdata.settings.callNumber == ''
                            ? 'Tap to set a number'
                            : 'text ${impdata.settings.smsNumber}',
                        active: impdata.boolHeartRateAlert ? true : false,
                        switchFunc: (newValue) {
                          if (impdata.boolHeartRateAlert) {
                            setState(() {
                              if (newValue) {
                                impdata.updateSettings(sendSMS: 1);
                                //disabl the other
                                impdata.updateSettings(makeCall: 0);
                              } else {
                                impdata.updateSettings(sendSMS: 0);
                              }
                            });
                          }
                        },
                        isSwitched: impdata.boolHeartRateAlert
                            ? impdata.boolSendSMS
                            : false,
                      ),
                    ),
                    const Divider(),
                    Level1Card(
                      text: 'Perfect walk alert',
                      subText: 'notify me when it\'s the best time to walk',
                      switchFunc: (newValue) {
                        setState(() {
                          print('track weather');
                        });
                      },
                      isSwitched: _perfectWalkAlertIsSwitched(),
                    ),
                    Container(
                      height: 200,
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}

class Level1Card extends StatelessWidget {
  final String text;
  final String subText;
  Function switchFunc;
  bool isSwitched = false;

  Level1Card({
    @required this.text,
    @required this.subText,
    this.switchFunc,
    this.isSwitched,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      child: Container(
        width: double.infinity,
        height: 65,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Segoe UI',
                    fontWeight: FontWeight.bold,
                    color: MyColors().myDarkGray,
                  ),
                ),
                Text(
                  ' ' + subText,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Segoe UI',
                  ),
                  // style: TextStyle(fontSize: 11),
                ),
              ],
            ),
            (switchFunc != null)
                ? Switch(
                    value: isSwitched,
                    onChanged: switchFunc,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class Level2Card extends StatelessWidget {
  final String text;
  final String subText;
  final bool active;
  Function switchFunc;
  bool isSwitched = false;

  Level2Card({
    @required this.text,
    @required this.subText,
    @required this.active,
    this.switchFunc,
    this.isSwitched,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      color: Theme.of(context).scaffoldBackgroundColor,
      // color: MyColors().bgColor,
      elevation: 0.5,
      child: Container(
        width: double.infinity,
        height: 65,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                VerticalDivider(
                  thickness: 3,
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.bold,
                        color: active
                            ? MyColors().myDarkGray
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                    Text(
                      ' ' + subText,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Segoe UI',
                          color: active
                              ? Colors.black
                              : Theme.of(context).disabledColor),
                      // style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            (switchFunc != null)
                ? Switch(
                    value: isSwitched,
                    onChanged: switchFunc,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
