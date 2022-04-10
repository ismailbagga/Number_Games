import 'dart:convert';

// import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:number_game/models/GameQuestion.dart';
import 'package:number_game/models/Levels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

import 'package:flutter/services.dart' show ByteData, rootBundle;

// import 'package:flutter/services.dart' show ByteData, rootBundle;

class AuthProvider with ChangeNotifier {
  Levels currentlevel = Levels.level_1;
  void setNewCurrentlevel(Levels level) {
    currentlevel = level;
    SharedPreferences.getInstance().then((value) {
      value.setInt("Current_Level", convertlLevelEnumToInt(level));
    });
  }

  int convertlLevelEnumToInt(Levels level) {
    if (level == Levels.level_1) {
      return 1;
    } else if (level == Levels.level_2) {
      return 2;
    } else if (level == Levels.level_3) {
      return 3;
    } else {
      return 4;
    }
  }

  Levels convertlIntToLevel(int level) {
    if (level == 1) {
      return Levels.level_1;
    } else if (level == 2) {
      return Levels.level_2;
    } else if (level == 3) {
      return Levels.level_3;
    } else {
      return Levels.level_4;
    }
  }

  bool _login = false;
  AccessToken? accessToken;
  int? userId;
  String selectedLanguage = 'Arabic';
  Map<String, Map<int, String>> languages = {};
  // {gameId:0,userId:null,}
  Future<void> retrieveAppData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("availableGames")) return;
    availableGames =
        json.decode(prefs.getString("availableGames")!) as List<dynamic>;
    notifyListeners();
  }

  Future<void> setAvailablLanguage() async {
    /* Your blah blah code here */
    ByteData data = await rootBundle.load("assets/languages.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    int count = 0;

    for (var table in excel.tables.keys) {
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

    notifyListeners();
  }

  AuthProvider() {
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey('Current_Level')) {
        currentlevel = convertlIntToLevel(value.getInt('Current_Level')!);
      }
    });
    retrieveAppData();
    setAvailablLanguage();
  }
  void setNewLanguage(String language) {
    selectedLanguage = language;
  }

  String selectWord(int wordId) {
    if (languages.containsKey(selectedLanguage)) {
      return languages[selectedLanguage]![wordId] as String;
    }
    return 'Wait a minut';
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

  void signIn() async {
    print('called');
    final LoginResult result = await FacebookAuth.i
        .login(permissions: ['email', 'public_profile', 'user_friends']);
    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;
      final data = await FacebookAuth.i.getUserData(fields: 'friends');
      print(data);
      // Save User in Server with his friends ;
      // print(data['email']);
      // print(data['friends']);
    }
  }
}
