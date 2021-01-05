import 'package:dio/dio.dart';
import 'package:museu_vivo/app/shared/utils/providers/custom_dio.dart';

class QuizService {
  final CustomDio dio;

  QuizService(this.dio);

  Future<Response> fetchQuizzes() {
    return dio.client.get('/quizzes?answered=0');
  }

  Future<Response> fetchSecretQuiz(String quizId) {
    return dio.client.get('/quizzes?secret_code=$quizId');
  }

  Future<Response> createQuizAnswer(String quizId, String answer) {
    return dio.client.post('/quizzes/$quizId/answers', data: {
      'answer': answer,
    });
  }
}
