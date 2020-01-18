import "package:flutter/material.dart";
import 'package:museu_vivo/minigames/memory-game/memory_game.dart';

class MiniGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minigames"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Jogo da Memória"),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoryGamePage(),
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
