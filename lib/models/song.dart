import 'package:flutter/cupertino.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Song {
  Song({
    @required this.title,
    @required this.artist,
    @required this.path,
    @required this.coverPath,
  });
  final String title;
  final String artist;
  final String path;
  final String coverPath;

  Metas get metas {
    return Metas(
      title: this.title,
      artist: this.artist,
      album: "Country Album",
      image: MetasImage.asset(
        this.coverPath,
      ),
    );
  }

  Audio get audio {
    return Audio(
      path,
      metas: this.metas,
    );
  }
}
