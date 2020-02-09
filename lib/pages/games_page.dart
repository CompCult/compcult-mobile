import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museu_vivo/pages/minigames_page.dart';

import './missions_page.dart';
import './quizzes_page.dart';

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
          title: Text("Games"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 90,
                ),
                Container(
                  height: 40,
                  width: 145,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.assistant_photo),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MissionsPage()));
                          }),
                      IconButton(
                          icon: Icon(Icons.extension),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MiniGames()));
                          }),
                      IconButton(
                          icon: Icon(Icons.forum),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizzesPage()));
                          })
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ],
        ));
    /*DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            children: [
              Spacer(),
              TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "MISSÕES",
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "QUIZZES",
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MissionsPage(),
            QuizzesPage(),
          ],
        ),
      ),
    );*/
  }
}
