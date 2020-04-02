import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:simple_music_player/models/song.dart';

class SongsControlPanel extends ChangeNotifier {
  List<Song> _songs = [
    Song(
      songName: 'Little Idea',
      songSubName: 'Benjamin Tissot',
      songPath: 'music/bensound-littleidea.mp3',
      songCoverPath: 'assets/cover/littleidea.jpg',
    ),
    Song(
      songName: 'Jazzy Frenchy',
      songSubName: 'Benjamin Tissot',
      songPath: 'music/bensound-jazzyfrenchy.mp3',
      songCoverPath: 'assets/cover/jazzyfrenchy.jpg',
    ),
    Song(
      songName: 'Happy Rock',
      songSubName: 'Benjamin Tissot',
      songPath: 'music/bensound-happyrock.mp3',
      songCoverPath: 'assets/cover/happyrock.jpg',
    ),
    Song(
      songName: 'Summer',
      songSubName: 'Benjamin Tissot',
      songPath: 'music/bensound-summer.mp3',
      songCoverPath: 'assets/cover/summer.jpg',
    ),
    Song(
      songName: 'Ukulele',
      songSubName: 'Benjamin Tissot',
      songPath: 'music/bensound-ukulele.mp3',
      songCoverPath: 'assets/cover/ukulele.jpg',
    ),
    Song(
      songName: 'a New Beginning',
      songSubName: 'Benjamin Tissot',
      songPath: 'music/bensound-anewbeginning.mp3',
      songCoverPath: 'assets/cover/anewbeginning.jpg',
    ),
    Song(
      songName: 'Creative Minds',
      songSubName: 'Benjamin Tissot',
      songPath: 'music/bensound-creativeminds.mp3',
      songCoverPath: 'assets/cover/creativeminds.jpg',
    ),
  ];

  UnmodifiableListView<Song> get songs {
    return UnmodifiableListView(_songs);
  }

  int prevInedx = 0;
  bool isStarted = false;
  void selectSong(int index) {
    _songs[index].toggleSelect();
    if (!isStarted) {
      prevInedx = index;
      isStarted = true;
    } else if (isStarted) {
      _songs[prevInedx].toggleSelect();
      _songs[prevInedx].togglePlay();
      prevInedx = index;
    }
    notifyListeners();
  }

  void playSong(int index) {
    _songs[index].togglePlay();
    notifyListeners();
  }

  String tempSongCoverPath;
  void changeHomeCover(int index) {
    tempSongCoverPath = _songs[index].songCoverPath;
    notifyListeners();
  }
}
