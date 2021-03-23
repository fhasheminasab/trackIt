import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import '../helpers/audio_player.dart';

class NowPlayingScreen extends StatelessWidget {
  static const String routName = '/now_playing_screen';
  @override
  Widget build(BuildContext context) {
    final routArgs = ModalRoute.of(context).settings.arguments as List<int>;

    return AudioServiceWidget(
      child: NowPlayingScreen2(routArgs: routArgs ?? [null, null]),
    );
  }
}

class NowPlayingScreen2 extends StatefulWidget {
  final routArgs;
  const NowPlayingScreen2({this.routArgs});
  @override
  _NowPlayingScreen2State createState() => _NowPlayingScreen2State();
}

class _NowPlayingScreen2State extends State<NowPlayingScreen2> {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);
  @override
  Widget build(BuildContext context) {
    // final routArgs = ModalRoute.of(context).settings.arguments as List<int>;
    int index = widget.routArgs[0] ?? -1;
    int pos = widget.routArgs[1] ?? -1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Your Mood'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(20.0),
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
            // if (snapshot.data.mediaItem.artUri == null) {
            //   return Container(
            //     color: MyColors().bgColor,
            //     child: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // }

            if ((pos != -1) && (index != -1) && (pos != index)) {
              if (pos > index) {
                AudioService.skipToPrevious();
                pos--;
              }
              if (pos < index) {
                AudioService.skipToNext();
                pos++;
              }
            }
            return Container(
              width: double.infinity,
              // MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ...[
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 250,
                      width: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: processingState == AudioProcessingState.none
                            ? Image.asset('assets/images/music_placeholder.png')
                            : FadeInImage(
                                placeholder: AssetImage(
                                    'assets/images/music_placeholder.png'),
                                image: NetworkImage(mediaItem.artUri),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),

                    SizedBox(height: 15),
                    if (mediaItem?.title != null) Text(mediaItem.title),
                    if (mediaItem?.title != null)
                      Text(mediaItem.artist,
                          style: Theme.of(context).textTheme.caption),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.stop_rounded),
                        //   iconSize: 64.0,
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //     AudioService.stop();
                        //   },
                        // ),
                        !playing
                            ? IconButton(
                                icon: Icon(Icons.play_arrow_rounded),
                                iconSize: 64.0,
                                onPressed: AudioService.play,
                              )
                            : IconButton(
                                icon: Icon(Icons.pause_rounded),
                                iconSize: 64.0,
                                onPressed: AudioService.pause,
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.skip_previous),
                              iconSize: 64,
                              onPressed: () {
                                if (mediaItem == queue.first) {
                                  return;
                                }
                                AudioService.skipToPrevious();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_next),
                              iconSize: 64,
                              onPressed: () {
                                if (mediaItem == queue.last) {
                                  return;
                                }
                                AudioService.skipToNext();
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    processingState == AudioProcessingState.none
                        ? Container(
                          height: 30,
                        )
                        : positionIndicator(mediaItem, playbackState),
                    // //Shuffle:
                    // SizedBox(height: 8.0),
                    // Row(
                    //   children: [
                    //     StreamBuilder<LoopMode>(
                    //       stream: _player.loopModeStream,
                    //       builder: (context, snapshot) {
                    //         final loopMode = snapshot.data ?? LoopMode.off;
                    //         const icons = [
                    //           Icon(Icons.repeat, color: Colors.grey),
                    //           Icon(Icons.repeat, color: Colors.orange),
                    //           Icon(Icons.repeat_one, color: Colors.orange),
                    //         ];
                    //         const cycleModes = [
                    //           LoopMode.off,
                    //           LoopMode.all,
                    //           LoopMode.one,
                    //         ];
                    //         final index = cycleModes.indexOf(loopMode);
                    //         return IconButton(
                    //           icon: icons[index],
                    //           onPressed: () {
                    //             _player.setLoopMode(cycleModes[
                    //                 (cycleModes.indexOf(loopMode) + 1) %
                    //                     cycleModes.length]);
                    //           },
                    //         );
                    //       },
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         "Playlist",
                    //         style: Theme.of(context).textTheme.headline6,
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     StreamBuilder<bool>(
                    //       stream: _player.shuffleModeEnabledStream,
                    //       builder: (context, snapshot) {
                    //         final shuffleModeEnabled = snapshot.data ?? false;
                    //         return IconButton(
                    //           icon: shuffleModeEnabled
                    //               ? Icon(Icons.shuffle, color: Colors.orange)
                    //               : Icon(Icons.shuffle, color: Colors.grey),
                    //           onPressed: () {
                    //             _player
                    //                 .setShuffleModeEnabled(!shuffleModeEnabled);
                    //           },
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ]
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
        Duration duration2 = mediaItem?.duration;
        Duration _remaining = duration2 - state.currentPosition;
        String _remaining2 = _remaining.toString();
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
            // Text("${state.currentPosition}"),

            Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                        .firstMatch("$_remaining2")
                        ?.group(1) ??
                    '$_remaining2',
                style: Theme.of(context).textTheme.caption),
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
