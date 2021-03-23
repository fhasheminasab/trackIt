import 'package:flutter/material.dart';
import '../widgets/bluetooth_widget.dart';
import '../widgets/grid_item_water.dart';
import '../widgets/show_info_cards.dart';
import '../widgets/grid_item_calories.dart';
import '../widgets/grid_item_exercise.dart';
import '../widgets/grid_item_mood.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double width = deviceWidth * 0.32;
    double height = deviceHeight * 0.3;

    return SingleChildScrollView(
      child: Column(
        children: [
          BlueWidget(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: deviceSize.width * 0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GridItemWater(
                          height: height,
                          width: width,
                        ),
                        SizedBox(
                          width: deviceSize.width * 0.1,
                        ),
                        GridItemCalories(
                          height: height,
                          width: width,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceSize.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GridItemExercise(
                          height: height,
                          width: width,
                        ),
                        SizedBox(
                          width: deviceSize.width * 0.1,
                        ),
                        GridItemMood(
                          height: height,
                          width: width,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          InfoCards(),
          SizedBox(height: 50), // you can delete this later
        ],
      ),
    );
  }

}
