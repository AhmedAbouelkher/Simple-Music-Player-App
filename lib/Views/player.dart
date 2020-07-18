import 'package:after_layout/after_layout.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_player/Models/songs_control_panel.dart';
import 'package:simple_music_player/Widgets/player_slider.dart';
import 'package:simple_music_player/Widgets/song_brain.dart';
import 'package:simple_music_player/appTheme.dart';
import 'package:simple_music_player/widgets/button.dart';
import 'package:simple_music_player/widgets/song_avatar.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with AfterLayoutMixin<Player> {
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            DataProvider<RealtimePlayingInfos>(
              builder: (context, realtimePlayingInfos) {
                if (realtimePlayingInfos == null) {
                  return Container();
                }
                final data =
                    realtimePlayingInfos.current.audio.audio.metas.image.path;
                return SongAvatar(
                  radius: 160,
                  blurRadiusFactor: 5,
                  spreadRadiusFactor: 4,
                  imagePadding: 5.5,
                  songCoverPath: data,
                );
              },
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 100,
                maxWidth: double.infinity,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DataProvider<RealtimePlayingInfos>(
                    builder: (context, realtimePlayingInfos) {
                      if (realtimePlayingInfos == null) {
                        return Text(
                          "loading...",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 29,
                              fontWeight: FontWeight.w500),
                        );
                      }
                      final data =
                          realtimePlayingInfos.current.audio.audio.metas;
                      return Opacity(
                        opacity: 0.9,
                        child: Text(
                          data.title,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 29,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 5),
                  DataProvider<RealtimePlayingInfos>(
                    builder: (context, realtimePlayingInfos) {
                      if (realtimePlayingInfos == null) {
                        return Text(
                          "loading...",
                          style: AppTheme.mainTextStyle.copyWith(fontSize: 15),
                        );
                      }
                      final data =
                          realtimePlayingInfos.current.audio.audio.metas;
                      return Opacity(
                        opacity: 0.9,
                        child: Text(
                          data.artist,
                          style: AppTheme.mainTextStyle.copyWith(fontSize: 15),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Consumer<SongsControlPanel>(
              builder: (BuildContext context, SongsControlPanel value,
                  Widget child) {
                return PlayerBuilder.realtimePlayingInfos(
                  player: value.assetsAudioPlayer,
                  builder: (context, realtimePlayingInfos) {
                    if (realtimePlayingInfos == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return PositionSeeSlider(
                      currentPosition: realtimePlayingInfos.currentPosition,
                      duration: realtimePlayingInfos.duration,
                      seekTo: (to) {
                        value.assetsAudioPlayer.seek(to);
                      },
                    );
                  },
                );
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
                    onTap: () =>
                        Provider.of<SongsControlPanel>(context, listen: false)
                            .changeSpeed(-2),
                    togglePlay: false,
                  ),
                  PlayerBuilder.isPlaying(
                    player: Provider.of<SongsControlPanel>(context)
                        .assetsAudioPlayer,
                    builder: (context, isPlaying) {
                      return AudioPlayerButton(
                        buttonRadius: 37,
                        iconSize: 25,
                        onTap: () {
                          Provider.of<SongsControlPanel>(context, listen: false)
                              .assetsAudioPlayer
                              .playOrPause();
                        },
                        togglePlay: isPlaying,
                      );
                    },
                  ),
                  // DataProvider(
                  //   builderType: BuilderType.speed,
                  //   builder: (context, data) {
                  //     final double d = data;
                  //     return Center(
                  //       child: Text(d.toString()),
                  //     );
                  //   },
                  // ),
                  AudioPlayerButton(
                    buttonRadius: 34,
                    icon: Icons.fast_forward,
                    iconSize: 25,
                    onTap: () =>
                        Provider.of<SongsControlPanel>(context, listen: false)
                            .changeSpeed(2),
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
  void afterFirstLayout(BuildContext context) {}
}
