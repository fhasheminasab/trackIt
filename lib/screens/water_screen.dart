import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/fact_card.dart';
import '../helpers/my_colors.dart';
import '../providers/imp_data_provider.dart';
import '../widgets/text_overlay.dart';

class WaterScreen extends StatefulWidget {
  static const String routName = '/water-screen';

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> waterFacts = [
    // from: https://www.culligan.com/blog/drinking-water-fun-facts#:~:text=The%20average%20amount%20of%20water,have%20a%20glass%20of%20water.
    'The average amount of water you need per day is about 3 liters (13 cups) for men and 2.2 liters (9 cups) for women.',
    'By the time you feel thirsty, your body has lost more than 1 percent of its total water – so let’s not feel thirst. Take a break right now and have a glass of water.',
    'Drinking water can help you lose weight by increasing your metabolism, which helps burn calories faster.',
    'Good hydration can prevent arthritis. With plenty of water in your body, there is less friction in your joints, thus less chance of developing arthritis.',
    'Good hydration can help reduce cavities and tooth decay. Water helps produce saliva, which keeps your mouth and teeth clean.',
  ];
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text('Water intake'),
    );
    double deviceHeight = ((MediaQuery.of(context).size.height) -
        (appbar.preferredSize.height) -
        (MediaQuery.of(context).padding.top));
    // double listViewHeight = deviceHeight - 160;
    double listViewHeight = deviceHeight - 295;
    return FutureBuilder(
      future: Provider.of<ImpDataProvider>(context, listen: false)
          .fetchAndSetImpData(),
      builder: (ctx, snapshot) => Scaffold(
        appBar: appbar,
        backgroundColor: Theme.of(context).backgroundColor,
        // body: Container(
          body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Consumer<ImpDataProvider>(
              builder: (ctx, impdata, _) {
                double widthFactor = impdata.getheightFactor();
                double percentage = impdata.getPercentage();
                return Column(
                  children: [
                    SizedBox(height: 5),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 30,
                          color: MyColors().myAmber,
                          // color: MyColors().myLightBlue,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Your Daily Water Goal (ml)',
                          labelStyle: TextStyle(fontSize: 22),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // validator: (input) => input.trim().isEmpty
                        //     ? 'Set a goal.'
                        //     : impdata.waterGoal,
                        initialValue: (impdata.settings.waterGoal.toString()),
                        onFieldSubmitted: (input) async {
                          // _waterGoalField = input;
                          await impdata.updateSettings(
                              waterGoal: int.parse(input));
                          print('------------------------saaaaaaaaaaaaaaaave');
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 160,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            // height: 150,
                            width: double.infinity,
                            child: FractionallySizedBox(
                              widthFactor: widthFactor,
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: widthFactor >= 1
                                      ? Radius.circular(10)
                                      : Radius.zero,
                                  topLeft: Radius.circular(10),
                                  topRight: widthFactor >= 1
                                      ? Radius.circular(10)
                                      : Radius.zero,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: MyColors().myLightBlue),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: (percentage !=
                                    null)
                                ? TextOverlay('${(percentage * 100).round()}%',
                                    52, 'Good job!', 16)
                                : TextOverlay('Set goal', 40, 'tap', 10),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: MyColors().bgColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x29000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        print('pressed');
                                        impdata.subtractAGlass();
                                      },
                                      child: FittedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_left,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              '-100',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: MyColors().bgColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x29000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      print('pressed');
                                      impdata.addAGlass();
                                    },
                                    child: FittedBox(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '+100',
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Icon(Icons.arrow_right),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(30),
                    //   height: 70,
                    //   width: double.infinity,
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 1,
                    //         child: FlatButton(
                    //             textColor: MyColors().myDarkGreen,
                    //             onPressed: null,
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(30),
                    //                 color: MyColors().myAmber,
                    //                 boxShadow: [
                    //                   BoxShadow(
                    //                     color: const Color(0x29000000),
                    //                     offset: Offset(0, 3),
                    //                     blurRadius: 6,
                    //                   ),
                    //                 ],
                    //               ),
                    //               width: double.infinity,
                    //               height: double.infinity,
                    //               child: Center(
                    //                 child: Text(
                    //                   '+100ml',
                    //                   style: TextStyle(
                    //                     color: Colors.green,
                    //                     fontSize: 20
                    //                   ),
                    //                 ),
                    //               ),
                    //             )),
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: FlatButton(
                    //           color: MyColors().myAmber,
                    //           textColor: Colors.red,
                    //           onPressed: null,
                    //           child: Text('-100ml'),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: MyColors().myDarkbg,
                      ),
                      width: double.infinity,
                      height: listViewHeight,
                      child: ListView.builder(
                        itemCount: waterFacts.length,
                        itemBuilder: (ctx, index) {
                          return FactCard(waterFacts[index]);
                          // return Container();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
