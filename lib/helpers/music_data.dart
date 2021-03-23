import 'package:audio_service/audio_service.dart';
import '../helpers/audio_player.dart';

class MusicData {
  final _queue = <MediaItem>[
    // from:
    // https://www.bensound.com/

    MediaItem(
      id: "https://www.bensound.com/bensound-music/bensound-thejazzpiano.mp3",
      album: "Single",
      title: "The Jazz Piano",
      artist: "Bensound",
      duration: Duration(seconds: 160),
      artUri: "https://www.bensound.com/bensound-img/thejazzpiano.jpg",
    ),

    MediaItem(
      id: "https://www.bensound.com/bensound-music/bensound-happyrock.mp3",
      album: "Single",
      title: "Happy Rock",
      artist: "Bensound",
      duration: Duration(seconds: 105),
      artUri: "https://www.bensound.com/bensound-img/happyrock.jpg",
    ),
    MediaItem(
      id: "https://www.bensound.com/bensound-music/bensound-sunny.mp3",
      album: "Single",
      title: "Sunny",
      artist: "Bensound",
      duration: Duration(seconds: 140),
      artUri: "https://www.bensound.com/bensound-img/sunny.jpg",
    ),
    MediaItem(
      id: "https://www.bensound.com/bensound-music/bensound-anewbeginning.mp3",
      album: "Single",
      title: "A New Beginning",
      artist: "Bensound",
      duration: Duration(seconds: 154),
      artUri: "https://www.bensound.com/bensound-img/anewbeginning.jpg",
    ),
    MediaItem(
      id: "https://www.bensound.com/bensound-music/bensound-ukulele.mp3",
      album: "Single",
      title: "Ukulele",
      artist: "Bensound",
      duration: Duration(seconds: 146),
      artUri: "https://www.bensound.com/bensound-img/ukulele.jpg",
    ),
    MediaItem(
      id: "https://goo.gl/5RQjTQ",
      album: "Single",
      title: "The Elevator Bossa Nova",
      artist: "Bensound",
      duration: Duration(seconds: 255),
      artUri: "https://goo.gl/Wd1yPP",
    ),
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
      album: "Science Friday",
      title: "A Salute To Head-Scratching Science",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 5739820),
      artUri:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3",
      album: "Science Friday",
      title: "From Cat Rheology To Operatic Incompetence",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 2856950),
      artUri:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ];

  List<MediaItem> get songs {
    return [..._queue];
  }

  Future<void> initAudioPlayer() async {
    List<dynamic> list = List();
    for (int i = 0; i < _queue.length; i++) {
      var m = _queue[i].toJson();
      list.add(m);
    }
    var params = {"data": list};
    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Player',
      androidNotificationColor: 0xFF004445, //0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
      params: params,
      androidStopForegroundOnPause: true,
      // androidNotificationChannelDescription: 
    );
  }
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
