import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_player/appTheme.dart';
import 'package:simple_music_player/models/songs_control_panel.dart';
import 'package:simple_music_player/widgets/button.dart';
import 'package:simple_music_player/widgets/song_avatar.dart';
import 'package:simple_music_player/widgets/song_brain.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    ScrollController _controller = ScrollController();
    void _scrollContollerAction() {
      var position = _controller.position.pixels;
      if (position > 265) {
        Provider.of<ShowAppbars>(context, listen: false).showTopAppBar();
      } else {
        Provider.of<ShowAppbars>(context, listen: false).hideTopAppBar();
      }
      if (position == _controller.position.maxScrollExtent) {
        Provider.of<ShowAppbars>(context, listen: false).hideBottomAppBar();
      } else {
        Provider.of<ShowAppbars>(context, listen: false).showBottomAppBar();
      }
    }

    bool showTopAppBar = Provider.of<ShowAppbars>(context).showTopAppbar;
    bool showbottomAppBar = Provider.of<ShowAppbars>(context).showBottomAppbar;
    return Scaffold(
      backgroundColor: Color(0xFF343A3F),
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            NotificationListener<ScrollUpdateNotification>(
              onNotification: (_) {
                _scrollContollerAction();
              },
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: SongPlayingHeader(),
                  ),
                  SliverToBoxAdapter(),
                  SongsListBuilder(),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 400),
              opacity: showTopAppBar ? 1 : 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  elevation: 10,
                  child: Container(
                    height: screenHeight * 0.034,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            showbottomAppBar
                ? AnimatedOpacity(
                    opacity: showbottomAppBar ? 1 : 0,
                    duration: Duration(milliseconds: 400),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.primaryColor.withOpacity(0.2),
                              AppTheme.primaryColor.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class SongPlayingHeader implements SliverPersistentHeaderDelegate {
  double _calculateShrinking(double shrinkOffset, double initialRaduis,
      {double speedFactor = 2.5}) {
    double circleRadius = initialRaduis - (shrinkOffset / speedFactor);
    return circleRadius < 30 ? 30 : circleRadius;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double textScale = 1 - (shrinkOffset / 300);
    double sideButtonsOpacity =
        (1 - (shrinkOffset / 170)) < 0 ? 0 : (1 - (shrinkOffset / 170));
    double sideButtonsPadding = 25 + (shrinkOffset / 6);
    double sideButtonsScale = 1 - (shrinkOffset / 400);

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: EdgeInsets.only(top: 30, bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: sideButtonsPadding),
      // color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Transform.scale(
              scale: textScale,
              child: Text(
                '\n\n' + 'EVOL - FUTURE',
                style: AppTheme.mainTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Transform.scale(
                  scale: sideButtonsScale,
                  child: Opacity(
                    opacity: sideButtonsOpacity,
                    child: AudioPlayerButton(
                      buttonRadius: 25,
                      icon: Icons.favorite,
                      iconSize: 15,
                      onTap: () {
                        print("favorite");
                      },
                    ),
                  ),
                ),
                Opacity(
                  opacity: sideButtonsOpacity,
                  child: SongAvatar(
                    songCoverPath: Provider.of<SongsControlPanel>(context)
                            .tempSongCoverPath ??
                        'assets/fire_flower.jpg',
                    radius:
                        _calculateShrinking(shrinkOffset, 80, speedFactor: 1.8),
                    imagePadding: 4,
                  ),
                ),
                Transform.scale(
                  scale: sideButtonsScale,
                  child: Opacity(
                    opacity: sideButtonsOpacity,
                    child: AudioPlayerButton(
                      buttonRadius: 25,
                      icon: Icons.more_horiz,
                      onTap: () {
                        print("see more");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 300;
  @override
  double get minExtent => 150;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}

class ShowAppbars extends ChangeNotifier {
  bool showTopAppbar = false;
  bool showBottomAppbar = true;
  void showTopAppBar() {
    showTopAppbar = true;
    notifyListeners();
  }

  void hideTopAppBar() {
    showTopAppbar = false;
    notifyListeners();
  }

  void showBottomAppBar() {
    showBottomAppbar = true;
    notifyListeners();
  }

  void hideBottomAppBar() {
    showBottomAppbar = false;
    notifyListeners();
  }
}
