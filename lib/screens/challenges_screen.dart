import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

class ChallengesScreen extends StatelessWidget {
  static const String path = '/ChallengesScreen';

  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 3, 92),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          provider.selectWord(12),
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.only(top: media.height * 0.1),
            child: Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Color.fromARGB(255, 4, 83, 105),
                        primary: Colors.white,
                        fixedSize: Size(media.width * 0.9, 70)),
                    onPressed: () {},
                    child: FittedBox(
                      child: Text(
                        provider.selectWord(1),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
