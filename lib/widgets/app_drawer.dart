import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/my_colors.dart';
import '../providers/imp_data_provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Widget listTile(String title, Icon icon, String routName, BuildContext ctx,
      {Widget trailing}) {
    return ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.of(ctx).pushNamed(routName);
      },
      trailing: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hra = false;
    return Drawer(
      child: Container(
          color: Theme.of(context).backgroundColor,
          child: FutureBuilder(
              future: Provider.of<ImpDataProvider>(context, listen: false)
                  .fetchAndSetImpData(),
              builder: (ctx, snapshot) {
                // int hr =
                //     Provider.of<ImpDataProvider>(context).impDataOfTheDay.heart;
                return Column(
                  children: <Widget>[
                    AppBar(
                      title: Text('Going Somewhere?'),
                      automaticallyImplyLeading: false,
                      // this says don't add a 'back" button
                    ),
                    const SizedBox(height: 20),
                    Consumer<ImpDataProvider>(builder: (ctx, impdata, _) {
                      if (impdata.settings.heartRateAlert == 1) {
                        hra = true;
                      } else
                        hra = false;

                      return Column(
                        children: [
                          listTile(
                            'HeartRate Alert',
                            Icon(Icons.favorite),
                            '/',
                            context,
                            trailing: Switch(
                              value: hra,
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue) {
                                    impdata.updateSettings(heartRateAlert: 1);
                                  } else {
                                    impdata.updateSettings(heartRateAlert: 0);
                                  }
                                });
                              },
                            ),
                          ),
                          const Divider(),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.favorite_rounded,
                                // Icons.favorite_border_rounded,
                                color: Colors.red[300],
                                size: 200,
                              ),
                              // TextOverlay('your HeartRate',15,impdata.impDataOfTheDay.heart.toString(), 30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Your HeartRate:',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                      // fontSize: 7,
                                      color: Colors.white,
                                      // color: MyColors().myLightGray,
                                      shadows: [
                                        Shadow(
                                          color: MyColors().myAlmostBlack,
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    Provider.of<ImpDataProvider>(ctx,
                                            listen: true)
                                        .impDataOfTheDay
                                        .heart
                                        .toString(),
                                    // impdata.impDataOfTheDay.heart.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      // color: MyColors().myDarkGreen,
                                      color: Colors.white,

                                      // text shadow
                                      shadows: [
                                        Shadow(
                                          color: MyColors().myAlmostBlack,
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }),
                    const Divider(),
                    // listTile(
                    //   '---',
                    //   Icon(Icons.feedback),
                    //   '/',
                    //   context,
                    // ),
                    // const Divider(),
                    listTile(
                      'Settings',
                      Icon(Icons.settings),
                      '/settings-screen',
                      context,
                    ),
                    const Divider(),
                    // listTile(
                    //   'Logout',
                    //   Icon(Icons.exit_to_app),
                    //   '/',
                    //   context,
                    // ),

                  ],
                );
              })),
    );
  }
}
