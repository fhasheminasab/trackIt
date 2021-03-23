import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import '../helpers/my_colors.dart';
import '../helpers/music_data.dart';
import 'now_playing_screen.dart';
import '../helpers/audio_player.dart';

class MoodScreen extends StatelessWidget {
  static const String routName = '/mood_screen';
  @override
  Widget build(BuildContext context) {
    return AudioServiceWidget(
      child: MoodScreen2(),
    );
  }
}

class MoodScreen2 extends StatefulWidget {
  @override
  _MoodScreen2State createState() =>
      _MoodScreen2State();
}

class _MoodScreen2State extends State<MoodScreen2> {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text('Balance Your Mood'),
    );
    double deviceHeight = ((MediaQuery.of(context).size.height) -
        (appbar.preferredSize.height) -
        (MediaQuery.of(context).padding.top));
    double deviceWidth = MediaQuery.of(context).size.width;
    double barHeight = deviceWidth / 5;
    double listViewHeight = deviceHeight - barHeight;
    return Scaffold(
      appBar: appbar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        // padding: EdgeInsets.all(20.0),
        child: StreamBuilder<AudioState>(
          stream: _audioStateStream,
          builder: (context, snapshot) {
            final audioState = snapshot.data;
            final queue = audioState?.queue;
            final mediaItem = audioState?.mediaItem;
            final playbackState = audioState?.playbackState;
            final processingState =
                playbackState?.processingState ?? AudioProcessingState.none;
            final playing = playbackState?.playing ?? false;
            if ((processingState == AudioProcessingState.none) && (!playing)) {
              MusicData().initAudioPlayer().then((_) {
                AudioService.pause();
              });
            }
            // if (_loading) {
            //   return Container(
            //     color: MyColors().bgColor,
            //     child: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // }
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: listViewHeight,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: MusicData().songs.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          margin: EdgeInsets.only(
                            top: 8,
                            left: 8,
                            right: 8,
                          ),
                          color: MyColors().myDarkbg,
                          // color: Color(0x01000000),
                          child: ListTile(
                            onTap: () async {
                              if (processingState ==
                                  AudioProcessingState.none) {
                                await MusicData().initAudioPlayer();
                              }
                              int pos = AudioService.queue.indexOf(mediaItem);
                              Navigator.of(context).pushNamed(
                                  NowPlayingScreen.routName,
                                  arguments: [index, pos]);
                            },
                            leading: Container(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: FadeInImage(
                                  height: 70,
                                  width: 60,
                                  placeholder: AssetImage(
                                      'assets/images/music_placeholder.png'),
                                  image: NetworkImage(
                                      MusicData().songs[index].artUri),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(MusicData().songs[index].title),
                            subtitle: Text(MusicData().songs[index].artist),
                          ),
                        );
                      },
                    ),
                  ),
                  // if (mediaItem?.title != null) Text(mediaItem.title),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      // bottomLeft: Radius.circular(10),
                      // bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      height: barHeight,
                      width: double.infinity,
                      // color: MyColors().myLightGreen,
                      color: Theme.of(context).primaryColor,
                      // color: Colors.amber[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                            onPressed: () async {
                              if (processingState ==
                                  AudioProcessingState.none) {
                                await MusicData().initAudioPlayer();
                                await AudioService.pause();
                              }
                              Navigator.of(context)
                                  .pushNamed(NowPlayingScreen.routName);
                            },
                            child: Container(
                              height: barHeight - 15,
                              width: barHeight - 15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: processingState ==
                                        AudioProcessingState.none
                                    ? Image.asset(
                                        'assets/images/music_placeholder.png',
                                        fit: BoxFit.cover,
                                      )
                                    : FadeInImage(
                                        placeholder: AssetImage(
                                            'assets/images/music_placeholder.png'),
                                        image: NetworkImage(mediaItem.artUri),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.stop_rounded),
                                iconSize: 45,
                                color: MyColors().myAmber,
                                tooltip: 'Stop the player',
                                // alignment: Alignment.center,
                                
                                onPressed: () {
                                  Navigator.pop(context);
                                  AudioService.stop();
                                },
                              ),
                              !playing
                                  ? IconButton(
                                      icon: Icon(Icons.play_arrow_rounded),
                                      iconSize: 45,
                                      color: MyColors().myAmber,
                                      tooltip:'Play',
                                      onPressed: AudioService.play,
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.pause_rounded),
                                      iconSize: 45,
                                      tooltip:'Pause',
                                      color: MyColors().myAmber,
                                      onPressed: AudioService.pause,
                                    ),
                              IconButton(
                                icon: Icon(Icons.skip_previous),
                                iconSize: 45,
                                color: MyColors().myAmber,
                                tooltip:'Play Previous',
                                onPressed: () {
                                  if (mediaItem == queue.first) {
                                    return;
                                  }
                                  AudioService.skipToPrevious();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.skip_next),
                                iconSize: 45,
                                tooltip:'Play Next',
                                color: MyColors().myAmber,
                                onPressed: () {
                                  if (mediaItem == queue.last) {
                                    return;
                                  }
                                  AudioService.skipToNext();
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    double seekPos;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 200)),
          (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        double position =
            snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
        return Column(
          children: [
            if (duration != null)
              Slider(
                min: 0.0,
                max: duration,
                value: seekPos ?? max(0.0, min(position, duration)),
                onChanged: (value) {
                  _dragPositionSubject.add(value);
                },
                onChangeEnd: (value) {
                  AudioService.seekTo(Duration(milliseconds: value.toInt()));
                  seekPos = value;
                  _dragPositionSubject.add(null);
                },
              ),
            Text("${state.currentPosition}"),
          ],
        );
      },
    );
  }
}

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
    (queue, mediaItem, playbackState) => AudioState(
      queue,
      mediaItem,
      playbackState,
    ),
  );
}
