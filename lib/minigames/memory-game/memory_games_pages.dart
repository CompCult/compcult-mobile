import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/minigames/memory-game/memory.dart';
import 'package:museu_vivo/shared/components/item_card.dart';
import 'package:museu_vivo/shared/components/secret_code_field.dart';

import 'minigame_bloc.dart';

class MemoryGamesPage extends StatefulWidget {
  static const String routeName = '/memory-game';
  @override
  _MemoryGamesPageState createState() => _MemoryGamesPageState();
}

class _MemoryGamesPageState extends State<MemoryGamesPage> {

  final MemoryGamesBloc memoryGamesBloc = BlocProvider.getBloc<MemoryGamesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da Memória", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff00036c),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            SecretCodeField(
              label: 'Código secreto do jogo da memória',
              onSubmited: (memoryGameId) async {
                try {
                  MemoryGame memoryGame =
                      await memoryGamesBloc.getSecretMemoryGame(memoryGameId);

                  Navigator.of(context).popAndPushNamed(MemoryGamesPage.routeName);
                } catch (e) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(e), backgroundColor: Colors.red),
                  );
                }
              },
            ),
            SizedBox(height: 15),
            StreamBuilder(
              stream: memoryGamesBloc.memoryGames,
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return _buildList(snapshot.data);
              },
            ),
          ],
        ),
      )
    );
  }

  _buildList(List<MemoryGame> memoryGames) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: memoryGames.length,
      itemBuilder: (_, i) {
        final memoryGame = memoryGames[i];

        return ItemCard(
          item: memoryGame,
          routeName: MemoryGamesPage.routeName,
        );
      },
    );
  }
}