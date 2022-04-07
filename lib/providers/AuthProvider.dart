import 'package:flutter/cupertino.dart';
import 'package:number_game/models/GameQuestion.dart';
import 'package:number_game/models/Levels.dart';

class AuthProvider with ChangeNotifier {
  bool _login = false;
  int? userId;
  // {gameId:0,userId:null,}
  var completedGames = [
    {'gameId': 1, 'userId': null},
    {'gameId': 21, 'userId': null},
    {'gameId': 41, 'userId': null},
    {'gameId': 61, 'userId': null}
  ];
  List<dynamic> retrieveCompletedLevels() {
    return [...completedGames];
  }

  bool isGameCompleted(gameId) {
    for (int i = 0; i < completedGames.length; i++) {
      if (gameId == (completedGames[i]['gameId'] as int)) {
        return true;
      }
    }
    return false;
  }

  void increaseLevel(Levels level, int gameId) {
    bool found = false;
    for (int i = 0; i < completedGames.length; i++) {
      if (gameId == (completedGames[i]['gameId'] as int)) {
        found = true;
        break;
      }
    }
    if (found) return;
    completedGames.add({'gameId': gameId, 'userId': userId});
    notifyListeners();
  }

  // const List<GameQuestion> level1 = [];
  List<List<Map<String, int>>> levels = [
    GameQuestion1.getLevel1Questions(),
    GameQuestion2.getLevel1Questions(),
    GameQuestion3.getLevel1Questions(),
    GameQuestion3.getLevel1Questions(),
  ];
  set setLoginState(bool state) {
    _login = state;
    notifyListeners();
  }

  bool isUserLoggedIn() {
    return _login;
  }

  List<Map<String, int>> getGames(Levels level) {
    if (level == Levels.level_1) {
      return [...levels[0]];
    } else if (level == Levels.level_2) {
      return [...levels[1]];
    } else if (level == Levels.level_3) {
      return [...levels[2]];
    } else if (level == Levels.level_4) {
      return [...levels[3]];
    } else {
      return [];
    }
  }
}
