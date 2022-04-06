import 'package:flutter/cupertino.dart';
import 'package:number_game/models/GameQuestion.dart';
import 'package:number_game/models/Levels.dart';

class AuthProvider with ChangeNotifier {
  bool _login = false;
  final Map<String, int> _currentGame = {
    '1': 1,
    '2': 1,
    '3': 1,
    '4': 1,
  };
  void increaseLevel(Levels level) {
    if (level == Levels.level_1) {
      _currentGame['1'] = _currentGame['1']! + 1;
    } else if (level == Levels.level_2) {
      _currentGame['2'] = _currentGame['2']! + 1;
    } else if (level == Levels.level_3) {
      _currentGame['3'] = _currentGame['3']! + 1;
    } else {
      _currentGame['4'] = _currentGame['4']! + 1;
    }
    notifyListeners();
  }

  int getCurrentGameInCertainLevel(Levels level) {
    if (level == Levels.level_1) {
      return _currentGame['1']!;
    } else if (level == Levels.level_2) {
      return _currentGame['2']!;
    } else if (level == Levels.level_3) {
      return _currentGame['3']!;
    } else {
      return _currentGame['4']!;
    }
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
