import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/shared/components/custom_appbar.dart';
import 'package:museu_vivo/shared/models/quiz.dart';

import 'bloc/quiz_submit_bloc.dart';

class QuizSubmit extends StatefulWidget {
  static const String routeName = '/quiz-submission';

  final Quiz quiz;

  QuizSubmit(this.quiz);

  @override
  _QuizSubmitState createState() => _QuizSubmitState();
}

class _QuizSubmitState extends State<QuizSubmit> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  String _alternative = 'a';
  List<bool> colors = [false, false, false, false, false];

  _changeColor(int ind) {
    setState(() {
      colors = [false, false, false, false, false];
      colors[ind] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: CustomAppBar(),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/leratos/fundo_quizzes.jpg"),
                  fit: BoxFit.cover)),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Container(
                width: 600,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white.withOpacity(0.7)),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Center(
                              child: Text(
                            "...",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Colors.blue),
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "${widget.quiz.title}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                "${widget.quiz.description}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "SourceSansPro",
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    /*Column(
                  children: <Widget>[
                    Text(
                      "${widget.quiz.title}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      child: SingleChildScrollView(
                        child: Text(
                          "${widget.quiz.description}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "SourceSansPro",
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),*/
                    SizedBox(
                      height: 35,
                    ),
                    _buildQuizForm(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildButtonSubmit("ENVIAR RESPOSTA")

                    // const SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            ],
          )),
      //bottomSheet: _buildButtonSubmit("ENVIAR RESPOSTA"),
      // bottomNavigationBar: _buildButtonSubmit("ENVIAR RESPOSTA", userId),
    );
  }

  Widget _buildQuizForm() {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            if (widget.quiz.alternativeA != null)
              /*RadioListTile(
                groupValue: _alternative,
                value: 'a',
                title: Text(
                  widget.quiz.alternativeA,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                ),
                onChanged: (value) => setState(() {
                  _alternative = value;
                }),
              ),*/
              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'a';
                    _changeColor(0);
                  });
                },
                color: colors[0] == false
                    ? Colors.white
                    : Color(0xff60B3FC).withOpacity(0.4),
                child: Container(
                  width: 290,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.quiz.alternativeA,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            SizedBox(
              height: 5,
            ),
            if (widget.quiz.alternativeB != null)

              /*RadioListTile(
                groupValue: _alternative,
                value: 'b',
                title: Text(
                  widget.quiz.alternativeB,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                ),
                onChanged: (value) => setState(() {
                  _alternative = value;
                }),
              ),*/

              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'b';
                    _changeColor(1);
                  });
                },
                color: colors[1] == false
                    ? Colors.white
                    : Color(0xff60B3FC).withOpacity(0.4),
                child: Container(
                  width: 290,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.quiz.alternativeB,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            SizedBox(
              height: 5,
            ),
            if (widget.quiz.alternativeC != null)

              /*RadioListTile(
                groupValue: _alternative,
                value: 'c',
                title: Text(
                  widget.quiz.alternativeC,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                ),
                onChanged: (value) => setState(() {
                  _alternative = value;
                }),
              ),
              */

              FlatButton(
                color: colors[2] == false
                    ? Colors.white
                    : Color(0xff60B3FC).withOpacity(0.4),
                onPressed: () {
                  setState(() {
                    _alternative = 'c';
                    _changeColor(2);
                  });
                },
                child: Container(
                  width: 290,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.quiz.alternativeC,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            SizedBox(
              height: 5,
            ),
            if (widget.quiz.alternativeD != null)

              /* RadioListTile(
                groupValue: _alternative,
                value: 'd',
                title: Text(
                  widget.quiz.alternativeD,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                ),
                onChanged: (value) => setState(() {
                  _alternative = value;
                }),
              ),*/

              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'd';
                    _changeColor(3);
                  });
                },
                color: colors[3] == false
                    ? Colors.white
                    : Color(0xff60B3FC).withOpacity(0.4),
                child: Container(
                  width: 290,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.quiz.alternativeD,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            SizedBox(
              height: 5,
            ),
            if (widget.quiz.alternativeE != null)

              /*RadioListTile(
                groupValue: _alternative,
                value: 'e',
                title: Text(
                  widget.quiz.alternativeE,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                ),
                onChanged: (value) => setState(() {
                  _alternative = value;
                }),
              ),*/

              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'e';
                    _changeColor(4);
                  });
                },
                color: colors[4] == false
                    ? Colors.white
                    : Color(0xff60B3FC).withOpacity(0.4),
                child: Container(
                  width: 290,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.quiz.alternativeE,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonSubmit(String label) {
    final QuizSubmitBloc quizSubmitBloc =
        BlocProvider.getBloc<QuizSubmitBloc>();

    return FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.blue,
        child: Container(
          height: 45,
          width: 150,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        onPressed: () async {
          await quizSubmitBloc.createQuizAnswer(widget.quiz.id, _alternative);

          Navigator.of(context).pop(true);
        });
  }
}
