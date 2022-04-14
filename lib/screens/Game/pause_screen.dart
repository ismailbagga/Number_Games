import 'package:flutter/material.dart';

class PauseScreen extends StatelessWidget {
  static const path = '/pauseScreen';
  const PauseScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 98, 92, 168),
      body: Center(
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            color: const Color.fromARGB(255, 5, 109, 95),
            margin: EdgeInsets.only(
              top: query.height * 0.1,
              bottom: query.height * 0.15,
              // left: query.width * 0.05,
              // right: query.width * 0.05,
            ),
            child: const Text(
              'Two',
              style: TextStyle(fontSize: 150, fontWeight: FontWeight.w900),
            ),
            height: query.height * 0.2,
            width: query.width * 0.9,
          ),
          buttonBuilder(
            'Continue',
            () {
              Navigator.of(context).pop('none');
            },
            width: 350,
          ),
          buttonBuilder(
            'Levels',
            () => {},
          ),
          buttonBuilder(
            'Quite',
            () {
              Navigator.of(context).pop('q');
            },
          ),
        ]),
      ),
    );
  }
}
