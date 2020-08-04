import "package:flutter/material.dart";
import 'package:museu_vivo/app/modules/minigames/memory-game/pages/memory_game_dashboard/memory_game_dashboard_module.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';

class MiniGames extends StatefulWidget {
  @override
  _MiniGamesState createState() => _MiniGamesState();
}

class _MiniGamesState extends State<MiniGames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
      ),
      body: SingleChildScrollView(
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
                              builder: (context) => MemoryGameDashboardModule(),
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/leratos/jogo_da_memoria.jpg",
                          height: 120,
                          width: 120,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
