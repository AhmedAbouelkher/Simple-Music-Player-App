import 'package:flutter/cupertino.dart';

class Song {
  Song({
    @required this.songName,
    @required this.songSubName,
    this.songPath,
    this.isPlaying = false,
    this.songCoverPath,
  });
  bool isPlaying;
  final String songName;
  final String songSubName;
  final String songPath;
  final String songCoverPath;

  void togglePlay() {
    isPlaying = !isPlaying;
  }
}
