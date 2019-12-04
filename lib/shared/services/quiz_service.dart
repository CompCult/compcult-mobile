import 'package:dio/dio.dart';

class QuizService {
  final Dio dio;

  QuizService(this.dio);

  Future<Response> fetchQuizzes(String userId) {
    return dio.get('/quizzes?answered=0');
  }

  Future<Response> fetchSecretQuiz(String quizId) {
    return dio.get('/quizzes?secret_code=$quizId');
  }
}
