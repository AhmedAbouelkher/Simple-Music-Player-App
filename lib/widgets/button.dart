import 'package:flutter/material.dart';

const List<Color> play = [Color(0xff191b1c), Color(0xff464a4d)];
// const List<Color> pause = [Color(0xffff731c), Color(0xff8c3600)];
const List<Color> pause = [Color(0xffEB570D), Color(0xffCA2913)];

// typedef VoidCallback = void Function();
// final VoidCallback onTap;

class AudioPlayerButton extends StatelessWidget {
  AudioPlayerButton({
    @required this.buttonRadius,
    this.iconSize,
    this.iconColor,
    this.onTap,
    this.playingColors,
    this.pausingColors,
    this.icon,
    this.disable = false,
    this.togglePlay = false,
  });
  final bool disable;
  final bool togglePlay;
  final double buttonRadius;
  final double iconSize;
  final List<Color> playingColors;
  final List<Color> pausingColors;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(buttonRadius), //buttonRadius
      onTap: disable ? null : onTap,
      child: Container(
        height: buttonRadius * 2, //buttonRadius * 2
        width: buttonRadius * 2, //buttonRadius * 2
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(buttonRadius), //buttonRadius
          gradient: LinearGradient(
            colors: togglePlay ? pausingColors ?? pause : playingColors ?? play,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff5f6569),
              blurRadius: buttonRadius / 2.5, //buttonRadius / 2.5
              spreadRadius: -buttonRadius / 5.6, //buttonRadius / 5.6
              offset: Offset(
                -buttonRadius / 5,
                -buttonRadius / 5,
              ), //buttonRadius / 5, buttonRadius / 5
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: buttonRadius / 2.5, //buttonRadius / 2.5
              spreadRadius: -buttonRadius / 5.6, //buttonRadius / 5.6
              offset: Offset(
                buttonRadius / 6,
                buttonRadius / 5,
              ), //buttonRadius / 5, buttonRadius / 5
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: buttonRadius * 1.8, //buttonRadius * 1.8
            width: buttonRadius * 1.8, //buttonRadius * 1.8
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    togglePlay ? pausingColors ?? pause : playingColors ?? play,
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.circular(buttonRadius), //buttonRadius
            ),
            child: Container(
              child: Center(
                child: Icon(
                  icon ?? (togglePlay ? Icons.pause : Icons.play_arrow),
                  size: iconSize ?? buttonRadius,
                  color: iconColor ?? Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
