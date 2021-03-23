import 'package:flutter/material.dart';

class MyColors {
  final myDarkGreen = const Color(0xff004445);
  final myLightGreen = const Color(0xff2c786c);
  final myDarkbg = const Color(0xfff6edce);
  final myDarkbg2 = const Color(0xffefdba3);
  final _myAmber = const Color(0xffF8B400);

  Color get myAmber {
    return _myAmber;
  }

  final _bgColor = const Color(0xfffaf5e4);
  Color get bgColor {
    return _bgColor;
  }

  final _myLightBlue = const Color(0xff91CFFF);
  Color get myLightBlue {
    return _myLightBlue;
  }

  Color get teal {
    return Colors.teal;
  }

  final _myAlmostBlack = const Color(0x29000000);
  Color get myAlmostBlack {
    return _myAlmostBlack;
  }

  final _myDarkGray = const Color(0xff484848);
  Color get myDarkGray {
    return _myDarkGray;
  }

  final _myLightGray = const Color(0xff707070);
  Color get myLightGray {
    return _myLightGray;
  }

//-------------------------------------------------
// SHADOWS:

  List<Shadow> get textShadow {
    return [
      Shadow(
        color: _myAlmostBlack,
        offset: Offset(0, 3),
        blurRadius: 6,
      )
    ];
  }

//-------------------------------------------------
  // final shadowColor = const Color(0x29000000);

  // NOTE: create your own swatch with primaryColor, or create your own material color:
  // final MaterialColor myDarkGreen = const MaterialColor(
  //   0xff004445,
  //   const <int, Color>{
  //     100: const Color(0xff2c786c),
  //     // Add more shades
  //   },
  // );
}
