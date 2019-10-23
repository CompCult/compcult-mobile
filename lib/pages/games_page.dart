import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './missions_page.dart';
import './quizzes_page.dart';

class GamesPage extends StatelessWidget {
  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return DefaultTabController(
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
    );
  }
}
