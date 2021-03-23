import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/my_colors.dart';
import '../providers/exercise_provider.dart';
import '../screens/exercise_pack_screen.dart';

class ExerciseScreen extends StatelessWidget {
  static const String routName = '/exercise-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: Provider.of<ExerciseProvider>(context, listen: false)
            .fetchAndSetExDone(),
        builder: (ctx, snapshot) => Consumer<ExerciseProvider>(
          builder: (ctx, exerciseProvider, _) => ListView.builder(
              itemCount: exerciseProvider.exDoneItems.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(height: 20);
                }
                return ExCard(
                  packId: (exerciseProvider.exDoneItems[(index - 1)].id),
                  title: 'Exercise',
                  info: (exerciseProvider.exDoneItems[(index - 1)].description),
                  done: (exerciseProvider
                      .exDoneItems[
                          ((exerciseProvider.exDoneItems[(index - 1)].id) - 1)]
                      .done),
                );
              }),
        ),
      ),
    );
  }
}

class ExCard extends StatelessWidget {
  final int packId;
  final String title;
  final String info;
  final int done;
  ExCard({
    @required this.packId,
    @required this.title,
    @required this.info,
    @required this.done,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ExerciseProvider>(context, listen: false).whichPackAreWeIn =
            packId;
        Navigator.of(context).pushNamed(ExercisePackScreen.routName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
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
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 18,
            ),
            height: 150,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title + ' ' + packId.toString(),
                  style: done == 0
                      ? TextStyle(
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: MyColors().myAlmostBlack,
                          // text shadow
                          shadows: [
                            Shadow(
                              color: MyColors().myAlmostBlack,
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            )
                          ],
                          decoration: TextDecoration.lineThrough,
                        )
                      : TextStyle(
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: MyColors().myDarkGreen,
                          // text shadow
                          shadows: [
                            Shadow(
                              color: MyColors().myAlmostBlack,
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            )
                          ],
                        ),
                  // textAlign: TextAlign.start,
                ),
                Divider(),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        info,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: MyColors().myLightGray,
                          // text shadow
                        ),
                        overflow: TextOverflow.fade,
                        // textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
