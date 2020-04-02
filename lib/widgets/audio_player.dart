// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:simple_music_player/widgets/player_slider.dart';

// typedef void OnError(Exception exception);

// class AudioPlayerBrain extends StatefulWidget {
//   AudioPlayerBrain({this.path});
//   final String path;
//   @override
//   _LocalAudio createState() => _LocalAudio();
// }

// class _LocalAudio extends State<AudioPlayerBrain> {
//   Duration _duration = Duration();
//   Duration _position = Duration();
//   var _state;
//   AudioPlayer advancedPlayer;
//   AudioCache audioCache;
//   @override
//   void initState() {
//     super.initState();
//     advancedPlayer = AudioPlayer();
//     audioCache = AudioCache(fixedPlayer: advancedPlayer);
//     advancedPlayer.onAudioPositionChanged.listen((p) {
//       setState(() => _position = p);
//     });
//     advancedPlayer.onDurationChanged.listen((d) {
//       setState(() => _duration = d);
//     });
//     advancedPlayer.onPlayerStateChanged.listen((s) {
//       setState(() => _state = s);
//     });
//   }

//   String durationToString(Duration duration) {
//     String twoDigits(int n) {
//       if (n >= 10) return "$n";
//       return "0$n";
//     }

//     String twoDigitMinutes =
//         twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
//     String twoDigitSeconds =
//         twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }

//   //Toggle Play and Pause with one Button
//   bool isPlaying = false;
//   void playOrPause(String path) {
//     if (isPlaying == false) {
//       audioCache.play(path);
//       setState(() => isPlaying = true);
//     } else {
//       advancedPlayer.pause();
//       setState(() => isPlaying = false);
//     }
//   }

//   //toggle full stop
//   void stop() {
//     advancedPlayer.stop();
//     isPlaying = false;
//   }

//   //goes to a point (second) in the current song.
//   void seekToSecond(int second) {
//     Duration newDuration = Duration(seconds: second);
//     advancedPlayer.seek(newDuration);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ,
//     );
//   }
// }

// // PlayerSlider(
// //         playerDuration: _duration.inSeconds.toDouble(),
// //         playerPosition: _position.inSeconds.toDouble(),
// //         value: _position.inSeconds.toDouble(),
// //         min: 0.0,
// //         max: _duration.inSeconds.toDouble(),
// //         onChanged: (double value) {
// //           setState(() {
// //             seekToSecond(value.toInt());
// //             value = value;
// //           });
// //         },
// //       )
