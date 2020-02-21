import 'package:flutter/material.dart';

class Challenges extends StatefulWidget {
  @override
  _ChallengesState createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
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
                SizedBox(width: 8,),
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
                  title:Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/leratos/flag.png"),
                    ),
                    SizedBox(width: 40,),
                    Text(
                      "12 Missões",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white),
                    ),
                  ],
                ))
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
                title:Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/leratos/game-console(1).png"),
                  ),
                  SizedBox(width: 50,),
                  Text(
                    "7 Mini Games",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                ],
              ),
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
                title:Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/leratos/test-quiz.png"),
                  ),
                  SizedBox(width: 50,),
                  Text(
                    "8 Quizzes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                ],
              ),
                )
            )
          ],
        ),
      ),
    );
  }
}
