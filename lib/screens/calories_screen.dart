import 'package:flutter/material.dart';
import '../helpers/my_colors.dart';
import '../widgets/fact_card.dart';

class CaloriesScreen extends StatelessWidget {
  static const String routName = '/calories-screen';

  @override
  Widget build(BuildContext context) {
    // String number = '+989120581875';
    var appbar = AppBar(
      title: Text('Calories'),
    );
    double deviceHeight = ((MediaQuery.of(context).size.height) -
        (appbar.preferredSize.height) -
        (MediaQuery.of(context).padding.top));
    double listViewHeight = deviceHeight - 10;
    List<String> calorieFacts = [
      //from: https://kmmsam.com/friday-fun-facts-about-burning-calories/#:~:text=You%20will%20burn%20more%20calories,off%2011%20calories%20per%20hour.

      'Do you sing in the shower? You can burn 10-20 calories per song depending on how loud you sing and your level of pitch.',
      'On hour in front of the TV doing nothing will burn about 65 calories.',
      'Do you enjoy mindless sitcoms? You can burn 20-40 calories for each 10 minutes you spend laughing.',
      'Hugging for an hour can burn up to 70 calories.',
      'A one-minute kiss will burn 2 to 4 calories depending on how passionate it is. Which might lead us to the next fact.',
      'Thirty minutes of sex will burn a hefty 200 calories. Anyone up for an hour?',
      'With Trump as president, liberals can burn up to 150 calories per hour banging their heads against the wall.',
      'You can burn 10 calories for every 3 minutes you spend brushing your teeth.',
      'Pushing a shopping cart around the store for half and hour will take 100 calories off your swelling frame. Even more as the cart gets heavier with groceries or other merchandise. Chocolate is heavy I’d go for that.',
      'You will burn more calories eating the celery than there are calories in the celery.',
      'You’ll burn about 7 percent more calories walking on dirt than you will on a sidewalk, or pavement.',
      'An easy way to burn 100 calories is to take the dog for a 30-minute walk.',
      'Chewing a stick of gum will burn off 11 calories per hour.',
    ];
    return Scaffold(
      appBar: appbar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: MyColors().myDarkbg,
            ),
            width: double.infinity,
            height: listViewHeight,
            child: ListView.builder(
              itemCount: calorieFacts.length,
              itemBuilder: (ctx, index) {
                return FactCard(calorieFacts[index]);
                // return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
