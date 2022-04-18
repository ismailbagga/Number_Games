import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:intl/intl.dart';
import 'package:number_game/models/Levels.dart';
import 'package:number_game/providers/AuthProvider.dart';
import 'package:number_game/screens/SingleLevel_screen.dart';
import 'package:number_game/screens/challenges_screen.dart';
import 'package:number_game/screens/levels_screen.dart';
import 'package:number_game/screens/play_screen.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  static const path = "/menu";

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isVisited = false;
  String? selectedItem;

  void naviagateTo(String path, BuildContext context) {
    Navigator.of(context).pushNamed(path);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isVisited) return;
    selectedItem =
        Provider.of<AuthProvider>(context, listen: false).getSelectedLanguage();
    isVisited = true;
  }

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

  Widget buttonWithIcon(String text, VoidCallback onClick) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(top: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: buttonBuilder(text, onClick, width: 100, margin: 0)),
        Container(
          color: const Color.fromARGB(255, 9, 156, 230),
          child: InkWell(
            onTap: onClick,
            child: const Icon(
              Icons.arrow_circle_right_outlined,
              size: 80,
              color: Color.fromARGB(255, 254, 255, 255),
            ),
          ),
        ),
      ]),
    );
  }

  void dropDownCallBack(String? item) {
    setState(() {
      if (item is String) {
        selectedItem = item;
        Provider.of<AuthProvider>(context, listen: false)
            .setDisplaylanguage(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: true);
    // print(FacebookAuth.i.getUserData());

    print("langauge changes to ${provider.selectedLanguage}");
    bool isLogin = provider.isUserLoggedIn();

    final query = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 48, 50),
      body: Center(
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            color: const Color.fromARGB(255, 5, 109, 95),
            margin: EdgeInsets.only(
              top: query.height * 0.12,
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
            provider.selectWord(1),
            () {
              final level = provider.currentlevel;
              Navigator.of(context).pushNamed(SingleLevelScreen.path,
                  arguments: {'level': level});
            },
            width: 320,
          ),
          buttonWithIcon(
            provider.selectWord(2),
            () => naviagateTo(LevelsScreen.path, context),
          ),
          buttonBuilder(
            provider.selectWord(3),
            () => naviagateTo(ChallengesScreen.path, context),
          ),
          if (!isLogin)
            Container(
              width: 300,
              color: Colors.blue,
              margin: const EdgeInsets.only(top: 20),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  color: const Color.fromARGB(255, 9, 156, 230),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.facebook_sharp,
                      size: 60,
                      color: Color.fromARGB(255, 254, 255, 255),
                    ),
                  ),
                ),
                Expanded(
                    child: buttonBuilder(
                        provider.selectWord(4), provider.signIn,
                        width: 100, margin: 0, color: Colors.blue)),
              ]),
            ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Color.fromARGB(255, 26, 153, 195),
            width: query.width * 0.5,
            child: DropdownButton(
              iconSize: 55,
              isExpanded: true,
              value: provider.getSelectedLanguage(),
              items: const [
                DropdownMenuItem(
                  child: Text(
                    'English',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  value: "English",
                ),
                DropdownMenuItem(
                  child: Text('Francais'),
                  value: "Francais",
                ),
                DropdownMenuItem(
                  child: Text('Arabic'),
                  value: "Arabic",
                ),
                DropdownMenuItem(
                  child: Text('Dutch'),
                  value: "Detche",
                ),
                DropdownMenuItem(
                  child: Text('Spanish'),
                  value: "Spanish",
                ),
                DropdownMenuItem(
                  child: Text('italian'),
                  value: "italian",
                ),
                // DropdownMenuItem(
                //   child: Text('English'),
                //   value: "English",
                // ),
                // DropdownMenuItem(
                //   child: Text('English'),
                //   value: "English",
                // ),
              ],
              onChanged: dropDownCallBack,
            ),
          )
        ]),
      ),
    );
  }
}
