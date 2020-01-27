import 'package:dio/dio.dart';

class MinigameService {
  final Dio _dio;

  MinigameService(this._dio);

  Future<Response> fetchMinigames(String userId) {
    return _dio.get('/minigames/memories?answered=0');
  }

  Future<Response> fetchSecretMinigame(String minigameId) {
    return _dio.get('/minigames/memories?secret_code=$minigameId');
  }

  Future<Response> createMinigameAnswer(
      String minigameId, Map<String, dynamic> data) {
    return _dio.post(
      '/minigames/memories/:$minigameId/answers',
      data: data,
    );
  }
}