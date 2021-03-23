import 'package:flutter/material.dart';
import '../helpers/my_colors.dart';

class FactCard extends StatelessWidget {
  final text;
  const FactCard(this.text);
  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 5), //25,5
      elevation: 1,
      shadowColor: MyColors().myAmber,
      child: Container(
        width: double.infinity,
        // height: 65,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18, //20
            fontFamily: 'Segoe UI',
            // fontWeight: FontWeight.bold,
            color: Colors.black,
            // color: const Color(0xff484848),
          ),
        ),
      ),
    );
  }
}

