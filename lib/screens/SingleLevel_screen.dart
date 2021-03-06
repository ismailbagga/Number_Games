import 'package:flutter/material.dart';
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
  int pageLevel(Levels level) {
    if (level == Levels.level_1) {
      return 5;
    } else if (level == Levels.level_2) {
      return 6;
    } else if (level == Levels.level_3) {
      return 8;
    } else {
      return 7;
    }
  }

  Widget getGameBtn(int level, List<dynamic> completedGames, int gameId,
      VoidCallback onClick) {
    bool found = false;
    for (int i = 0; i < completedGames.length; i++) {
      dynamic game = completedGames[i];
      if (gameId == game['gameId'] ||
          (game['completed'] as bool == true && gameId == game['gameId'] + 1)) {
        found = true;
        break;
      }
    }

    return InkWell(
      onTap: found ? onClick : () {},
      child: Container(
          padding: const EdgeInsets.all(5),
          color: const Color.fromARGB(255, 6, 70, 88),
          child: Center(
              child: FittedBox(
            child: !found
                ? const Icon(Icons.lock)
                : Text(
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
    final completedGames = provider.retrieveCompletedLevels();
    List<Map<String, int>> games = provider.getGames(level);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            provider.selectWord(pageLevel(level)),
            style: TextStyle(fontSize: 32),
          ),
        ),
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
                  .map((item) => getGameBtn(
                          ++count, completedGames, item['id'] as int, () {
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
