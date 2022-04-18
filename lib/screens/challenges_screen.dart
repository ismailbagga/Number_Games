import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_game/screens/Game/ChallengeMode.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

class ChallengesScreen extends StatefulWidget {
  static const String path = '/ChallengesScreen';

  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<Map<String, dynamic>> friends = [];
  bool checking = false;
  @override
  void initState() {}

  Widget friendResultWidget(int pos, Map<String, dynamic> map) {
    const style = TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            '$pos${pos > 1 ? "eme" : "er"} - ',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Flexible(
              child: Text(map['name'],
                  overflow: TextOverflow.ellipsis, style: style)),
          Text("  (${map['time']})", style: style),
        ],
      ),
    );
  }

  List<int> randomGameSelector() {
    List<int> list = [];
    while (list.length < 4) {
      int random = 0;
      if (list.length < 3) {
        random = Random().nextInt(60) + 1;
      } else {
        random = Random().nextInt(20) + 61;
      }
      if (!list.contains(random)) {
        list.add(random);
      }
    }
    return list..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    String bestTime = provider.getBestResult();
    final media = MediaQuery.of(context).size;
    const blue = Color.fromARGB(255, 4, 83, 105);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 20, 25),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          provider.selectWord(12),
          style: const TextStyle(fontSize: 32),
        ),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.only(top: media.height * 0.1),
            width: media.width * 0.9,
            child: Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: blue,
                        primary: Colors.white,
                        fixedSize: Size(media.width * 0.9, 70)),
                    onPressed: () {
                      // print('called');
                      // print(randomGameSelector());
                      Navigator.of(context).pushNamed(ChallengeModeGame.path,
                          arguments: {
                            'gamesIds': randomGameSelector()
                          }).then((value) {
                        setState(() {
                          bestTime = provider.getBestResult();
                          print(bestTime);
                        });
                      });
                    },
                    child: FittedBox(
                      child: Text(
                        provider.selectWord(1),
                        style: const TextStyle(
                            fontSize: 62, fontWeight: FontWeight.w900),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        color: blue,
                        child: FittedBox(
                          child: Text(
                            provider.selectWord(10),
                            style: const TextStyle(
                                fontSize: 32, color: Colors.white),
                          ),
                        ),
                      )),
                      Container(
                        width: 140,
                        color: Colors.white,
                        height: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: FittedBox(
                          child: Text(
                            bestTime,
                            style: const TextStyle(fontSize: 32, color: blue),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (provider.isUserLoggedIn())
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: media.width * 0.9,
                          color: blue,
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                            provider.selectWord(13),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 22),
                            height: 220,
                            // color: Colors.red,
                            child: FutureBuilder(
                                future: provider.findFriendsList(),
                                builder: (ctx, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 50),
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  } else if (snapshot.error != null) {
                                    return Container(
                                        margin: const EdgeInsets.only(top: 50),
                                        child: const Center(
                                            child: Text("an Error Ocured")));
                                  } else {
                                    return ListView(
                                      children: [
                                        ...friends
                                            .map(
                                                (e) => friendResultWidget(1, e))
                                            .toList(),
                                      ],
                                    );
                                  }
                                }))
                      ]),
                if (!provider.isUserLoggedIn())
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        // color: blue,
                        margin: const EdgeInsets.only(top: 70, bottom: 20),
                        child: Text(provider.selectWord(11),
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white)),
                      ),
                      InkWell(
                        onTap: () {
                          provider.signIn().then((friend) {
                            print(friend);
                          });
                        },
                        child: Container(
                            width: media.width * 0.7,
                            // height: 120,
                            color: const Color.fromRGBO(58, 85, 159, 1),
                            // margin: EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(children: [
                              Container(
                                color: Colors.white,
                                child: Image.asset(
                                  'assets/facebook.png',
                                  height: 35,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                // padding: const EdgeInsets.only(left: 20.0),
                                child: FittedBox(
                                    child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    provider.selectWord(4),
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                )),
                              ),
                            ])),
                      )
                    ],
                  )
              ],
            )),
      ),
    );
  }
}
