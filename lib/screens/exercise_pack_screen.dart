import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/imp_data_provider.dart';
import '../helpers/database_helper.dart';
import '../providers/exercise_provider.dart';
import '../helpers/my_colors.dart';
import '../models/exercise.dart';

class ExercisePackScreen extends StatefulWidget {
  static const String routName = '/exercise-pack-screen';

  @override
  _ExercisePackScreenState createState() => _ExercisePackScreenState();
}

class _ExercisePackScreenState extends State<ExercisePackScreen> {

  Future<void> _refreshExDone(context) async {
    await Provider.of<ExerciseProvider>(context, listen: false)
        .fetchAndSetExDone();
  }

  int finaldone;
  Future<void> _submit(context) async {
    final int currentPackId =
        Provider.of<ExerciseProvider>(context, listen: false).whichPackAreWeIn;
    final ExercisePack currentPack =
        Provider.of<ExerciseProvider>(context, listen: false)
            .exDoneItems[currentPackId - 1];
    int done = currentPack.done;
    if (done == 1) {
      Provider.of<ImpDataProvider>(context, listen: false)
          .updateImpDataProvider(exercise: -1);
      setState(() {
        finaldone = 0;
      });
    } else if (done != 1) {
      Provider.of<ImpDataProvider>(context, listen: false)
          .updateImpDataProvider(exercise: 1);
      setState(() {
        finaldone = 1;
      });
    }

    ExercisePack ep = ExercisePack.withId(
      id: currentPack.id,
      done: finaldone,
      description: currentPack.description,
    );
    await DatabaseHelper.instance.updateExDone(ep);
    if (finaldone == 0) Navigator.of(context).pop();
  }

  Future<Widget> _doneIcon() async {
    await _refreshExDone(context);
    final int currentPackId =
        Provider.of<ExerciseProvider>(context, listen: false).whichPackAreWeIn;
    final int done = Provider.of<ExerciseProvider>(context, listen: false)
        .exDoneItems[currentPackId - 1]
        .done;
    if (done != 0)
      return Icon(
        Icons.done,
        color: MyColors().myDarkGreen,
      );
    return Text('Done!');
  }

  Widget _buildEx(Exercise ex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          ListTile(
            //To use these change data in exercise_provider.dart
            // leading: Image.network(
            //   ex.imageUrl,
            //   fit: BoxFit.cover,
            // ),
            leading: Image.asset(
              ex.imageUrl,
              fit: BoxFit.cover,
            ),
            title: Text(
              ex.title,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              '${ex.description}',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: null,
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: MyColors().bgColor,
          appBar: AppBar(
            title: Text(
                'Exercise ${Provider.of<ExerciseProvider>(context, listen: false).whichPackAreWeIn}'),
          ),
          floatingActionButton: FutureBuilder(
            future: _doneIcon(),
            builder: (ctx, snapshot) => FloatingActionButton(
              child: snapshot.data,
              onPressed: () {
                return _submit(context);
              },
            ),
          ),
          body: FutureBuilder(
            future: Provider.of<ExerciseProvider>(context, listen: false)
                .fetchAndSetExercises(),
            builder: (ctx, snapshot) {
              if ((snapshot.connectionState == ConnectionState.waiting)) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<ExerciseProvider>(
                builder: (ctxn, exerciseProvider, _) => ListView.builder(
                    itemCount: exerciseProvider.items.length +
                        1, //+1 cuz of that first card
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Stuff to do:',
                                style: TextStyle(
                                  color: MyColors().myDarkGray,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Have fun working out!',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return _buildEx(
                        exerciseProvider.items[index - 1],
                      );
                    }),
              );
            },
          )),
    );
  }
}
