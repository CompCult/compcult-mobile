import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museu_vivo/app/modules/pages/minigames/minigames_page.dart';
import 'package:museu_vivo/app/modules/pages/mission/missions_page.dart';
import 'package:museu_vivo/app/modules/pages/quiz/quizzes_page.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';

class GamesPage extends StatefulWidget {
  static const String routeName = '/main';

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButton(
            name: 'MINI-GAMES',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MiniGames(),
                ),
              );
            },
          ),
          _buildButton(
            name: 'MISSÕES',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MissionsPage(),
                ),
              );
            },
          ),
          _buildButton(
            name: 'QUIZZES',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizzesPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _buildButton({String name, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
