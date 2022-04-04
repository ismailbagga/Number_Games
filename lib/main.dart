// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_game/providers/AuthProvider.dart';
import 'package:number_game/screens/Game/firstlevel_screen.dart';
import 'package:number_game/screens/Game/fourthlevel_screen.dart';
import 'package:number_game/screens/Game/pause_screen.dart';
import 'package:number_game/screens/Game/secondlevel_screen.dart';
import 'package:number_game/screens/Game/thirdlevel_screen.dart';
import 'package:number_game/screens/SingleLevel_screen.dart';
import 'package:number_game/screens/challenges_screen.dart';
import 'package:number_game/screens/levels_screen.dart';
import 'package:number_game/screens/menu_screen.dart';
import 'package:number_game/screens/play_screen.dart';
import 'package:number_game/screens/win_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
          // textTheme:
        ),

        // home: Home(),
        initialRoute: MenuScreen.path,
        routes: {
          MenuScreen.path: (context) => MenuScreen(),
          ChallengesScreen.path: (context) => ChallengesScreen(),
          LevelsScreen.path: (context) => LevelsScreen(),
          PlayScreen.path: (context) => PlayScreen(),
          SingleLevelScreen.path: (context) => SingleLevelScreen(),
          LevelOneGame.path: (context) => LevelOneGame(),
          SecondLevelGame.path: (context) => SecondLevelGame(),
          ThirdLevelGame.path: (context) => ThirdLevelGame(),
          FourthLevelGame.path: (context) => FourthLevelGame(),
          WinScreen.path: (context) => WinScreen(),
          PauseScreen.path: (context) => PauseScreen(),
        },
      ),
    );
  }
}
