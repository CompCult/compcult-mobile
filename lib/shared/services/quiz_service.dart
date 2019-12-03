import 'package:dio/dio.dart';

class QuizService {
  final Dio dio;

  QuizService(this.dio);

  Future<Response> fetchQuizzes(int userId) {
    return dio.get('/quizzes/public?user_id=$userId');
  }

  Future<Response> fetchSecretQuiz(String quizId) {
    return dio.get('/quizzes/private?secret_code=$quizId');
  }
}
