import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/quiz_submit.dart';
import 'package:museu_vivo/pages/quizzes_bloc.dart';
import 'package:museu_vivo/shared/components/secret_code_field.dart';
import 'package:museu_vivo/shared/models/quiz.dart';

import '../shared/components/item_card.dart';
import '../shared/models/quiz.dart';

class QuizzesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QuizzesBloc quizzesBloc = BlocProvider.getBloc<QuizzesBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: <Widget>[
            SecretCodeField(
              label: 'Código secreto do quiz',
              onSubmited: (quizId) async {
                try {
                  Quiz quiz = await quizzesBloc.getSecretQuiz(quizId);

                  Navigator.of(context)
                      .pushNamed(QuizSubmit.routeName, arguments: quiz);
                } catch (e) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(e), backgroundColor: Colors.red),
                  );
                }
              },
            ),
            SizedBox(height: 15),
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

                return _buildList(snapshot.data);
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
}
