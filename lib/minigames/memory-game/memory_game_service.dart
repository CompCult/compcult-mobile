import 'package:dio/dio.dart';

class MemoryGameService {
  final Dio _dio;

  MemoryGameService(this._dio);

  Future<Response> fetchMemoryGames(String userId) {
    return _dio.get('/minigames/memories?answered=0');
  }

  Future<Response> fetchSecretMemoryGame(String memoryGameId) {
    return _dio.get('/minigames/memories?secret_code=$memoryGameId');
  }

  Future<Response> createMemoryGameAnswer(
      String memoryGameId, Map<String, dynamic> data) {
    return _dio.post(
      '/minigames/memories/:$memoryGameId/answers',
      data: data,
    );
  }
}