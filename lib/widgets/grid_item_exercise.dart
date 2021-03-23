import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/imp_data_provider.dart';
import '../screens/exercise_screen.dart';

class GridItemExercise extends StatelessWidget {
  final double height;
  final double width;
  GridItemExercise({
    @required this.height,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ImpDataProvider>(context, listen: false)
            .fetchAndSetImpData(),
        builder: (ctx, snapshot) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ExerciseScreen.routName);
            },
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            // the radious of this should match the radious of the child
            child: Container(
              width: width,
              height: height,
              margin: const EdgeInsets.all(5), //adjust
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<ImpDataProvider>(
                  builder: (ctx, impdata, _) {
                    int count = impdata.impDataOfTheDay.exercise;
                    return Column(
                      children: [
                        // Bicep(count > 0),
                        // Bicep(count > 1),
                        // Bicep(count > 2),
                        Bicep(count <0),
                        Bicep(count < -1),
                        Bicep(count < -2),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

class Bicep extends StatelessWidget {
  final bool full;

  const Bicep(this.full);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Image.asset(
          full
              ? 'assets/images/flex-biceps-full.png'
              : 'assets/images/flex-biceps.png',
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
