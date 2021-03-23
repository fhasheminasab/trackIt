//builds all info cards to view

import 'package:flutter/material.dart';
import '../widgets/text_card.dart';

class InfoCards extends StatefulWidget {
  bool firstTime = true;
  @override
  _InfoCardsState createState() => _InfoCardsState();
}

class _InfoCardsState extends State<InfoCards> {
  // List<TextCard> textCards = [];

  // void _addInitialCards() {
  //   textCards.add(TextCard('Inform others when heart rate annomallies happen',
  //       'what time of the day and in what temperature?'));
  //   textCards.add(TextCard('Set the best time for a walk',
  //       'what time of the day and in what temperature?'));
  // }

  @override
  Widget build(BuildContext context) {
    // if (widget.firstTime) {
    //   setState(() {
    //     _addInitialCards();
    //     widget.firstTime = false;
    //   });
    // }
    return Column(
      // children: textCards,
      //TODO uncomment the line above and delete all these lines below:
      children: [
        TextCard('Set the best time for a walk',
            'what time of the day and in what temperature?'),
        TextCard('Notice heart rate anomallies',
            'Inform others when heart rate anomallies happen')
      ],
    );
  }
}
