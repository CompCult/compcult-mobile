import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/app/modules/shared/models/quiz.dart';
import 'package:museu_vivo/app/modules/shared/repositories/quiz_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

class QuizzesBloc extends BlocBase {
  final QuizRepository quizRepository;

  QuizzesBloc(this.quizRepository);

  Observable<List<Quiz>> get quizzes => quizRepository.quizzes;

  Future<Quiz> getSecretQuiz(String quizId) async {
    try {
      return await quizRepository.fetchSecretQuiz(quizId);
    } on DioError catch (e) {
      final statusCode = e.response.statusCode;
      String errorMessage = "Erro no servidor";

      if (statusCode == 404) {
        errorMessage = "Quiz não existe";
      } else if (e.response.statusCode == 401) {
        errorMessage = "Esse quiz expirou";
      }
      throw errorMessage;
    }
  }
}
