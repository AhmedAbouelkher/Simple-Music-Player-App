import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:simple_music_player/Models/songs_control_panel.dart';
import 'package:simple_music_player/Views/home.dart';
import 'package:simple_music_player/appTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<SongsControlPanel>(
          create: (context) => SongsControlPanel(),
        ),
        ChangeNotifierProvider<ShowAppbars>(
          create: (context) => ShowAppbars(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppTheme.primaryColor,
          accentColor: AppTheme.primaryColor,
          brightness: Brightness.dark,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
