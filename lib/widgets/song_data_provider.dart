import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_player/Controllers/songs_control_panel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

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