import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/pages/quiz_submit.dart';
import 'package:museu_vivo/shared/models/quiz.dart';
import 'package:provider/provider.dart';

import '../shared/providers/user_provider.dart';
import '../shared/components/item_card.dart';
import '../shared/models/quiz.dart';

class QuizzesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = Provider.of<UserProvider>(context).userId;

    return FutureBuilder(
      future: _getQuizzes(userId),
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

        final Response response = snapshot.data;

        final List<Quiz> quizzes =
            List<Quiz>.from(response.data.map((quiz) => Quiz.fromJson(quiz)));

        return _buildList(quizzes);
      },
    );
  }

  _buildList(List<Quiz> Quizzes) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      itemCount: Quizzes.length,
      itemBuilder: (_, i) {
        final quiz = Quizzes[i];

        return ItemCard(
          item: quiz,
          routeName: QuizSubmit.routeName,
        );
      },
    );
  }

  Future<Response> _getQuizzes(int userId) {
    return Dio().get(
        'https://museu-vivo-api.herokuapp.com/quizzes/public?user_id=$userId');
  }
}
