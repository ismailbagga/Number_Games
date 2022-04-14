import 'dart:async';

import 'package:flutter/material.dart';
import 'package:number_game/screens/ChallengeResult_screen.dart';
import 'package:number_game/screens/Game/pause_screen.dart';
import 'package:number_game/screens/lost_screen.dart';
import 'package:provider/provider.dart';

import '../../models/GameQuestion.dart';
import '../../models/Levels.dart';
import '../../providers/AuthProvider.dart';
import '../../widget/NavBar.dart';
import '../../widget/NavBarWithTimer.dart';
import '../win_screen.dart';

class ChallengeModeGame extends StatefulWidget {
  static const path = '/ChallengeModeGame';
  const ChallengeModeGame({Key? key}) : super(key: key);

  @override
  State<ChallengeModeGame> createState() => _ChallengeModeGameState();
}

class _ChallengeModeGameState extends State<ChallengeModeGame> {
  bool disable = false;
  Timer? timer;
  int currentGameIndex = 0;
  int numberToLookFor = 0;
  int numberInCenter = 0;
  //level one ;
  var applyWith = 0;
  //level two
  int plusOrMinus = 0;
  int multpOrDiv = 0;
  // Level 3
  int plus = -1;
  int minus = -1;
  int div = -1;
  int mult = -1;
  Levels currentGameLevel = Levels.level_1;
  Timer? countdown;
  Timer? successTimer;
  Map<String, int> countdownData = {'min': 2, 's': 30};
  int increaseBy = -1;

  //Level 4
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

  String currentNumberInCenter = "0";
  List<Map<String, dynamic>> gamesSelected = [];
  bool isVisited = false;
  List<bool> completeOperations = List.generate(4, (index) => false);
  @override
  void initState() {
    super.initState();
    startTime();
    successTimer = Timer(Duration(seconds: 5), () {
      setState(() {
        increaseBy = -1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer?.cancel();
    }
    if (countdown != null) {
      countdown?.cancel();
    }
    if (successTimer != null) {
      successTimer?.cancel();
    }
  }

  @override
  void didChangeDependencies() {
    if (isVisited) return;
    final route = (ModalRoute.of(context)?.settings.arguments
        as Map<String, dynamic>)['gamesIds'];
    ;
    final provider = Provider.of<AuthProvider>(context);
    final ids = route as List<int>;
    gamesSelected = ids.map((e) => provider.getGameById(e)).toList();
    Levels level = gamesSelected[currentGameIndex]['level'];
    currentGameLevel = level;
    setGameBaseOnLevel();

    isVisited = true;
    super.didChangeDependencies();
  }

  void setGameBaseOnLevel() {
    Map<String, dynamic> map = gamesSelected[currentGameIndex];

    if (currentGameLevel == Levels.level_1) {
      numberInCenter = map['start with']!;
      numberToLookFor = map['look For']!;
      applyWith = map['apply with']!;
      currentNumberInCenter = numberInCenter.toString();
    } else if (currentGameLevel == Levels.level_2) {
      numberInCenter = map['startWith']!;
      numberToLookFor = map['lookFor']!;
      plusOrMinus = map['plusOrMinus']!;
      multpOrDiv = map['multOrDev']!;
      currentNumberInCenter = numberInCenter.toString();
    } else if (currentGameLevel == Levels.level_3) {
      numberInCenter = map['startWith']!;
      numberToLookFor = map['lookFor']!;
      plus = map['plus']!;
      minus = map['minus']!;
      mult = map['multp']!;
      div = map['div']!;
      currentNumberInCenter = numberInCenter.toString();
    } else {
      numberInCenter = map['startWith']!;
      numberToLookFor = map['lookFor']!;

      stateOfDrag[0]['num'] = map['plus']!;
      stateOfDrag[1]['num'] = map['minus']!;
      stateOfDrag[2]['num'] = map['multp']!;
      stateOfDrag[3]['num'] = map['div']!;
      plus = -1;
      minus = -1;
      mult = -1;
      div = -1;
      currentNumberInCenter = numberInCenter.toString();
    }
  }

  void pause() {
    stopTimer();
    Navigator.of(context).pushNamed(PauseScreen.path).then((value) {
      String parameter = value as String;
      if (parameter == "none") {
        print('start time');
        startTime();
      } else if (parameter == 'q') {
        print('pop');
        Navigator.of(context).pop();
      } else if (parameter == 'l') {}
    });
  }

  void stopTimer() {
    countdown!.cancel();
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

  void startTime() {
    countdown = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          countdownData['s'] = (countdownData['s'] as int) - 1;
          if (countdownData['s'] as int == 0 &&
              countdownData['min'] as int == 0) {
            Navigator.of(context).popAndPushNamed(LostScreen.path);
          } else if (countdownData['s'] as int == -1) {
            countdownData['min'] = (countdownData['min'] as int) - 1;
            countdownData['s'] = 59;
          }
        });
      },
    );
  }

  Widget arithmaticBtnForLevel4(
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

  Widget arithmaticBtnForLevels123(
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

  void operateOnFourthLevel(Operation op) {
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
        resetForLevel4();
        disable = false;
      });
      return;
    }
    if (true) {
      final provider = Provider.of<AuthProvider>(context, listen: false);

      moveToNextLevel();

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

  void operateOnThirdLevel(Operation op) {
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
    if (true) {
      final provider = Provider.of<AuthProvider>(context, listen: false);

      moveToNextLevel();
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
      setState(() {
        currentNumberInCenter = res.toString();
      });
      disable = false;
    });
  }

  void moveToNextLevel() {
    setState(() {
      if (currentGameLevel == Levels.level_4) {
        increaseBy = 10;
        resetForLevel4();
      } else {
        increaseBy = 5;
        reset();
      }
      currentGameIndex++;
      if ((countdownData['s'] as int) + increaseBy >= 60) {
        int temp = (countdownData['s'] as int) + increaseBy - 60;
        countdownData['s'] = temp;
        countdownData['min'] = (countdownData['min'] as int) + 1;
      } else {
        int temp = (countdownData['s'] as int) + increaseBy;
        countdownData['s'] = temp;
      }
      if (currentGameIndex >= gamesSelected.length) {
        // go to result screen ;
        countdown?.cancel();
        Navigator.of(context).pushNamed(ChallengeResultScreen.path,
            arguments: {'result': countdownData}).then((value) {
          print('after pop 1 $value');
          Timer(Duration(seconds: 0), () {
            Navigator.of(context).pop(value);
          });
        });
      } else {
        currentGameLevel = gamesSelected[currentGameIndex]['level'];
        setGameBaseOnLevel();
      }
    });
  }

  increaseTimer() {}

  void operateOnSecondLevel(Operation op) {
    if (disable) return;
    double res = double.parse(currentNumberInCenter);
    // print(completeOperations);
    if (op == Operation.plus && completeOperations[0] == false) {
      res = res + plusOrMinus;
      completeOperations[0] = true;
    } else if (op == Operation.minus && completeOperations[1] == false) {
      res = res - plusOrMinus;
      completeOperations[1] = true;
    } else if (op == Operation.multplication &&
        completeOperations[2] == false) {
      res = res * multpOrDiv;
      completeOperations[2] = true;
    } else if (op == Operation.division && completeOperations[3] == false) {
      res = res / multpOrDiv;

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
    if (true) {
      final provider = Provider.of<AuthProvider>(context, listen: false);

      moveToNextLevel();

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
      setState(() {
        currentNumberInCenter = res.toString();
      });
      disable = false;
    });
  }

  void operateOnFirstLevel(Operation op) {
    if (disable) return;
    double res = double.parse(currentNumberInCenter);

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
    // true
    if (true) {
      moveToNextLevel();
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
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void reset() {
    setState(() {
      completeOperations = [false, false, false, false];
      currentNumberInCenter = numberInCenter.toString();
    });
  }

  void resetForLevel4() {
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
      backgroundColor: const Color.fromARGB(255, 64, 255, 156),
      body: Column(
        children: [
          Center(
            child: Container(
              width: media.size.width * 0.9,
              margin: EdgeInsets.only(
                top: media.padding.top + media.size.height * 0.1,
              ),
              child: Column(children: [
                NavBarTimer(numberToLookFor, pause, countdownData, increaseBy),
                const SizedBox(
                  height: 50,
                ),
                ...pickWidget(context)
              ]),
            ),
          ),
          if (currentGameLevel == Levels.level_4)
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
            )
        ],
      ),
    );
    ;
  }

  List<Widget> pickWidget(BuildContext context) {
    final media = MediaQuery.of(context);

    if (currentGameLevel == Levels.level_1) {
      return [
        arithmaticBtnForLevels123('+', applyWith, () {
          operateOnFirstLevel(Operation.plus);
        }, 0, -15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            arithmaticBtnForLevels123('/', applyWith, () {
              operateOnFirstLevel(Operation.division);
            }, -35, 18),
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
            arithmaticBtnForLevels123('*', applyWith, () {
              operateOnFirstLevel(Operation.multplication);
            }, 35, 18),
          ],
        ),
        arithmaticBtnForLevels123('-', applyWith, () {
          operateOnFirstLevel(Operation.minus);
        }, 0, 60)
      ];
    } else if (currentGameLevel == Levels.level_2) {
      return [
        arithmaticBtnForLevels123('+', plusOrMinus,
            () => operateOnSecondLevel(Operation.plus), 0, -15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            arithmaticBtnForLevels123('/', multpOrDiv,
                () => operateOnSecondLevel(Operation.division), -35, 18),
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
            arithmaticBtnForLevels123('*', multpOrDiv,
                () => operateOnSecondLevel(Operation.multplication), 35, 18),
          ],
        ),
        arithmaticBtnForLevels123('-', plusOrMinus,
            () => operateOnSecondLevel(Operation.minus), 0, 60),
      ];
    } else if (currentGameLevel == Levels.level_3) {
      return [
        arithmaticBtnForLevels123('+', plus, () {
          operateOnThirdLevel(Operation.plus);
        }, 0, -15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            arithmaticBtnForLevels123('/', div, () {
              operateOnThirdLevel(Operation.division);
            }, -35, 18),
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
            arithmaticBtnForLevels123('*', mult, () {
              operateOnThirdLevel(Operation.multplication);
            }, 35, 18),
          ],
        ),
        arithmaticBtnForLevels123('-', minus, () {
          operateOnThirdLevel(Operation.minus);
        }, 0, 60),
      ];
    } else {
      return [
        arithmaticBtnForLevel4(
            '+', plus, () => operateOnFourthLevel(Operation.plus), 0, -15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            arithmaticBtnForLevel4('/', div,
                () => operateOnFourthLevel(Operation.division), -35, 18),
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
            arithmaticBtnForLevel4('*', mult,
                () => operateOnFourthLevel(Operation.multplication), 35, 18),
          ],
        ),
        arithmaticBtnForLevel4(
            '-', minus, () => operateOnFourthLevel(Operation.minus), 0, 60),
      ];
    }
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
        margin: const EdgeInsets.all(2),
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
