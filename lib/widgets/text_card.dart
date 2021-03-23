//builds a single info card

import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final String text;
  final String subText;

  const TextCard(this.text, this.subText);

  @override
  Widget build(BuildContext context) {
    return
    //  Dismissible(
    // key: null, //TODO
    // background: null,
    // direction: null,
    // confirmDismiss: null,
    // onDismissed: null,
    // child:
    Card(
      margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 5), //25,5
      // color: Color(Colors.white),
      elevation: 1,

      child: Container(
          width: double.infinity,
          height: 65,
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 18, //20
                  fontFamily: 'Segoe UI',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff484848),
                ),
              ),
              Text(
                ' ' + subText,
                style: TextStyle(
                  fontSize: 13, //14
                  fontFamily: 'Segoe UI',
                ),
                // style: TextStyle(fontSize: 11),
              ),
            ],
          )),
      // ),
    );
  }
}
