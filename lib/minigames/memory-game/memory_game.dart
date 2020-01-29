import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'memory_game_controller.dart';

class MemoryGamePage extends StatefulWidget {
  static const String routeName = '/memory-game';

  final List<String> images;

  const MemoryGamePage({Key key, this.images});
  @override
  _MemoryGamePageState createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  // Quantidade dos cards
  int size = 16;

  final controller = BlocProvider.getBloc<MemoryGameController>();

  List<bool> cardFlips = [];
  List<String> data = [];
  List<GlobalKey<FlipCardState>> cardStateKeys = [];

  var previousIndex = -1;
  var flip = false;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < this.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }

    widget.images.forEach((imageUrl) {
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
                          child: Image.network(data[index]),
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
              // Condição para os cards se multiplicarem até 24 cards
              // size <= 24 ? size *= 2 : size = size;
              this.controller.endTime();
              Navigator.of(context).pop();
              Navigator.of(context).popAndPushNamed(MemoryGamePage.routeName);
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
