import 'package:flutter/foundation.dart';

class Song {
  int id;
  String title;
  String artist;

  Song({
    @required this.title,
    @required this.artist,
  });
  Song.withId({
    this.id,
    this.title,
    this.artist,
  });

  //convert an instance to a map
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['artist'] = artist;
    return map;
  }

  //convert a map into an instance
  factory Song.fromMap(Map<String, dynamic> map) {
    return Song.withId(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
    );
  }
}
