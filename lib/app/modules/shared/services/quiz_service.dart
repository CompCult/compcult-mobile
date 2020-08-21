import 'package:dio/dio.dart';

class QuizService {
  final Dio dio;

  QuizService(this.dio);

  Future<Response> fetchQuizzes(String userId) {
    return dio.get('/quizzes');
  }

  Future<Response> fetchSecretQuiz(String quizId) {
    return dio.get('/quizzes?secret_code=$quizId');
  }

  Future<Response> createQuizAnswer(String quizId, String answer) {
    return dio.post('/quizzes/$quizId/answers', data: {
      'answer': answer,
    });
  }
}
