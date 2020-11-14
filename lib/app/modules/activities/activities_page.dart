import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/widgets/card_item.dart';

import 'activities_controller.dart';

class ActivitiesPage extends StatefulWidget {
  final String title;
  const ActivitiesPage({Key key, this.title = "Activities"}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState
    extends ModularState<ActivitiesPage, ActivitiesController> {
  //use 'controller' variable to access controller

  final List<Map<String, dynamic>> _items = [
    {
      "label": "QUIZZES",
      "imageFileName": "quizzes-icon.png",
      "routeName": "/activities/quizzes",
    },
    {
      "label": "MISSÕES",
      "imageFileName": "missions-icon.png",
      "routeName": "/activities/missions",
    },
    {
      "label": "MINI\nJOGOS",
      "imageFileName": "minigames-icon.png",
      "routeName": "/activities/games",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(250, 250, 250, 1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    bottom: 30.0,
                  ),
                  child: Text(
                    "O que vamos fazer hoje?",
                    style: TextStyle(
                      color: Color(0xFF2d91e7),
                      fontFamily: "Product Sans",
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ..._items.map(
                  (element) => Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: CardItem(
                      label: element["label"],
                      imageFileName: element["imageFileName"],
                      routeName: element["routeName"],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
