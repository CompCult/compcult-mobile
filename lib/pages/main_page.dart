import 'package:flutter/material.dart';

import './missions_page.dart';
import './quizzes_page.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meu Vivo Museu'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            PopupMenuButton<int>(
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Sair"),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'MISSÕES'),
              Tab(text: 'QUIZZES'),
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
