import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          "Submeter quiz",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        children: <Widget>[
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
          ),
          _buildQuizForm(),
          // const SizedBox(
          //   height: 20,
          // ),
        ],
      ),
      // bottomNavigationBar: _buildButtonSubmit("ENVIAR RESPOSTA", userId),
      bottomSheet: _buildButtonSubmit("ENVIAR RESPOSTA"),
    );
  }

  Widget _buildQuizForm() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 275,
      ),
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              if (widget.quiz.alternativeA != null)
                RadioListTile(
                  groupValue: _alternative,
                  value: 'a',
                  title: Text(
                    widget.quiz.alternativeA,
                    style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                  ),
                  onChanged: (value) => setState(() {
                    _alternative = value;
                  }),
                ),
              if (widget.quiz.alternativeB != null)
                RadioListTile(
                  groupValue: _alternative,
                  value: 'b',
                  title: Text(
                    widget.quiz.alternativeB,
                    style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                  ),
                  onChanged: (value) => setState(() {
                    _alternative = value;
                  }),
                ),
              if (widget.quiz.alternativeC != null)
                RadioListTile(
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
              if (widget.quiz.alternativeD != null)
                RadioListTile(
                  groupValue: _alternative,
                  value: 'd',
                  title: Text(
                    widget.quiz.alternativeD,
                    style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                  ),
                  onChanged: (value) => setState(() {
                    _alternative = value;
                  }),
                ),
              if (widget.quiz.alternativeE != null)
                RadioListTile(
                  groupValue: _alternative,
                  value: 'e',
                  title: Text(
                    widget.quiz.alternativeE,
                    style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                  ),
                  onChanged: (value) => setState(() {
                    _alternative = value;
                  }),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSubmit(String label) {
    final QuizSubmitBloc quizSubmitBloc =
        BlocProvider.getBloc<QuizSubmitBloc>();

    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Theme.of(context).accentColor,
      child: SizedBox.expand(
        child: FlatButton(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            onPressed: () async {
              await quizSubmitBloc.createQuizAnswer(
                  widget.quiz.id, _alternative);

              Navigator.of(context).pop(true);
            }),
      ),
    );
  }
}
