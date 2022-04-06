import 'package:flutter/material.dart';

class WinScreen extends StatelessWidget {
  static const path = '/winscreen';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // final route = (ModalRoute.of(context)?.settings.arguments
    //     as Map<String, int>)['level'];

    // final ButtonStyle style =
    //     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 244, 70),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: media.padding.top + 50),
          width: media.size.width * 0.8,
          child: Column(children: [
            const FittedBox(
              child: Text(
                'Congratulation You Win',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Retry'),
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
                print('more games');
                Navigator.of(context).pop(false);
              },
              child: const Text('More Games'),
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
