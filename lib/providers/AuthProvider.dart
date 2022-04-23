import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

// import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';
import 'package:number_game/models/GameQuestion.dart';
import 'package:number_game/models/Levels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show ByteData, rootBundle;

// import 'package:flutter/services.dart' show ByteData, rootBundle;
class User {
  String email;
  Map token;
  String name;
  Map? personalBest;
  User(this.email, this.token, this.name, {this.personalBest});
  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        token = json['token'],
        name = json['name'] {
    if (json['personalBest'] != null) {
      personalBest = json['personalBest'];
    }
  }

  Map toJson() {
    return {
      'email': email,
      'token': token,
      'personalBest': personalBest,
      'name': name
    };
  }
}

class AuthProvider with ChangeNotifier {
  Levels currentlevel = Levels.level_1;
  User? user;

  Map? personalBest;
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

  AccessToken? accessToken;
  int? userId;
  String selectedLanguage = 'English';
  Map<String, Map<int, String>> languages = {};
  // {gameId:0,userId:null,}
  AuthProvider() {
    SharedPreferences.getInstance().then((storage) {
      storage.clear();

      if (storage.containsKey('Current_Level')) {
        currentlevel = convertlIntToLevel(storage.getInt('Current_Level')!);
      }
      if (storage.containsKey('personal_best')) {
        final temp = json.decode(storage.getString('personal_best')!)
            as Map<String, dynamic>;
        personalBest = {
          'min': temp['min'] as int,
          's': temp['s'] as int,
        };
      }
      if (storage.containsKey('user')) {
        final temp = json.decode(storage.getString('user')!);
        temp['token'] = temp['token'];
        user = User.fromJson(temp);
        if (user?.personalBest != null) {
          personalBest = user?.personalBest;
        } else {
          if (storage.containsKey('lookForPersonalBest') &&
              storage.containsKey('lookForPersonalBest') == true) {
            findSinglePersonalBest(user?.name as String);
          }
        }
      } else {}
      setAvailablLanguage();
    });
    retrieveAppData();
  }
  Future<void> retrieveAppData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("availableGames")) return;
    availableGames =
        json.decode(prefs.getString("availableGames")!) as List<dynamic>;
    notifyListeners();
    if (prefs.containsKey("GamesCompletedSync") && isUserLoggedIn()) {
      confirmAsyncGames(
              json.encode(prefs.getString("GamesCompletedSync")) as List<int>)
          .then((value) {
        if (value == true) {
          prefs.remove("GamesCompletedSync");
        }
      });
    }
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
          for (Data? item in row) {
            // print('${item?.value}');
            languages[item?.value] = {};
          }
          count++;
        } else {
          final keys = languages.keys.toList();
          for (int i = 0; i < keys.length; i++) {
            languages[keys[i]] = {}
              ..addAll(languages[keys[i]]!)
              ..addAll({count: row[i]?.value});
          }
          count++;
        }
      }
    }

    SharedPreferences.getInstance().then((value) {
      if (value.containsKey('current_lang')) {
        selectedLanguage = value.getString("current_lang")!;
      } else {
        // selectedLanguage = "Arabic";
      }
      notifyListeners();
    });
  }

  String getSelectedLanguage() {
    return selectedLanguage;
  }

  void setDisplaylanguage(String lang) {
    selectedLanguage = lang;
    SharedPreferences.getInstance().then((value) {
      value.setString('current_lang', lang);
    });
    notifyListeners();
  }

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
    {'gameId': 1, 'completed': false},
    {'gameId': 21, 'completed': false},
    {'gameId': 41, 'completed': false},
    {'gameId': 61, 'completed': false}
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

  Future<bool> confirmAsyncGames(List<int> gamesIds) async {
    final url = Uri.https(
      'flutter-numbers-game.herokuapp.com',
      '/api/v1/personalBest/completeMultipleGames',
    );
    try {
      final response = await http
          .post(url, body: {"name": user?.name, "gamesIds": gamesIds});
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> confirmGame(int gameId) async {
    final url = Uri.https(
        'flutter-numbers-game.herokuapp.com',
        '/api/v1/personalBest/complete',
        {"name": user?.name, "gameId": gameId.toString()});
    try {
      final response = await http.post(url, body: {});
    } catch (error) {
      SharedPreferences.getInstance().then((storage) {
        List<int> games = [];
        if (storage.containsKey("GamesCompletedSync")) {
          games = [...(json.decode(storage.getString("GamesCompletedSync")!))];
        }
        games.add(gameId);
        storage.setString("GamesCompletedSync", json.encode(games));
      });
    }
  }

  void increaseLevel(Levels level, int gameId) {
    bool found = false;
    if (isUserLoggedIn()) {
      confirmGame(gameId);
    }
    for (int i = 0; i < availableGames.length; i++) {
      if (gameId == (availableGames[i]['gameId'] as int)) {
        availableGames[i]['completed'] = true;
        found = true;
        break;
      }
    }
    if (!found) {
      availableGames.add({'gameId': gameId, 'completed': true});
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
    GameQuestion2.getLevel2Questions(),
    GameQuestion3.getLevel3Questions(),
    GameQuestion4.getLevel4Questions(),
  ];
  Map<String, dynamic> getGameById(int id) {
    Map<String, dynamic> map = {};
    levels.forEach((level) {
      level.forEach((game) {
        if (game['id'] == id) {
          map = {...game};
          Levels level = Levels.level_1;
          if (id > 20 && id < 41) {
            level = Levels.level_2;
          } else if (id > 40 && id < 61) {
            level = Levels.level_3;
          } else if (id > 60) {
            level = Levels.level_4;
          }
          map['level'] = level;
        }
      });
    });

    return map;
  }

  // void setLoginState(bool state) {
  //   _login = state;
  //   notifyListeners();
  // }

  bool isUserLoggedIn() {
    return user != null;
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

  void setNewChallengePersonalBest(Map<String, int> map) {
    SharedPreferences.getInstance().then((value) {
      value.setString('personal_record', json.encode(map));
    });
  }

  Future<List<Map<String, dynamic>>> signIn() async {
    final LoginResult result = await FacebookAuth.i
        .login(permissions: ['email', 'public_profile', 'user_friends']);
    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;
      final data =
          await FacebookAuth.i.getUserData(fields: 'email,name,friends');

      if (!data.containsKey('email') || accessToken == null) return [];
      String name = data['name'];
      Map? person = await findSinglePersonalBest(name);
      if (person == null && personalBest == null) {
        user = User(data['email'], accessToken!.toJson(), name);
      }
      // else if ( person != null && personalBest == null)

      else {
        Map<String, int> pb;
        if (personalBest == null && person != null) {
          pb = {
            'min': person['min'] as int,
            's': person['s'] as int,
          };
          availableGames = person['state'];
          await SharedPreferences.getInstance().then((value) {
            value.setString("availableGames", json.encode(availableGames));
          });
        } else if (person == null && personalBest != null) {
          pb = {
            'min': personalBest!['min']! as int,
            's': personalBest!['s']! as int,
          };
          submitPersonalBest(
              {...personalBest!, 'name': name, 'email': data["email"]});
        } else {
          int count1 = person!['min'] * 60 + person['s'];
          int count2 = personalBest!['min']! * 60 + personalBest!['s']!;
          if (count1 > count2) {
            pb = {
              'min': person['min'] as int,
              's': person['s'] as int,
            };
          } else {
            pb = personalBest! as Map<String, int>;
            submitPersonalBest(
                {...personalBest!, 'name': name, 'email': data['email']});
          }
        }
        user =
            User(data['email'], accessToken!.toJson(), name, personalBest: pb);
      }
      await SharedPreferences.getInstance().then((value) {
        value.setString('user', json.encode(user?.toJson()));

        notifyListeners();
      });
      return [];
    }
    return [];
  }

  Future<Map?> findSinglePersonalBest(String name) async {
    final url = Uri.https('flutter-numbers-game.herokuapp.com',
        '/api/v1/personalBest/friend', {"name": name});
    final pref = await SharedPreferences.getInstance();
    try {
      final response = await http.get(url);
      if (response.body == "") {
        pref.setBool("lookForPersonalBest", false);
        return null;
      }
      pref.setBool("lookForPersonalBest", false);
      return json.decode(response.body);
    } catch (error) {
      pref.setBool("lookForPersonalBest", true);
    }
  }

  Future<List<dynamic>> findFriendsList() async {
    final tempAccessToken = await FacebookAuth.instance.accessToken;
    if (tempAccessToken != null) {
      final response =
          await FacebookAuth.instance.getUserData(fields: 'friends');
      if (response.isEmpty) {
        return [];
      }
      List<String> names = (response["friends"]["data"] as List<dynamic>)
          .map((e) => e['name'] as String)
          .toList();
      names.add(user?.name as String);
      final res = await findPersonalsBest(names);
      return res;
    } else {
      user = null;
      final pref = await SharedPreferences.getInstance();
      pref.remove("user");
      return [];
    }
  }

  void submitPersonalBest(Map<String, dynamic> map) async {
    final url = Uri.https(
        'flutter-numbers-game.herokuapp.com', '/api/v1/personalBest/save');
    try {
      final response = await http.post(url,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: json.encode(map));
    } catch (error) {
      await SharedPreferences.getInstance().then((storage) {
        storage.setString("isPersonalBestSync", json.encode(map));
      });
    }
  }

  Future<List<dynamic>> findPersonalsBest(List<String> names) async {
    final url = Uri.https(
        'flutter-numbers-game.herokuapp.com', '/api/v1/personalBest/friends');
    try {
      final response = await http.post(
        url,
        body: json.encode({'emails': names}),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
      if (response.body == "") {
        return [];
      }
      return json.decode(response.body) as List<dynamic>;
    } catch (error) {
      rethrow;
    }
    // Map<String,int>
  }

  String getBestResult() {
    if (user != null && user!.personalBest != null) {
      return '${user!.personalBest!['min']}:${user!.personalBest!['s'] as int < 10 ? "0${user!.personalBest!['s']}" : "${user!.personalBest!['s']}"}';
    }
    if (personalBest != null) {
      return '${personalBest!['min']}:${personalBest!['s'] as int < 10 ? "0${personalBest!['s']}" : "${personalBest!['s']}"}';
    }
    return languages[selectedLanguage]![14]!;
  }

  void saveUserLocaly() {
    SharedPreferences.getInstance().then((value) {
      value.setString('user', json.encode(user?.toJson()));
      notifyListeners();
    });
  }

  Map? updatePersonalBest(Map<String, int> map) {
    final perf = SharedPreferences.getInstance();
    if (user == null) {
      if (personalBest != null) {
        int newc = map['min']! * 60 + map['s']!;
        int oldc = personalBest!['min']! * 60 + personalBest!['s']!;
        if (oldc > newc) {
          return personalBest;
        }
      }
      perf.then((storage) {
        storage.setString('personal_best', json.encode(map));
      });
      personalBest = map;

      return personalBest;
    }

    if (user?.personalBest == null) {
      submitPersonalBest({...map, 'name': user?.name, 'email': user?.email});
      user?.personalBest = map;
      perf.then((storage) {
        storage.setString('user', json.encode(user?.toJson()));

        // notifyListeners();+
      });
      return user?.personalBest;
    }
    int newtimeToSec = map['min']! * 60 + map['s']!;
    int oldtimeToSec = (user?.personalBest!['min'] as int) * 60 +
        (user?.personalBest!['s'] as int);
    if (newtimeToSec > oldtimeToSec) {
      submitPersonalBest({...map, 'name': user?.name, 'email': user?.email});
      user?.personalBest = map;
      perf.then((storage) {
        storage.setString('user', json.encode(user?.toJson()));
        // notifyListeners();
      });

      return map;
    } else {
      return personalBest;
    }
  }
}
