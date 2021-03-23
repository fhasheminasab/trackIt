import 'package:flutter/material.dart';
import '../screens/mood_screen.dart';
import '../widgets/text_overlay.dart';

class GridItemMood extends StatelessWidget {
  final double height;
  final double width;
  GridItemMood({
    @required this.height,
    @required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(MoodScreen.routName);
        Navigator.of(context).pushNamed(MoodScreen.routName);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      // the radious of this should match the radious of the child
      child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.all(5), //adjust
          // padding: const EdgeInsets.all(10), //adjust
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
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset('assets/images/headphones.png'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  TextOverlay(
                    'Mood\nboost',
                    22,
                    // '\nLong press\nto play',
                    '\nenjoy some\nmusic',
                    12,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
