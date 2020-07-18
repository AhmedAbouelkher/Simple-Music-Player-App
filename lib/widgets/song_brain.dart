import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_player/Models/page_transtion.dart';
import 'package:simple_music_player/Models/songs_control_panel.dart';
import 'package:simple_music_player/Views/player.dart';
import 'package:simple_music_player/widgets/button.dart';
import '../appTheme.dart';

const List<Color> colorGrad = [
  Color(0xff121416),
  Color(0xff2b3036),
  Color(0xff353b42),
];

class SongsListBuilder extends StatelessWidget {
  final AssetsAudioPlayer assetsAudioPlayer;

  const SongsListBuilder({Key key, @required this.assetsAudioPlayer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<SongsControlPanel>(
      builder: (context, songData, child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final song = songData.songs[index];
              return songData.assetsAudioPlayer.builderRealtimePlayingInfos(
                builder: (context, infos) {
                  final playing = infos?.current;
                  final bool isSelected =
                      song.path == playing?.audio?.assetAudioPath;
                  return SongCard(
                    songName: song.title,
                    songSubName: song.artist,
                    onTap: () {
                      if (!isSelected) songData.play(index);
                      Navigator.of(context).push(createRoute(Player()));
                    },
                    isSelected: isSelected,
                    onTapButton: () => songData.playSong(index),
                    togglePlay: isSelected && (infos?.isPlaying ?? false),
                  );
                },
              );
            },
            childCount: songData.songs.length,
          ),
        );
      },
    );
  }
}

class SongCard extends StatelessWidget {
  SongCard({
    @required this.songName,
    @required this.songSubName,
    this.songPath,
    this.isSelected = false,
    this.onTap,
    this.onTapButton,
    this.togglePlay,
  });
  final String songName;
  final String songSubName;
  final String songPath;
  final GestureTapCallback onTap;
  final bool isSelected;
  final VoidCallback onTapButton;
  final bool togglePlay;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color:
                isSelected ? Colors.grey.withOpacity(0.5) : Colors.transparent,
            width: 0.5,
          ),
          color: isSelected ? Color(0xff16181B) : Colors.transparent,
        ),
        child: Center(
          child: ListTile(
            title: Text(
              songName,
              style: AppTheme.mainTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            subtitle: Text(
              songSubName,
              style: AppTheme.mainTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white70.withOpacity(0.5),
              ),
            ),
            trailing: AudioPlayerButton(
              disable: isSelected ? false : true,
              buttonRadius: 22,
              iconSize: 17,
              togglePlay: togglePlay,
              onTap: onTapButton,
            ),
          ),
        ),
      ),
    );
  }
}

enum BuilderType { info, current, speed, playing }

typedef RealtimeWidgetBuilder<T> = Widget Function(
    BuildContext context, T data);

class DataProvider<T> extends StatelessWidget {
  final RealtimeWidgetBuilder<T> builder;
  final Widget child;
  final BuilderType builderType;
  const DataProvider({
    Key key,
    @required this.builder,
    this.child,
    this.builderType = BuilderType.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsControlPanel>(
      builder: (context, value, child) {
        switch (builderType) {
          case BuilderType.info:
            break;
          case BuilderType.current:
            return value.assetsAudioPlayer.builderCurrent(
              builder: (context, playing) {
                return builder(context, playing as T);
              },
            );
            break;
          case BuilderType.speed:
            return value.assetsAudioPlayer.builderForwardRewindSpeed(
              builder: (context, playSpeed) {
                return builder(context, playSpeed as T);
              },
            );
            break;
          case BuilderType.playing:
            return value.assetsAudioPlayer.builderIsPlaying(
              builder: (context, isPlaying) {
                return builder(context, isPlaying as T);
              },
            );
            break;
        }
        return value.assetsAudioPlayer.builderRealtimePlayingInfos(
          builder: (context, realtimePlayingInfos) {
            return builder(context, realtimePlayingInfos as T);
          },
        );
      },
      child: child,
    );
  }
}
