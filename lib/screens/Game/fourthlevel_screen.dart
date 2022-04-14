import 'dart:async';

import 'package:flutter/material.dart';
import 'package:number_game/screens/Game/pause_screen.dart';
import 'package:provider/provider.dart';

import '../../models/GameQuestion.dart';
import '../../models/Levels.dart';
import '../../providers/AuthProvider.dart';
import '../../widget/NavBar.dart';
import '../win_screen.dart';

class FourthLevelGame extends StatefulWidget {
  static const path = '/fourthGame';

  const FourthLevelGame({Key? key}) : super(key: key);

  @override
  State<FourthLevelGame> createState() => _ThirdLevelGameState();
}

class _ThirdLevelGameState extends State<FourthLevelGame> {
  int id = 0;
  bool disable = false;

  var numberInCenter = 0;
  var numberToLookFor = 0;
  int plus = -1;
  int minus = -1;
  int div = -1;
  int mult = -1;
  var stateOfDrag = [
    {
      'id': 1,
      'draged': false,
      'num': 0,
    },
    {
      'id': 2,
      'draged': false,
      'num': 0,
    },
    {
      'id': 3,
      'draged': false,
      'num': 0,
    },
    {
      'id': 4,
      'draged': false,
      'num': 0,
    },
  ];
  var applyWith = 0;
  String currentNumberInCenter = "0";
  bool isVisited = false;
  Timer? timer;
  List<bool> completeOperations = List.generate(4, (index) => false);
  @override
  void initState() {
    // final route = (ModalRoute.of(context)?.settings.arguments
    //     as Map<String, Map<String, int>>)['item'];
    // numberInCenter = route!['start with']!;
    // numberToLookFor = route['look For']!;
    // applyWith = route['apply with']!;
    // currentNumberInCenter = numberInCenter;
    super.initState();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    provider.setNewCurrentlevel(Levels.level_4);
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  void didChangeDependencies() {
    if (isVisited) return;
    final route = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Map<String, int>>)['item'];

    id = route!['id'] as int;

    numberInCenter = route['startWith']!;
    numberToLookFor = route['lookFor']!;

    stateOfDrag[0]['num'] = route['plus']!;
    stateOfDrag[1]['num'] = route['minus']!;
    stateOfDrag[2]['num'] = route['multp']!;
    stateOfDrag[3]['num'] = route['div']!;
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

  void fillNumOnDrop(int num, Operation op) {
    if (op == Operation.plus) {
      plus = num;
    } else if (op == Operation.minus) {
      minus = num;
    } else if (op == Operation.multplication) {
      mult = num;
    } else {
      div = num;
    }
  }

  Operation switchOperationStringToEnum(String op) {
    Operation operation = Operation.division;
    if (op == '+') {
      operation = Operation.plus;
    } else if (op == '-') {
      operation = Operation.minus;
    } else if (op == '*') {
      operation = Operation.multplication;
    }
    return operation;
  }

  Widget arithmaticBtn(
      String op, int num, VoidCallback onClick, double x, double y) {
    return DragTarget<Map>(
      // onWillAccept: (data) {
      //   return data[''];
      // },
      onAccept: (data) {
        stateOfDrag.forEach((element) {
          if (element['id'] as int == data['id'] as int) {
            int numberInsidBox = data['num'] as int;
            setState(() {
              element['draged'] = true;
              fillNumOnDrop(numberInsidBox, switchOperationStringToEnum(op));
            });
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: num == -1 ? () {} : onClick,
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
                          num == -1 ? '...' : "$num",
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
      },
    );
  }

  void operateOn(Operation op) {
    if (disable) return;
    double res = double.parse(currentNumberInCenter);

    if (op == Operation.plus && completeOperations[0] == false) {
      res = res + plus;
      completeOperations[0] = true;
    } else if (op == Operation.minus && completeOperations[1] == false) {
      res = res - minus;
      completeOperations[1] = true;
    } else if (op == Operation.multplication &&
        completeOperations[2] == false) {
      res = res * mult;
      completeOperations[2] = true;
    } else if (op == Operation.division && completeOperations[3] == false) {
      res = res / div;

      completeOperations[3] = true;
    }
    setState(() {
      currentNumberInCenter = res.toString();
    });
    final provider = Provider.of<AuthProvider>(context, listen: false);

    if (res % 1 != 0) {
      disable = true;
      showModal(provider.selectWord(19));
      timer = Timer(const Duration(seconds: 2), () {
        reset();
        disable = false;
      });
      return;
    }
    if (res == numberToLookFor) {
      final provider = Provider.of<AuthProvider>(context);
      provider.increaseLevel(Levels.level_4, id);

      Navigator.of(context)
          .pushNamed(WinScreen.path, arguments: {'level': id}).then((value) {
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
    showModal(provider.selectWord(16));
    timer = Timer(const Duration(seconds: 2), () {
      res = numberInCenter.toDouble();
      completeOperations = List.generate(4, (_) => false);
      stateOfDrag.forEach((element) => element['draged'] = false);
      plus = minus = mult = div = -1;
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
      stateOfDrag.forEach((element) => element['draged'] = false);
      plus = minus = mult = div = -1;
      completeOperations = [false, false, false, false];
      currentNumberInCenter = numberInCenter.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 123, 8, 216),
      body: Column(children: [
        Center(
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
              arithmaticBtn('+', plus, () => operateOn(Operation.plus), 0, -15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  arithmaticBtn(
                      '/', div, () => operateOn(Operation.division), -35, 18),
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
                  arithmaticBtn('*', mult,
                      () => operateOn(Operation.multplication), 35, 18),
                ],
              ),
              arithmaticBtn(
                  '-', minus, () => operateOn(Operation.minus), 0, 60),
            ]),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: media.padding.top),
          width: 500,
          padding: const EdgeInsets.all(10),
          color: const Color.fromARGB(255, 23, 224, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ...stateOfDrag.map((item) {
                int num = item['num'] as int;
                return Draggable<Map>(
                  data: item,
                  child: item['draged'] as bool
                      ? const SizedBox(
                          height: 70,
                          width: 70,
                        )
                      : DraggableBtn(num),
                  feedback: DraggableBtn(num),
                  childWhenDragging: const SizedBox(
                    height: 70,
                    width: 70,
                  ),
                );
              }).toList(),

              // DraggableBtn(minus),
              // DraggableBtn(plus),
              // DraggableBtn(mult),
              // DraggableBtn(div)
            ],
          ),
        ),
      ]),
    );
  }
}

class DraggableBtn extends StatelessWidget {
  int number = 0;
  DraggableBtn(this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 70,
        margin: EdgeInsets.all(2),
        height: 70,
        color: const Color.fromARGB(255, 255, 255, 255),
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 64,
              color: Color.fromARGB(255, 23, 224, 255),
            ),
          ),
        ),
      ),
    );
  }
}
