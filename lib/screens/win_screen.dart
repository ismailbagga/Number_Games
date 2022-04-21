import 'package:flutter/material.dart';
import 'package:number_game/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class WinScreen extends StatelessWidget {
  static const path = '/winscreen';

  const WinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 244, 70),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: media.padding.top + 50),
          width: media.size.width * 0.8,
          child: Column(children: [
            FittedBox(
              child: Text(
                provider.selectWord(15),
                style:
                    const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(provider.selectWord(20)),
              style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 255, 255, 255),
                  primary: const Color.fromARGB(255, 66, 0, 189),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  textStyle: const TextStyle(fontSize: 32)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(provider.selectWord(21)),
              style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 255, 255, 255),
                  primary: const Color.fromARGB(255, 217, 5, 174),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  textStyle: const TextStyle(fontSize: 32)),
            ),
          ]),
        ),
      ),
    );
  }
}
