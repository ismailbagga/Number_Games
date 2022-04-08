import 'dart:convert';

// import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:number_game/models/GameQuestion.dart';
import 'package:number_game/models/Levels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

import 'package:flutter/services.dart' show ByteData, rootBundle;

// import 'package:flutter/services.dart' show ByteData, rootBundle;

class AuthProvider with ChangeNotifier {
  bool _login = false;
  int? userId;
  Map<String, Map<int, String>> languages = {};
  // {gameId:0,userId:null,}
  Future<void> retrieveAppData() async {
    final prefs = await SharedPreferences.getInstance();
    print('let start with it ');
    if (!prefs.containsKey("availableGames")) return;
    print('retrieve...');
    availableGames =
        json.decode(prefs.getString("availableGames")!) as List<dynamic>;
    print(availableGames);
    notifyListeners();
  }

  Future<void> setAvailablLanguage() async {
    /* Your blah blah code here */
    // print('set languages');
    ByteData data = await rootBundle.load("assets/languages.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    int count = 0;

    for (var table in excel.tables.keys) {
      print(table); //sheet Name

      for (var row in excel.tables[table]!.rows) {
        if (count == 0) {
          for (String item in row) {
            languages[item] = {};
          }
          count++;
        } else {
          final keys = languages.keys.toList();
          for (int i = 0; i < keys.length; i++) {
            languages[keys[i]] = {}
              ..addAll(languages[keys[i]]!)
              ..addAll({count: row[i]});
          }
          count++;
        }
      }
    }
    // SharedPreferences.getInstance().then((value) {
    //   value.setString('langauges', json.encode(languages));
    // });
  }

  AuthProvider() {
    retrieveAppData();

    if (languages.isEmpty) {
      setAvailablLanguage();
    }
  }
  List<dynamic> availableGames = [
    {'gameId': 1, 'userId': null, 'completed': false},
    {'gameId': 21, 'userId': null, 'completed': false},
    {'gameId': 41, 'userId': null, 'completed': false},
    {'gameId': 61, 'userId': null, 'completed': false}
  ];
  List<dynamic> retrieveCompletedLevels() {
    return [...availableGames];
  }

  bool isGameCompleted(gameId) {
    for (int i = 0; i < availableGames.length; i++) {
      if (gameId == (availableGames[i]['gameId'] as int)) {
        return true;
      }
    }
    return false;
  }

  void increaseLevel(Levels level, int gameId) {
    print('called with $gameId');
    bool found = false;
    for (int i = 0; i < availableGames.length; i++) {
      if (gameId == (availableGames[i]['gameId'] as int)) {
        availableGames[i]['completed'] = true;
        found = true;
        break;
      }
    }
    if (!found) {
      availableGames
          .add({'gameId': gameId, 'userId': userId, 'completed': true});
      SharedPreferences.getInstance().then((value) {
        final temp = json.encode(availableGames);
        value.setString('availableGames', temp);
      });
    }
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
