import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:museu_vivo/minigames/memory-game/models/memory_game.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game/memory_game_controller.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game/memory_game_module.dart';

class MemoryGamePage extends StatefulWidget {
  static const String routeName = '/memory-game';

  final MemoryGame memoryGame;

  const MemoryGamePage(this.memoryGame);
  @override
  _MemoryGamePageState createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  final controller = MemoryGameModule.to.getBloc<MemoryGameController>();

  List<bool> cardFlips = [];
  List<String> data = [];
  List<GlobalKey<FlipCardState>> cardStateKeys = [];

  var previousIndex = -1;
  var flip = false;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.memoryGame.images.length * 2; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }

    widget.memoryGame.images.forEach((imageUrl) {
      data.add(imageUrl);
      data.add(imageUrl);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.endTime();
  }

  @override
  Widget build(BuildContext context) {
    controller.startTimer();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  bottom: 30,
                ),
                child: Center(
                  child: Observer(
                    builder: (_) {
                      return Text(
                        "Tempo: ${controller.time}",
                        style: Theme.of(context).textTheme.display1,
                      );
                    },
                  ),
                ),
              ),
              Theme(
                data: ThemeData.dark(),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    // Itens da grade do jogo da memória (flip cards)
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data[previousIndex] != data[index]) {
                              cardStateKeys[previousIndex]
                                  .currentState
                                  .toggleCard();
                              previousIndex = index;
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;

                              if (cardFlips.every((test) => test == false)) {
                                showResult();
                              }
                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        margin: EdgeInsets.all(4),
                        color: Color(0xff00036c),
                        child: Image.asset(
                            'assets/leratos/memory_borda_cinza.png'),
                      ),
                      back: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        margin: EdgeInsets.all(4),
                        color: Colors.blue,
                        child: Center(
                          child: Image.network(
                            data[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    itemCount: data.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showResult() {
    this.controller.endTime();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Parabéns, você venceu!!!"),
        content: Text(
          "Seu tempo: ${controller.time}",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              this.controller.endTime();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              "Continuar",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
