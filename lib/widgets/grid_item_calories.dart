import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/calories_screen.dart';
import '../helpers/my_colors.dart';
import '../widgets/text_overlay.dart';

const String _svg_l59sgy =
    '<svg viewBox="204.0 106.0 110.0 174.0" ><path transform="translate(1064.0, 106.0)" d="M -749.9996948242188 174.0007019042969 L -749.9996948242188 173.9997100830078 L -860.0004272460938 173.9997100830078 L -860.0004272460938 7.215417099359911e-06 L -749.9996948242188 7.215417099359911e-06 L -749.9996948242188 173.9997100830078 L -749.9996948242188 174.0007019042969 Z M -750.1506958007813 2.499442100524902 L -750.1500244140625 2.500202894210815 L -857.9501953125 96.49980926513672 L -803.3499145507813 96.49980926513672 L -857.9501953125 170.2998046875 L -750.7503051757813 75.69989776611328 L -807.75 75.69989776611328 L -750.1500244140625 2.500202894210815 L -750.1506958007813 2.499442100524902 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

class GridItemCalories extends StatelessWidget {
  double height;
  double width;
  GridItemCalories({
    @required this.height,
    @required this.width,
  });
  final double percentage = 0.55; //TODO: get real data for this
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CaloriesScreen.routName);
        // showModalBottomSheet(
        //     context: context,
        //     builder: (_) {
        //       return MoodScreen();
        //     });
        // NOTE: maybe change this later and instead of screens use popup menues or sth.
        // to do so, create a onTap function, like "whatGridTile".
      },
      // onLongPress: null, //TODO
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
          children: <Widget>[
            // yellow part:
            Center(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      // to make the small yellow line disapear:
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: MyColors().bgColor,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: FractionallySizedBox(
                      heightFactor: percentage,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // to make the small yellow line disapear:
                        margin: EdgeInsets.all(1),
                        // width: 109.0, //-1
                        // height: 173.0, //-1
                        decoration: BoxDecoration(
                          color: MyColors().myAmber,
                        ),
                      ),
                    ),
                  ),
                  // white part:
                  SvgPicture.string(
                    _svg_l59sgy,
                    allowDrawingOutsideViewBox: true,
                  ),
                ],
              ),
            ),
            (percentage != null) //TODO: set a isSet variable for these
                ? TextOverlay(
                    '${(percentage * 100).round()}%', 40, 'Burnt calories', 10)
                : TextOverlay('Set goal', 40, 'tap', 10),
          ],
        ),
      ),
    );
  }
}
