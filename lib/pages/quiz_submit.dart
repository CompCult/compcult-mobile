import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/shared/models/quiz.dart';
import 'package:museu_vivo/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

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
    final userId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(title: Text('Submeter Quiz')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          Dio()
              .post('https://museu-vivo-api.herokuapp.com/quiz_answers', data: {
            '_user': userId,
            '_quiz': widget.quiz.id,
            'answer': _alternative,
          });

          Navigator.of(context).pop(true);
        },
      ),
      body: ListView(
        children: <Widget>[
          Text('${widget.quiz.title}'),
          Text('${widget.quiz.description}'),
          _buildQuizForm(),
        ],
      ),
    );
  }

  Widget _buildQuizForm() {
    return Column(
      children: <Widget>[
        RadioListTile(
          groupValue: _alternative,
          value: 'a',
          title: Text(widget.quiz.alternativeA),
          onChanged: (value) => setState(() {
            _alternative = value;
          }),
        ),
        RadioListTile(
          groupValue: _alternative,
          value: 'b',
          title: Text(widget.quiz.alternativeB),
          onChanged: (value) => setState(() {
            _alternative = value;
          }),
        ),
        RadioListTile(
          groupValue: _alternative,
          value: 'c',
          title: Text(widget.quiz.alternativeC),
          onChanged: (value) => setState(() {
            _alternative = value;
          }),
        ),
        RadioListTile(
          groupValue: _alternative,
          value: 'd',
          title: Text(widget.quiz.alternativeD),
          onChanged: (value) => setState(() {
            _alternative = value;
          }),
        ),
        RadioListTile(
          groupValue: _alternative,
          value: 'e',
          title: Text(widget.quiz.alternativeE),
          onChanged: (value) => setState(() {
            _alternative = value;
          }),
        ),
      ],
    );
  }
}
