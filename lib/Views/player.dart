import 'package:after_layout/after_layout.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:simple_music_player/appTheme.dart';
import 'package:simple_music_player/widgets/button.dart';
import 'package:simple_music_player/widgets/player_slider.dart';
import 'package:simple_music_player/widgets/song_avatar.dart';

class Player extends StatefulWidget {
  Player({
    this.songName = 'Error',
    this.songSubName = 'Error',
    this.songFilePath = 'Error',
    this.songCoverPath,
  });
  final String songName;
  final String songSubName;
  final String songFilePath;
  final String songCoverPath;
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with AfterLayoutMixin<Player> {
  Duration _songFullDuration = Duration();
  Duration _songCurrentPlayingPosition = Duration();
  AudioPlayerState _playerCurrentStatus;
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() => _songCurrentPlayingPosition = p);
    });
    advancedPlayer.onDurationChanged.listen((d) {
      setState(() => _songFullDuration = d);
    });
    advancedPlayer.onPlayerStateChanged.listen((s) {
      setState(() => _playerCurrentStatus = s);
    });
    audioCache.load(widget.songFilePath);
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
    String twoDigitSeconds =
        twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  //Toggle Play and Pause with one Button
  bool isPlaying = false;
  void playOrPause() {
    if (_playerCurrentStatus == null) {
      audioCache.play(widget.songFilePath);
      setState(() => isPlaying = true);
    } else {
      if (_playerCurrentStatus == AudioPlayerState.PAUSED) {
        advancedPlayer.resume();
        setState(() => isPlaying = true);
      } else if (_playerCurrentStatus == AudioPlayerState.PLAYING) {
        advancedPlayer.pause();
        setState(() => isPlaying = false);
      }
    }
  }

  //toggle full stop
  void stop() {
    advancedPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  //goes to a point (second) in the current song.
  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AudioPlayerButton(
                    buttonRadius: 23,
                    icon: Icons.arrow_back,
                    onTap: () {
                      stop();
                      Navigator.pop(context);
                    },
                    iconSize: 18,
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      'PLAYING NOW',
                      style: AppTheme.mainTextStyle
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  AudioPlayerButton(
                    buttonRadius: 23,
                    icon: Icons.menu,
                    iconSize: 19,
                    onTap: () {
                      stop();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SongAvatar(
              radius: 160,
              blurRadiusFactor: 5,
              spreadRadiusFactor: 4,
              imagePadding: 5.5,
              songCoverPath: widget.songCoverPath,
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 100,
                maxWidth: double.infinity,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Opacity(
                    opacity: 0.9,
                    child: Text(
                      widget.songName,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 29,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.songSubName,
                    style: AppTheme.mainTextStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
            PlayerSlider(
              playerDuration: durationToString(_songFullDuration),
              playerPosition: durationToString(_songCurrentPlayingPosition),
              value: _songCurrentPlayingPosition.inSeconds.toDouble(),
              min: 0.0,
              max: _songFullDuration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  seekToSecond(value.toInt());
                  value = value;
                });
              },
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AudioPlayerButton(
                    buttonRadius: 34,
                    icon: Icons.fast_rewind,
                    iconSize: 25,
                    onTap: () {},
                    togglePlay: false,
                  ),
                  AudioPlayerButton(
                    buttonRadius: 37,
                    iconSize: 25,
                    onTap: () {
                      playOrPause();
                    },
                    togglePlay: isPlaying,
                  ),
                  AudioPlayerButton(
                    buttonRadius: 34,
                    icon: Icons.fast_forward,
                    iconSize: 25,
                    onTap: () {
                      stop();
                    },
                    togglePlay: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(milliseconds: 800), () {
      playOrPause();
      setState(() => isPlaying = true);
    });
  }
}
