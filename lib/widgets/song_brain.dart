import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_player/Views/player.dart';
import 'package:simple_music_player/models/page_transtion.dart';
import 'package:simple_music_player/models/songs_control_panel.dart';
import 'package:simple_music_player/widgets/button.dart';
import '../appTheme.dart';

const List<Color> colorGrad = [
  Color(0xff121416),
  Color(0xff2b3036),
  Color(0xff353b42),
];

class SongsListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongsControlPanel>(
      builder: (context, songData, child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final song = songData.songs[index];
              void _printReport() {
                print("Current Index: $index, isPlaying: ${song.isPlaying}");
              }

              return SongCard(
                songName: song.songName,
                songSubName: song.songSubName,
                onTap: () {
                  songData.selectSong(index);
                  songData.playSong(index);
                  songData.changeHomeCover(index);
                  _printReport();
                  Navigator.of(context).push(
                    createRoute(
                      Player(
                        songName: song.songName,
                        songSubName: song.songSubName,
                        songFilePath: song.songPath,
                        songCoverPath: song.songCoverPath,
                      ),
                    ),
                  );
                },
                isSelected: song.isSelected,
                onTapButton: () {
                  songData.playSong(index);
                  _printReport();
                },
                togglePlay: song.isPlaying,
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
      onTap: () => onTap(),
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
