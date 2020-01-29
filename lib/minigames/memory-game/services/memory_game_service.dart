import 'package:dio/dio.dart';

class MemoryGameService {
  final Dio _dio;

  MemoryGameService(this._dio);

  Future<Response> getAll() {
    return _dio.get('/minigames/memories?answered=0');
  }

  Future<Response> getSecret(String secretCode) {
    return _dio.get('/minigames/memories?secret_code=$secretCode');
  }

  Future<Response> createMemoryGameAnswer(
      String memoryGameId, Map<String, dynamic> data) {
    return _dio.post(
      '/minigames/memories/:$memoryGameId/answers',
      data: data,
    );
  }
}
