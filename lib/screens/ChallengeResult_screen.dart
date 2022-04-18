import 'package:flutter/material.dart';
import 'package:number_game/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class ChallengeResultScreen extends StatefulWidget {
  static const path = '/ChallengeResultScreen';
  const ChallengeResultScreen({Key? key}) : super(key: key);

  @override
  State<ChallengeResultScreen> createState() => _ChallengeResultScreenState();
}

class _ChallengeResultScreenState extends State<ChallengeResultScreen> {
  Map<String, int>? route;
  Map? personalBest;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    route = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Map<String, int>>)['result'];
    personalBest = Provider.of<AuthProvider>(context, listen: false)
        .updatePersonalBest(route!);
    print(' personal best after i call personal best $personalBest');
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 244, 70),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: media.padding.top + 50),
          width: media.size.width * 0.8,
          child: Column(children: [
            const FittedBox(
              child: Text(
                'Congratulation You Win with Record of',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            ),
            FittedBox(
              child: Text(
                '${route!["min"]}:${route!["s"]! < 10 ? "0${route!['s']}" : "${route!['s']}"}',
                style:
                    const TextStyle(fontSize: 62, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                print('i presse back btn with time $personalBest');
                Navigator.of(context).pop(personalBest); // quite to home
              },
              child: const Text('Back'),
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
