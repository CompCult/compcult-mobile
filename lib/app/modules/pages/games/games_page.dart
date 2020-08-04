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
      ),
      body: SingleChildScrollView(
        child: Container(
          //decoration: BoxDecoration(
          //  image: DecorationImage(
          //    image: AssetImage('assets/background.png'),
          //    fit: BoxFit.cover,
          //  ),
          //),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Image.asset(
                  "assets/leratos/aba_minigames.png",
                  height: 150,
                  width: 500,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MiniGames(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: Image.asset(
                  "assets/leratos/aba_missoes.png",
                  height: 150,
                  width: 500,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MissionsPage(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: Image.asset(
                  "assets/leratos/aba_quizzes.png",
                  height: 150,
                  width: 500,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizzesPage(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
