import 'package:flutter/material.dart';
import 'package:simple_music_player/appTheme.dart';

// const List<Color> songAvatarColorGradient = [
//   Color(0xff191b1c),
//   Color(0xff464a4d)
// ];
const List<Color> songAvatarColorGradient = [
  Color(0xff30373D),
  Color(0xff30373D)
];

class SongAvatar extends StatelessWidget {
  SongAvatar(
      {this.radius = 80,
      this.spreadRadiusFactor = 6,
      this.blurRadiusFactor = 4,
      this.imagePadding = 4,
      this.songCoverPath});
  final double radius;
  final double spreadRadiusFactor;
  final double blurRadiusFactor;
  final double imagePadding;
  final String songCoverPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(imagePadding),
      child: CircleAvatar(
        backgroundColor: Color(0xff090504),
        child: ClipOval(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              '${songCoverPath ?? 'assets/cover/error404.png'}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        radius: radius,
      ),
      decoration: BoxDecoration(
        color: AppTheme().primaryColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Color(0xff5f6569),
            blurRadius: radius / blurRadiusFactor, //buttonRadius / 2.5
            spreadRadius: -radius / spreadRadiusFactor, //buttonRadius / 5.6
            offset: Offset(
              -radius / 5,
              -radius / 5,
            ), //buttonRadius / 5, buttonRadius / 5
          ),
          BoxShadow(
            color: Colors.black,
            blurRadius: radius / blurRadiusFactor, //buttonRadius / 2.5
            spreadRadius: -radius / spreadRadiusFactor, //buttonRadius / 5.6
            offset: Offset(
              radius / 6,
              radius / 5,
            ), //buttonRadius / 5, buttonRadius / 5
          ),
        ],
      ),
    );
  }
}
