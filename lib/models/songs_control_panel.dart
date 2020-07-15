import 'dart:collection';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_music_player/Models/song.dart';

class SongsControlPanel extends ChangeNotifier {
  final AssetsAudioPlayer _assetsAudioPlayer;
  SongsControlPanel(this._assetsAudioPlayer);
  AssetsAudioPlayer get assetsAudioPlayer => _assetsAudioPlayer;
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
    // Song(
    //   songName: 'Summer',
    //   songSubName: 'Benjamin Tissot',
    //   songPath: 'music/bensound-summer.mp3',
    //   songCoverPath: 'assets/cover/summer.jpg',
    // ),
    // Song(
    //   songName: 'Little Idea',
    //   songSubName: 'Benjamin Tissot',
    //   songPath: 'music/bensound-littleidea.mp3',
    //   songCoverPath: 'assets/cover/littleidea.jpg',
    // ),
    // Song(
    //   songName: 'Ukulele',
    //   songSubName: 'Benjamin Tissot',
    //   songPath: 'music/bensound-ukulele.mp3',
    //   songCoverPath: 'assets/cover/ukulele.jpg',
    // ),
  ];

  UnmodifiableListView<Song> get songs {
    return UnmodifiableListView(_songs);
  }

  int prevInedx = 0;
  bool isStarted = false;
  void selectSong(int index) {
    if (!isStarted) {
      prevInedx = index;
      isStarted = true;
    } else if (isStarted) {
      final song = _songs[prevInedx];
      if (song.isPlaying) song.togglePlay();
      prevInedx = index;
    }
    notifyListeners();
  }

  void playSong(int index) async {
    songs[index].togglePlay();
    await this._assetsAudioPlayer?.playOrPause();
    notifyListeners();
  }

  String tempSongCoverPath;
  void changeHomeCover(int index) {
    tempSongCoverPath = songs[index].songCoverPath;
    notifyListeners();
  }

  void play(int index) async {
    selectSong(index);
    playSong(index);
    changeHomeCover(index);
    await this._assetsAudioPlayer?.open(
          Audio("assets/" + songs[index].songPath),
          autoStart: true,
        );
  }

  void stop() async {
    await this._assetsAudioPlayer?.stop();
  }
}
