import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:simple_music_player/Helpers/SharedPerfsProvider.dart';
import 'package:simple_music_player/Controllers/songs_control_panel.dart';
import 'package:simple_music_player/Views/home.dart';
import 'package:simple_music_player/appTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
  void dispose() {
    Provider.of<SongsControlPanel>(context).disposePlayer();
    print("Audio Controller was Disposed {{Main}}");
    super.dispose();
  }
}
