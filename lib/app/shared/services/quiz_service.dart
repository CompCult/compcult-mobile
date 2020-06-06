import 'package:dio/dio.dart';

class QuizService {
  final Dio _client;

  QuizService(this._client);

  Future<Response> fetchQuizzes(String userId) {
    return _client.get('/quizzes?answered=0');
  }

  Future<Response> fetchSecretQuiz(String quizId) {
    return _client.get('/quizzes?secret_code=$quizId');
  }

  Future<Response> createQuizAnswer(String quizId, String answer) {
    return _client.post('/quizzes/$quizId/answers', data: {
      'answer': answer,
    });
  }
}
