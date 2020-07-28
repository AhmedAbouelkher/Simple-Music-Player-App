import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:simple_music_player/Controllers/songs_control_panel.dart';
import 'package:simple_music_player/Views/song_brain.dart';
import 'package:simple_music_player/Widgets/buttom_panel_options.dart';
import 'package:simple_music_player/Widgets/song_data_provider.dart';
import 'package:simple_music_player/appTheme.dart';
import 'package:simple_music_player/widgets/button.dart';
import 'package:simple_music_player/widgets/song_avatar.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  AssetsAudioPlayer _assetsAudioPlayer;
  @override
  void initState() {
    _scrollController = ScrollController();
    _assetsAudioPlayer = AssetsAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool showTopAppBar = Provider.of<ShowAppbars>(context).showTopAppbar;
    bool showbottomAppBar = Provider.of<ShowAppbars>(context).showBottomAppbar;
    Provider.of<SongsControlPanel>(context).updateCurrentPlayingAudio();
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
                _scrollControllerAction();
                return true;
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: SongPlayingHeader(),
                  ),
                  SliverToBoxAdapter(),
                  SongsListBuilder(
                    assetsAudioPlayer: _assetsAudioPlayer,
                  ),
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
            Visibility(
              // visible: showbottomAppBar,
              visible: false,
              child: AnimatedOpacity(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollControllerAction() {
    var position = _scrollController.position.pixels;
    final provider = Provider.of<ShowAppbars>(context, listen: false);
    if (position > 265) {
      provider.showTopAppBar();
    } else {
      provider.hideTopAppBar();
    }
    if (position == _scrollController.position.maxScrollExtent) {
      provider.hideBottomAppBar();
    } else {
      provider.showBottomAppBar();
    }
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
                    child: DataProvider<RealtimePlayingInfos>(
                      builder: (context, data) {
                        if (data == null) {
                          return AudioPlayerButton(
                            buttonRadius: 25,
                            icon: Icons.favorite,
                            iconSize: 15,
                            togglePlay: false,
                            disable: true,
                          );
                        }
                        final path = data.current.audio.assetAudioPath;
                        final audioProvider =
                            Provider.of<SongsControlPanel>(context);
                        final bool togglePlay =
                            audioProvider.getFavorite(path, hideDebug: true);
                        return AudioPlayerButton(
                          buttonRadius: 25,
                          icon: Icons.favorite,
                          iconSize: 15,
                          togglePlay: togglePlay,
                          onTap: () async {
                            final audioProvider =
                                Provider.of<SongsControlPanel>(context,
                                    listen: false);
                            await audioProvider.saveFavorite(path, !togglePlay);
                          },
                        );
                      },
                    ),
                  ),
                ),
                Opacity(
                  opacity: sideButtonsOpacity,
                  child: DataProvider<RealtimePlayingInfos>(
                    builder: (context, data) {
                      return SongAvatar(
                        songCoverPath:
                            data?.current?.audio?.audio?.metas?.image?.path ??
                                'assets/fire_flower.jpg',
                        radius: _calculateShrinking(
                          shrinkOffset,
                          80,
                          speedFactor: 1.8,
                        ),
                        imagePadding: 4,
                      );
                    },
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
                        MoreOptionsPanel().buildPanelSwitch(context);
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
