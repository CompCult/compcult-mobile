import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/activities/controllers/games_controller.dart';

class GamesPage extends StatefulWidget {
  final String title;
  const GamesPage({Key key, this.title = "Game"}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends ModularState<GamesPage, GamesController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Games Page"),
      ),
    );
  }
}
