import 'package:flutter/material.dart';
import 'package:number_game/models/Levels.dart';
import 'package:number_game/screens/SingleLevel_screen.dart';

class LevelsScreen extends StatelessWidget {
  static const String path = '/LevelsScreen';

  Widget buttonBuilder(String text, VoidCallback onClick,
      {double width = 300, double margin = 20, Color color = Colors.white}) {
    return Container(
      width: width,
      color: Colors.black,
      height: 80,
      margin: EdgeInsets.only(top: margin),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          onPrimary: color == Colors.white ? Colors.blue : Colors.white,
          primary: color,
          // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
        ),
        child: FittedBox(
            child: Text(text,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700))),
      ),
    );
  }

  const LevelsScreen({Key? key}) : super(key: key);
  Widget buildLevelButton(String text, Color color, VoidCallback onClick) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(top: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            child: buttonBuilder(text, onClick,
                width: 100, margin: 0, color: color)),
        Container(
          color: const Color.fromARGB(255, 9, 156, 230),
          child: InkWell(
            onTap: onClick,
            child: const Icon(
              Icons.arrow_circle_right_outlined,
              size: 80,
              color: Color.fromARGB(255, 254, 255, 255),
            ),
          ),
        ),
      ]),
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Levels'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: query.padding.top + 10),
        color: const Color.fromARGB(255, 15, 255, 67),
        child: Center(
          child: Column(children: [
            buildLevelButton('Level 1', Colors.amberAccent, () {
              Navigator.of(context).pushNamed(SingleLevelScreen.path,
                  arguments: {'level': Levels.level_1});
            }),
            buildLevelButton('Level 2', Colors.black, () {
              Navigator.of(context).pushNamed(SingleLevelScreen.path,
                  arguments: {'level': Levels.level_2});
            }),
            buildLevelButton('Level 3', Colors.blue, () {
              Navigator.of(context).pushNamed(SingleLevelScreen.path,
                  arguments: {'level': Levels.level_3});
            }),
            buildLevelButton('Level 4', Color.fromARGB(255, 66, 5, 144), () {
              Navigator.of(context).pushNamed(SingleLevelScreen.path,
                  arguments: {'level': Levels.level_4});
            }),
          ]),
        ),
      ),
    );
  }
}
