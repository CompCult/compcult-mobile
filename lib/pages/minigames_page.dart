import "package:flutter/material.dart";
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game_dashboard/memory_game_dashboard_module.dart';

class MiniGames extends StatefulWidget {
  @override
  _MiniGamesState createState() => _MiniGamesState();
}

class _MiniGamesState extends State<MiniGames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Minigames"),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MemoryGameDashboardModule(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "assets/leratos/jogo_da_memoria.jpg",
                            height: 150,
                            width: 150,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jogo da Memória",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/leratos/jogo_da_vida.jpg",
                            height: 150,
                            width: 150,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jogo da Vida",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/leratos/jogo_1.jpg",
                            height: 150,
                            width: 150,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jogo xxxxx",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {},
                            child: Card(
                              child: Image.asset(
                                "assets/leratos/jogo_2.jpg",
                                height: 150,
                                width: 150,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jogo xxxx",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

        /*Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            ListTile(
              title: Text("Jogo da Memória"),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoryGameDashboardModule(),
                  ),
                );
              },
            ),
            Divider(height: 0),
            ListTile(
              title: Text("Minigame 2"),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              onTap: () {},
            ),
            Divider(height: 0),
            ListTile(
              title: Text("Minigame 3"),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              onTap: () {},
            ),
            Divider(height: 0),
          ],
        ),
      ),*/
        );
  }
}
