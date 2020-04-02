import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:simple_music_player/appTheme.dart';
import 'package:simple_music_player/models/songs.dart';
import 'package:simple_music_player/sceeens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (context) => SongsControlPanel()),
        ChangeNotifierProvider(create: (context) => ShowUpperAppbar()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppTheme().primaryColor,
          accentColor: AppTheme().primaryColor,
          brightness: Brightness.dark,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
