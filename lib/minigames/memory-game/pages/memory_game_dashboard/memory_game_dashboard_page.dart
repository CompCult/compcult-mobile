import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/minigames/memory-game/models/memory_game.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game/memory_game_module.dart';

import '../../../../shared/components/secret_code_field.dart';
import '../../models/memory_game.dart';
import 'memory_game_dashboard_controller.dart';
import 'memory_game_dashboard_module.dart';

class MemoryGameDashboardPage extends StatefulWidget {
  static const String routeName = '/memory-game';
  @override
  _MemoryGameDashboardPageState createState() =>
      _MemoryGameDashboardPageState();
}

class _MemoryGameDashboardPageState extends State<MemoryGameDashboardPage> {
  final controller =
      MemoryGameDashboardModule.to.getBloc<MemoryGameDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Jogos da Memória",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff00036c),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15),
              SecretCodeField(
                label: 'Código secreto do jogo da mémoria',
                onSubmited: (memoryGameId) async {
                  try {
                    MemoryGame memoryGame = await controller.getSecretMemoryGame(memoryGameId);

                    Navigator.of(context)
                        .pushNamed(MemoryGameModule.routeName, arguments: memoryGame);
                  } catch (e) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(e), backgroundColor: Colors.red),
                    );
                  }
                },
              ),
              SizedBox(height: 15),
              RefreshIndicator(
                onRefresh: controller.getAllMemoryGames,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Observer(builder: (_) => _buildList(controller.memoryGames)),
                      ],
                    ),
                  ),
                ),
              ),
                ],
              ),
            )
            
        )
        );
  }

  _buildList(ObservableList<MemoryGame> memoryGames) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: memoryGames.length,
      itemBuilder: (_, i) {
        final memoryGame = memoryGames[i];

        return Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              title: Text(memoryGame.title),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context)
                  .pushNamed(MemoryGameModule.routeName, arguments: memoryGame),
            ),
            Divider(height: 0),
          ],
        );
      },
    );
  }
}
