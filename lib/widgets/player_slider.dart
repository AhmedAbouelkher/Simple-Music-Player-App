import 'package:flutter/material.dart';
import 'package:simple_music_player/appTheme.dart';
import 'package:simple_music_player/Helpers/Extensions.dart';

class PositionSeeSlider extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final void Function(Duration) seekTo;
  final Color sliderMainColor;

  const PositionSeeSlider({
    @required this.currentPosition,
    @required this.duration,
    @required this.seekTo,
    this.sliderMainColor,
  });

  @override
  _PositionSeeSliderState createState() => _PositionSeeSliderState();
}

class _PositionSeeSliderState extends State<PositionSeeSlider> {
  Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeeSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            bottom: 35,
            left: 1,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    widget.currentPosition.mmSSFormat,
                    style: AppTheme.mainTextStyle.copyWith(fontSize: 11),
                  ),
                  Text(
                    widget.duration.mmSSFormat,
                    style: AppTheme.mainTextStyle.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xffEB570D),
              inactiveTrackColor: Colors.black45,
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 7.0,
              thumbColor: Colors.orange[600],
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayColor: Colors.transparent,
            ),
            child: Slider(
              min: 0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: percent * widget.duration.inMilliseconds.toDouble(),
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInterraction = false;
                  widget.seekTo(_visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInterraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  final to = Duration(milliseconds: newValue.floor());
                  _visibleValue = to;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class PlayerSlider extends StatelessWidget {
//   PlayerSlider(
//       {this.value,
//       this.max,
//       this.onChanged,
//       this.min = 0.0,
//       this.playerPosition = 'Error',
//       this.playerDuration = 'Error'});
//   final double value;
//   final double max;
//   final double min;
//   final String playerPosition;
//   final String playerDuration;
//   final ValueChanged<double> onChanged;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Stack(
//         overflow: Overflow.visible,
//         children: <Widget>[
//           Positioned(
//             bottom: 35,
//             left: 1,
//             right: 0,
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 22),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Text(
//                     playerPosition,
//                     style: AppTheme.mainTextStyle.copyWith(fontSize: 11),
//                   ),
//                   Text(playerDuration,
//                       style: AppTheme.mainTextStyle.copyWith(fontSize: 11)),
//                 ],
//               ),
//             ),
//           ),
//           SliderTheme(
//             data: SliderTheme.of(context).copyWith(
//               activeTrackColor: Color(0xffEB570D),
//               inactiveTrackColor: Colors.black45,
//               trackShape: RoundedRectSliderTrackShape(),
//               trackHeight: 7.0,
//               thumbColor: Colors.orange[600],
//               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
//               overlayColor: Colors.transparent,
//             ),
//             child: Slider(
//               value: value,
//               max: max,
//               min: min,
//               onChanged: onChanged,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
