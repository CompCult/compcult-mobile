import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/minigames/memory-game/models/memory_game.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game/memory_game_module.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game_dashboard/memory_game_dashboard_controller.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game_dashboard/memory_game_dashboard_module.dart';
import 'package:museu_vivo/minigames/memory-game/repositories/memory_game_repository.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/models/quiz.dart';

import 'bloc/quizzes_bloc.dart';
import 'mission_submit.dart';
import 'missions_bloc.dart';

class Challenges extends StatefulWidget {
  @override
  _ChallengesState createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    final QuizzesBloc quizzesBloc = BlocProvider.getBloc<QuizzesBloc>();
    final MissionsBloc missionsBloc = BlocProvider.getBloc<MissionsBloc>();
    

  

  
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff60B3FC)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
                Text(
                  "DESAFIOS SEMANAIS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 7,
                        spreadRadius: 1,
                        offset: Offset(4, 6),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff0071D5)),
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/leratos/flag.png"),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "12 Missões",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    StreamBuilder(
                      stream: missionsBloc.missions,
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

                        return _buildListMissions(snapshot.data);
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 9,
            ),
            Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 7,
                        spreadRadius: 0.1,
                        offset: Offset(4, 6),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff0071D5)),
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Image.asset("assets/leratos/game-console(1).png"),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "7 Mini Games",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  children: <Widget>[
                     
                  ],
                )
                ),
            SizedBox(
              height: 9,
            ),
            Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 7,
                        spreadRadius: 0.1,
                        offset: Offset(4, 6),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff0071D5)),
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/leratos/test-quiz.png"),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "8 Quizzes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    StreamBuilder<List<Quiz>>(
                      stream: quizzesBloc.quizzes,
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

                        return _buildListQuizzes(snapshot.data);
                      },
                    ),
                  ],
                )
                )
          ],
        ),
      ),
    );
  }

  _buildListMissions(List<Mission> missions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: missions.length,
      itemBuilder: (_, i) {
        final mission = missions[i];

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "${i +1} - ${mission.name}",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildListQuizzes(List<Quiz> quizzes) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quizzes.length,
      itemBuilder: (_, i) {
        final quiz = quizzes[i];

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "${i +1} - ${quiz.name}",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildListMemoryGames(ObservableList<MemoryGame> memoryGames) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: memoryGames.length,
      itemBuilder: (_, i) {
        final memoryGame = memoryGames[i];

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "${i +1} - ${memoryGame.title}",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

  }
}
