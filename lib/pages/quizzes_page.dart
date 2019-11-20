import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/pages/quiz_submit.dart';
import 'package:museu_vivo/shared/components/secret_code_field.dart';
import 'package:museu_vivo/shared/models/quiz.dart';
import 'package:provider/provider.dart';

import '../shared/providers/user_provider.dart';
import '../shared/components/item_card.dart';
import '../shared/models/quiz.dart';

class QuizzesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = Provider.of<UserProvider>(context).userId;
    final Dio dio = Provider.of<Dio>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: <Widget>[
            SecretCodeField(
              label: 'Código secreto do quiz',
              onSubmited: (quizId) async {
                try {
                  Response response =
                      await dio.get('/quizzes/private?secret_code=$quizId');

                  Quiz quiz = Quiz.fromJson(response.data);

                  Navigator.of(context)
                      .pushNamed(QuizSubmit.routeName, arguments: quiz);
                } on DioError catch (e) {
                  if (e.response.statusCode == 404) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Quiz não existe'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (e.response.statusCode == 401) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Esse quiz expirou'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: 15),
            FutureBuilder(
              future: _getQuizzes(userId, dio),
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

                final List<Quiz> quizzes = List<Quiz>.from(
                    response.data.map((quiz) => Quiz.fromJson(quiz)));
                return _buildList(quizzes);
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildList(List<Quiz> quizzes) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quizzes.length,
      itemBuilder: (_, i) {
        final quiz = quizzes[i];

        return ItemCard(
          item: quiz,
          routeName: QuizSubmit.routeName,
        );
      },
    );
  }

  Future<Response> _getQuizzes(int userId, Dio dio) {
    return dio.get('/quizzes/public?user_id=$userId');
  }
}
