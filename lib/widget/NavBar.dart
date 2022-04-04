// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int numberToLookFor;
  final VoidCallback pause;
  const NavBar(this.numberToLookFor, this.pause, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      color: Colors.red,
      child: Row(children: [
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
              '$numberToLookFor',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ]),
    );
  }
}
