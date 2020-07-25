import 'dart:collection';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_music_player/Helpers/SharedPerfsProvider.dart';
import 'package:simple_music_player/Models/song.dart';

class SongsControlPanel extends ChangeNotifier {
  AssetsAudioPlayer _assetsAudioPlayer;
  PreferenceUtils _prefs;
  SongsControlPanel() {
    if (_assetsAudioPlayer == null) _assetsAudioPlayer = AssetsAudioPlayer();
    if (_prefs == null) _prefs = PreferenceUtils.getInstance();
  }
  AssetsAudioPlayer get assetsAudioPlayer => _assetsAudioPlayer;

  UnmodifiableListView<Song> get songs => UnmodifiableListView(_songs);

  void playSong(int index) async {
    await this._assetsAudioPlayer?.playOrPause();
    notifyListeners();
  }

  void play(int index) async {
    await this._assetsAudioPlayer?.stop();
    await this._assetsAudioPlayer?.open(songs[index].audio, autoStart: true);
  }

  void playPlaylist({bool shuffle = false}) async {
    List<Audio> _audio = [];
    await this._assetsAudioPlayer?.stop();
    for (var song in songs) {
      if (song.audio.path != null) {
        song.audio.updateMetas(album: "Mamma Mia");
        _audio.add(song.audio);
      }
    }
    _audio = shuffle ? _shuffle(_audio) : _audio;
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

  Future<void> saveFavorite(String path, bool value) async {
    await _prefs.saveValueWithKey<bool>(path, value);
  }

  bool getFavorite(String path, {bool hideDebug = false}) {
    final bool value = _prefs.getValueWithKey(path, hideDebugPrint: hideDebug);
    return value ?? false;
  }

  List _shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
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
      title: 'A New Beginning',
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

  void disposePlayer() async {
    await this._assetsAudioPlayer?.dispose();
  }

  @override
  void dispose() {
    this._assetsAudioPlayer?.dispose();
    print("Audio Controller was Disposed {{Change Notifier}}");
    super.dispose();
  }
}
