import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:museu_vivo/minigames/memory-game/memory_game.dart';
import 'package:museu_vivo/minigames/memory-game/memory_games_pages.dart';
import 'package:museu_vivo/shared/components/secret_code_field.dart';
import 'package:provider/provider.dart';

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
      body: Padding(
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
                    builder: (context) => MemoryGamesPage(),
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
      ),
    );
  }
}
