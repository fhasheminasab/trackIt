import 'package:flutter/foundation.dart';
import '../helpers/database_helper.dart';
import '../models/exercise.dart';

class ExerciseProvider with ChangeNotifier {
  int whichPackAreWeIn;
  
  List<Exercise> get items {
    return [..._items];
  }

  Future<void> fetchAndSetExercises() async {
    final dataList = await DatabaseHelper.instance.getExerciseList();
    _items = [];
    _items = [...dataList];
    notifyListeners();
  }

  List<ExercisePack> get exDoneItems {
    return [..._exDoneItems];
  }

  Future<void> fetchAndSetExDone() async {
    List<ExercisePack> dataList = await DatabaseHelper.instance.getExDoneList();
    _exDoneItems = [];
    _exDoneItems = [...dataList];
    notifyListeners();
  }


  List<ExercisePack> _exDoneItems = [
    ExercisePack(
      done: 1,
      description: 'some information about the exercise.',
    ),
    ExercisePack(
      done: 1,
      description: 'some information about the exercise.',
    ),
    ExercisePack(
      done: 1,
      description: 'some information about the exercise.',
    ),
  ];

  List<Exercise> _items = [
    //To use URLs, change things in exercise_pack_screen.dart
    Exercise(
      title: '20 High Knees',
      imageUrl: 'assets/images/exercises/row-1-col-1.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQLHg',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '10-Count Plank Hold',
      imageUrl: 'assets/images/exercises/row-1-col-2.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQiUF',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '20 High Knees',
      imageUrl: 'assets/images/exercises/row-1-col-3.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQPl1',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '5 Calf Raises',
      imageUrl: 'assets/images/exercises/row-2-col-1.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQ6KP',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '10-Count Plank Hold',
      imageUrl: 'assets/images/exercises/row-2-col-2.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQQRa',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '5 Calf Raises',
      imageUrl: 'assets/images/exercises/row-2-col-3.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQZOJ',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '10 Reverse Lunges',
      imageUrl: 'assets/images/exercises/row-3-col-1.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQtDv',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '10-Count Plank Hold',
      imageUrl: 'assets/images/exercises/row-3-col-2.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQbxR',
      description: 'some extra info about the exercise',
    ),
    Exercise(
      title: '10 Reverse Lunges',
      imageUrl: 'assets/images/exercises/row-3-col-3.jpg',
      // imageUrl: 'https://freeimage.host/i/2UQmVp',
      description: 'some extra info about the exercise',
    ),
  ];
}
