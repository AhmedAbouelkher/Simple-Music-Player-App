// import 'package:after_layout/after_layout.dart';
// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:simple_music_player/appTheme.dart';
// import 'package:simple_music_player/widgets/button.dart';
// import 'package:simple_music_player/widgets/player_slider.dart';
// import 'package:simple_music_player/widgets/song_avatar.dart';
// import 'package:simple_music_player/Helpers/Extensions.dart';

// class Player extends StatefulWidget {
//   Player({
//     this.songName = 'Error',
//     this.songSubName = 'Error',
//     this.songFilePath = 'Error',
//     this.songCoverPath,
//   });
//   final String songName;
//   final String songSubName;
//   final String songFilePath;
//   final String songCoverPath;
//   @override
//   _PlayerState createState() => _PlayerState();
// }

// class _PlayerState extends State<Player> with AfterLayoutMixin<Player> {
//   AudioPlayer advancedPlayer;
//   AudioCache audioCache;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _setState(VoidCallback state) {
//     if (mounted) {
//       setState(state);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.primaryColor,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 30),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   AudioPlayerButton(
//                     buttonRadius: 23,
//                     icon: Icons.arrow_back,
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     iconSize: 18,
//                   ),
//                   Opacity(
//                     opacity: 0.8,
//                     child: Text(
//                       'PLAYING NOW',
//                       style: AppTheme.mainTextStyle
//                           .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   AudioPlayerButton(
//                     buttonRadius: 23,
//                     icon: Icons.menu,
//                     iconSize: 19,
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             SongAvatar(
//               radius: 160,
//               blurRadiusFactor: 5,
//               spreadRadiusFactor: 4,
//               imagePadding: 5.5,
//               songCoverPath: widget.songCoverPath,
//             ),
//             Container(
//               constraints: BoxConstraints(
//                 maxHeight: 100,
//                 maxWidth: double.infinity,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Opacity(
//                     opacity: 0.9,
//                     child: Text(
//                       widget.songName,
//                       style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 29,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     widget.songSubName,
//                     style: AppTheme.mainTextStyle.copyWith(fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//             PlayerSlider(
//               playerDuration: ,
//               playerPosition:,
//               value: ,
//               min: 0.0,
//               max: ,
//               onChanged: (double value) {
//               },
//             ),
//             SizedBox(height: 30),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 50),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   AudioPlayerButton(
//                     buttonRadius: 34,
//                     icon: Icons.fast_rewind,
//                     iconSize: 25,
//                     onTap: () {},
//                     togglePlay: false,
//                   ),
//                   AudioPlayerButton(
//                     buttonRadius: 37,
//                     iconSize: 25,
//                     onTap: () {
//                     },
//                     togglePlay: isPlaying,
//                   ),
//                   AudioPlayerButton(
//                     buttonRadius: 34,
//                     icon: Icons.fast_forward,
//                     iconSize: 25,
//                     onTap: () {
//                     },
//                     togglePlay: false,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void afterFirstLayout(BuildContext context) {
//   }
// }
