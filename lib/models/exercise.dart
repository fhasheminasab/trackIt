import 'package:flutter/foundation.dart';

class Exercise {
  int id;
  String title;
  String imageUrl; //or path
  String description;

  Exercise({
    @required this.title,
    @required this.imageUrl,
    @required this.description,
  });
  Exercise.withId({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    this.description,
  });
  //convert an instance to a map
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['image_url'] = imageUrl;
    map['description'] = description;
    return map;
  }

  //convert a map into an instance
  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise.withId(
      id: map['id'],
      title: map['title'],
      imageUrl: map['image_url'],
      description: map['description'],
    );
  }
}

//Add list of Exercises to this if possible:
class ExercisePack {
  int id;
  // List<Exercise> listOfExs;
  int done;
  String description;

  ExercisePack({
    // @required this.listOfExs,
    this.done,
    this.description,
  });
  ExercisePack.withId({
    @required this.id,
    // @required this.listOfExs,
    this.done,
    this.description,
  });

// List<int> get _listOfIds{
//   List<int> listOfIds;
//   listOfExs.forEach((ex) => listOfIds.add(ex.id));
// }

  //convert an instance to a map
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['done'] = done;
    map['description'] = description;
    // map['list_of_exercises'] = _listOfIds;

    return map;
  }

  //convert a map into an instance
  factory ExercisePack.fromMap(Map<String, dynamic> map) {
    return ExercisePack.withId(
      id: map['id'],
      done: map['done'],
      description: map['description'],
      // listOfExs: map['list_of_exercises'].toList?.......whaaat?
    );
  }
}
