import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/user/user_bloc.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';

class ThematicSession extends StatefulWidget {
  @override
  _ThematicSessionState createState() => _ThematicSessionState();
}

class _ThematicSessionState extends State<ThematicSession> {
  UserBloc bloc = BlocProvider.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xff60B3FC),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Image.asset("assets/leratos/arara.png"),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 10,
                bottom: 15,
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: Offset(4, 6),
                    )
                  ],
                  color: Color(0xff0071D5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        StreamBuilder<User>(
                            stream: bloc.user,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Container();
                              return Text(
                                'Olá, ${snapshot.data.name}!',
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    color: Colors.white),
                              );
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Me chamo Lara Arara e vou te ajudar e te dar algumas instruções sobre "
                          "este jogo.  "
                          "\nLogo abaixo de mim, você vai ter novas missões, quizzes e minigames para jogar."
                          "\nLogo acima de mim está o painel de seus poderes no jogo."
                          "\n E ai? Vamos Jogar?",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
