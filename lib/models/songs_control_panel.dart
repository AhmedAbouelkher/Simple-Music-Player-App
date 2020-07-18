import 'dart:collection';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_music_player/Models/song.dart';

class SongsControlPanel extends ChangeNotifier {
  AssetsAudioPlayer _assetsAudioPlayer;
  SongsControlPanel() {
    if (_assetsAudioPlayer == null) _assetsAudioPlayer = AssetsAudioPlayer();
  }
  AssetsAudioPlayer get assetsAudioPlayer => _assetsAudioPlayer;

  UnmodifiableListView<Song> get songs {
    return UnmodifiableListView(_songs);
  }

  void playSong(int index) async {
    await this._assetsAudioPlayer?.playOrPause();
    notifyListeners();
  }

  void play(int index) async {
    await this._assetsAudioPlayer?.stop();
    await this._assetsAudioPlayer?.open(songs[index].audio, autoStart: true);
  }

  void playPlaylist() async {
    List<Audio> _audio = [];
    await this._assetsAudioPlayer?.stop();
    for (var song in songs) {
      _audio.add(song.audio);
    }
    await this._assetsAudioPlayer?.open(
          Playlist(audios: _audio),
          loopMode: LoopMode.playlist,
        );
  }

  void stop() async {
    await this._assetsAudioPlayer?.stop();
  }

  void changeSpeed(double speed) async {
    await this._assetsAudioPlayer.forwardOrRewind(speed);
  }

  List<Song> _songs = [
    Song(
      title: 'Little Idea',
      artist: 'Benjamin Tissot',
      path: 'assets/music/bensound-littleidea.mp3',
      coverPath: 'assets/cover/littleidea.jpg',
    ),
    Song(
      title: 'Jazzy Frenchy',
      artist: 'Benjamin Tissot',
      path: 'assets/music/bensound-jazzyfrenchy.mp3',
      coverPath: 'assets/cover/jazzyfrenchy.jpg',
    ),
    Song(
      title: 'Happy Rock',
      artist: 'Benjamin Tissot',
      path: 'assets/music/bensound-happyrock.mp3',
      coverPath: 'assets/cover/happyrock.jpg',
    ),
    Song(
      title: 'Summer',
      artist: 'Benjamin Tissot',
      path: 'assets/music/bensound-summer.mp3',
      coverPath: 'assets/cover/summer.jpg',
    ),
    Song(
      title: 'Ukulele',
      artist: 'Benjamin Tissot',
      path: 'assets/music/bensound-ukulele.mp3',
      coverPath: 'assets/cover/ukulele.jpg',
    ),
    Song(
      title: 'a New Beginning',
      artist: 'Benjamin Tissot',
      path: 'assets/music/bensound-anewbeginning.mp3',
      coverPath: 'assets/cover/anewbeginning.jpg',
    ),
    Song(
      title: 'Creative Minds',
      artist: 'Benjamin Tissot',
      path: 'assets/music/bensound-creativeminds.mp3',
      coverPath: 'assets/cover/creativeminds.jpg',
    ),
  ];
}
