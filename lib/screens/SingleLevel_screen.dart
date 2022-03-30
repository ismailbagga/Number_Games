import 'package:flutter/material.dart';
import 'package:number_game/models/Levels.dart';

class SingleLevelScreen extends StatelessWidget {
  static const String path = '/SingleScreen';
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

  @override
  Widget build(BuildContext context) {
    final level =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    final title = pageLevel(level['level'] as Levels);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
    );
  }
}
