import 'package:flutter/material.dart';

class NavBarTimer extends StatelessWidget {
  final int numberToLookFor;
  final VoidCallback pause;
  final Map<String, int> countdown;
  final int increaseBy;

  const NavBarTimer(
      this.numberToLookFor, this.pause, this.countdown, this.increaseBy,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      // color: Colors.red,
      child: Stack(children: [
        Row(children: [
          GestureDetector(
              onTap: pause,
              child: Container(
                color: Colors.blue,
                child: const Icon(
                  Icons.menu,
                  size: 64,
                  color: Colors.white,
                ),
              )),
          Expanded(
            child: Container(
              height: 64,
              padding: const EdgeInsets.only(right: 10),
              color: Colors.white,
              alignment: Alignment.centerRight,
              child: Text(
                '$numberToLookFor  ',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
        Positioned(
          top: 60,
          right: 0,
          child: Container(
            width: 80,
            height: 50,
            child: FittedBox(
                child: Text(
                    '${countdown["min"]}:${countdown["s"] as int < 10 ? "0${countdown['s']}" : "${countdown['s']}"} ')),
          ),
        ),
        Positioned(
            top: 100,
            right: 30,
            child: Container(
              // width: 80,
              // height: 50,
              child: Text(
                increaseBy < 0 ? '' : '+$increaseBy',
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            )),
      ]),
    );
  }
}
