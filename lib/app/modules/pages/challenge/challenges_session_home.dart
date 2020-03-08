import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/mission/missions_bloc.dart';
import 'package:museu_vivo/app/modules/pages/quiz/quizzes_bloc.dart';
import 'package:museu_vivo/app/modules/shared/models/mission.dart';
import 'package:museu_vivo/app/modules/shared/models/quiz.dart';

import '../mission_submit/mission_submit.dart';

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
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xff60B3FC),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  "DESAFIOS SEMANAIS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _containerItems("Missões", "assets/leratos/flag.png",
                missionsBloc.missions, _buildListMissions),
            SizedBox(
              height: 10,
            ),
            _containerItems("Quizzes", "assets/leratos/test-quiz.png",
                quizzesBloc.quizzes, _buildListQuizzes),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _buildListQuizzes(List<Quiz> quizzes) {
    return _buildListItems(quizzes);
  }

  _buildListMissions(List<Mission> missions) {
    return _buildListItems(missions);
  }

  _buildListItems(var items) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];

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
                  child: GestureDetector(
                    child: Text(
                      "${i + 1} - ${item.name}",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(MissionSubmit.routeName, arguments: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _containerItems(
      String label, String assetPath, Stream stream, Function function) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 7,
            spreadRadius: 1,
            offset: Offset(4, 6),
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xff0071D5),
      ),
      child: ExpansionTile(
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(assetPath),
            ),
            SizedBox(
              width: 40,
            ),
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ],
        ),
        children: <Widget>[
          StreamBuilder(
            stream: stream,
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
              return function(snapshot.data);
            },
          ),
        ],
      ),
    );
  }
}
