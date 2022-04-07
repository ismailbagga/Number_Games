import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:number_game/models/GameQuestion.dart';
import 'package:number_game/models/Levels.dart';
import 'package:number_game/providers/AuthProvider.dart';
import 'package:number_game/screens/win_screen.dart';
import 'package:provider/provider.dart';
import '../../widget/NavBar.dart';
import 'pause_screen.dart';

class LevelOneGame extends StatefulWidget {
  static const String path = '/levelOneGame';

  @override
  State<LevelOneGame> createState() => _LevelOneGameState();
}

class _LevelOneGameState extends State<LevelOneGame> {
  int id = 0;
  bool disable = false;

  var numberInCenter = 0;
  var numberToLookFor = 0;
  var applyWith = 0;
  String currentNumberInCenter = "0";
  bool isVisited = false;
  List<bool> completeOperations = List.generate(4, (index) => false);
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isVisited) return;
    final route = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Map<String, int>>)['item'];
    id = route!['id'] as int;
    numberInCenter = route['start with']!;
    numberToLookFor = route['look For']!;
    applyWith = route['apply with']!;
    currentNumberInCenter = numberInCenter.toString();
    isVisited = true;
    super.didChangeDependencies();
  }

  void pause() {
    Navigator.of(context).pushNamed(PauseScreen.path).then((value) {
      String parameter = value as String;
      if (parameter == 'q') {
        Navigator.of(context).pop();
      } else if (parameter == 'l') {}
    });
  }

  Widget arithmaticBtn(
      String op, int num, VoidCallback onClick, double x, double y) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 70,
        height: 70,
        child: Stack(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Text(
                  op,
                  style: const TextStyle(fontSize: 64, color: Colors.white),
                )),
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                child: Container(
                  alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: FittedBox(
                    child: Text(
                      '$num',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 5, 67, 66)),
                    ),
                  ),
                ),
                offset: Offset(x, y),
              ),
            ),
          ],
        ),
        color: const Color.fromARGB(255, 17, 71, 84),
      ),
    );
  }

  void operateOn(Operation op) {
    if (disable) return;
    double res = double.parse(currentNumberInCenter);
    // print(completeOperations);
    if (op == Operation.plus && completeOperations[0] == false) {
      res = res + applyWith;
      completeOperations[0] = true;
    } else if (op == Operation.minus && completeOperations[1] == false) {
      res = res - applyWith;
      completeOperations[1] = true;
    } else if (op == Operation.multplication &&
        completeOperations[2] == false) {
      res = res * applyWith;
      completeOperations[2] = true;
    } else if (op == Operation.division && completeOperations[3] == false) {
      res = res / applyWith;

      completeOperations[3] = true;
    }
    setState(() {
      currentNumberInCenter = res.toString();
    });
    if (res % 1 != 0) {
      disable = true;
      showModal('Ops you got decimal value try agin');
      Timer(const Duration(seconds: 2), () {
        reset();
        disable = false;
      });
      return;
    }
    if (res == numberToLookFor) {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      // if (provider.getCurrentGameInCertainLevel(Levels.level_1) < 20) {
      //   provider.increaseLevel(Levels.level_1);
      // }
      Navigator.of(context)
          .pushNamed(WinScreen.path, arguments: {'level': id}).then((value) {
        // print(value);
        bool isRetry = value as bool;

        if (isRetry == true) {
          reset();
        } else {
          Navigator.of(context).pop(context);
        }
      });
      return;
    }
    for (int i = 0; i < 4; i++) {
      if (!completeOperations[i]) {
        return;
      }
    }
    disable = true;
    showModal("all operation are consumed try agin");
    Timer(const Duration(seconds: 2), () {
      res = numberInCenter.toDouble();
      completeOperations = List.generate(4, (_) => false);
      setState(() {
        currentNumberInCenter = res.toString();
      });
      disable = false;
    });
  }

  void showModal(String text, {Color color = Colors.red}) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void reset() {
    setState(() {
      completeOperations = [false, false, false, false];
      currentNumberInCenter = numberInCenter.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Container(
          width: media.size.width * 0.9,
          margin: EdgeInsets.only(
            top: media.padding.top + media.size.height * 0.1,
          ),
          child: Column(children: [
            NavBar(numberToLookFor, pause),
            const SizedBox(
              height: 50,
            ),
            arithmaticBtn(
                '+', applyWith, () => operateOn(Operation.plus), 0, -15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                arithmaticBtn('/', applyWith,
                    () => operateOn(Operation.division), -35, 18),
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      double.parse(currentNumberInCenter).toStringAsFixed(1),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                arithmaticBtn('*', applyWith,
                    () => operateOn(Operation.multplication), 35, 18),
              ],
            ),
            arithmaticBtn(
                '-', applyWith, () => operateOn(Operation.minus), 0, 60),
          ]),
        ),
      ),
    );
  }
}
