import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/imp_data_provider.dart';
import '../screens/water_screen.dart';
import '../helpers/my_colors.dart';
import '../widgets/text_overlay.dart';

class GridItemWater extends StatefulWidget {
  final double height;
  final double width;
  GridItemWater({
    @required this.height,
    @required this.width,
  });
  @override
  _GridItemWaterState createState() => _GridItemWaterState();
}

class _GridItemWaterState extends State<GridItemWater> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ImpDataProvider>(context, listen: false)
          .fetchAndSetImpData(),
      builder: (ctx, snapshot) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(WaterScreen.routName);
        },
        onLongPress: () {
          setState(() {
            Provider.of<ImpDataProvider>(context, listen: false).addAGlass();
          });
          // print(Provider.of<ImpDataProvider>(context,listen: false).impDataOfTheDay.water);
        },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        // the radious of this should match the radious of the child
        child: Container(
            width: widget.width,
            height: widget.height,
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
            child: Consumer<ImpDataProvider>(builder: (ctx, impdata, _) {
              double heightFactor = impdata.getheightFactor();
              double percentage = impdata.getPercentage();

              return Stack(
                children: <Widget>[
                  Positioned.fill(
                    // this is here to make alignment work
                    child: FractionallySizedBox(
                      heightFactor: heightFactor,
                      alignment: Alignment.bottomCenter,
                      child: percentage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: (heightFactor >= 1)
                                    ? Radius.circular(10)
                                    : Radius.zero,
                                topRight: (heightFactor >= 1)
                                    ? Radius.circular(10)
                                    : Radius.zero,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors().myLightBlue),
                              ),
                            )
                          : ClipRRect(),
                    ),
                  ),
                  (percentage != null)
                      ? TextOverlay(
                          '${(percentage * 100).round()}%',
                          40,
                          percentage < 0.05
                              ? '\nlong press\nto add ${(ImpDataProvider().waterGlass100)} ml'
                              : 'Water intake)',
                              // : 'Water intake\n(${(ImpDataProvider().waterGlass100)} ml)',
                          10,
                        )
                      : TextOverlay('Set goal', 40, 'tap', 10)
                ],
              );
            })),
      ),
    );
  }
}
