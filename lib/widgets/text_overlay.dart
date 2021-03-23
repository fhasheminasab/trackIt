import 'package:flutter/material.dart';
import '../helpers/my_colors.dart';

class TextOverlay extends StatelessWidget {
  final String bigText;
  final String smallText;
  final double bigSize;
  final double smallSize;

  TextOverlay(this.bigText, this.bigSize, this.smallText, this.smallSize);

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //55%
          // SizedBox(
          // width: 119.0,
          // height: 62.0,
          // child:
          Text(
            bigText,
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontWeight: FontWeight.bold,
              fontSize: bigSize,
              color: MyColors().myLightGray,
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
          // ),

          //burnt calories text
          // SizedBox(
          // width: 50.0,
          // child:
          Text(
            smallText,
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: smallSize,
              // fontSize: 7,
              color: MyColors().myLightGray,
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
          // ),
        ],
      ),
    );
  }
}
