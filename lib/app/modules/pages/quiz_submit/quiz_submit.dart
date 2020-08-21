import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';
import 'package:museu_vivo/app/modules/shared/models/quiz.dart';

import 'quiz_submit_bloc.dart';

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
  Color color_selected = Colors.greenAccent;
  Color color_unselected = Colors.blue[50];

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
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "${widget.quiz.title.toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF50555C),
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    border: Border.all(color: Colors.blue),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "${widget.quiz.description}",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "SourceSansPro",
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildQuizForm(),
                SizedBox(height: 20),
                _buildButtonSubmit("ENVIAR RESPOSTA"),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizForm() {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            if (widget.quiz.alternativeA != null)
              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'a';
                    _changeColor(0);
                  });
                },
                color: colors[0] == false ? color_unselected : color_selected,
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
              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'b';
                    _changeColor(1);
                  });
                },
                color: colors[1] == false ? color_unselected : color_selected,
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
              FlatButton(
                color: colors[2] == false ? color_unselected : color_selected,
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
              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'd';
                    _changeColor(3);
                  });
                },
                color: colors[3] == false ? color_unselected : color_selected,
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
              FlatButton(
                onPressed: () {
                  setState(() {
                    _alternative = 'e';
                    _changeColor(4);
                  });
                },
                color: colors[4] == false ? color_unselected : color_selected,
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
                  borderRadius: BorderRadius.circular(30),
                ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
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
      },
    );
  }
}
