import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:number_game/models/Levels.dart';
import 'package:number_game/providers/AuthProvider.dart';
import 'package:number_game/screens/Game/firstlevel_screen.dart';
import 'package:number_game/screens/Game/secondlevel_screen.dart';
import 'package:provider/provider.dart';

import 'Game/fourthlevel_screen.dart';
import 'Game/thirdlevel_screen.dart';

class SingleLevelScreen extends StatelessWidget {
  static const String path = '/SingleScreen';

  const SingleLevelScreen({Key? key}) : super(key: key);
  String pageLevel(Levels level) {
    if (level == Levels.level_1) {
      return "Level 1 ";
    } else if (level == Levels.level_2) {
      return 'Level 2';
    } else if (level == Levels.level_3) {
      return 'Level 3';
    } else if (level == Levels.level_4) {
      return 'Level 4';
    } else {
      return "No Level Specified";
    }
  }

  Widget getGameBtn(int level, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
          padding: const EdgeInsets.all(5),
          color: const Color.fromARGB(255, 6, 70, 88),
          child: Center(
              child: FittedBox(
            child: Text(
              '$level',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ))),
    );
  }

  void navigateToLevel(
      Map<String, int> item, Levels level, BuildContext context) {
    String path = '';
    if (Levels.level_1 == level) {
      path = LevelOneGame.path;
    } else if (Levels.level_2 == level) {
      path = SecondLevelGame.path;
    } else if (Levels.level_3 == level) {
      path = ThirdLevelGame.path;
    } else {
      path = FourthLevelGame.path;
    }

    Navigator.of(context).pushNamed(path, arguments: {'item': item});
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    final provider = Provider.of<AuthProvider>(context, listen: true);
    final media = MediaQuery.of(context).size;
    final level = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Object>)['level'] as Levels;

    List<Map<String, int>> games = provider.getGames(level);
    final title = pageLevel(level);
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        backgroundColor: const Color.fromARGB(255, 39, 106, 215),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            width: media.width * 0.9,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 60,
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,
                mainAxisExtent: 60,
              ),
              children: games
                  .map((item) => getGameBtn(++count, () {
                        navigateToLevel(item, level, context);
                        // Navigator.of(context).pushNamed(gameLevel(level),
                        //     arguments: {'item': item});
                      }))
                  .toList(),
            ),
          ),
        ));
  }
}
