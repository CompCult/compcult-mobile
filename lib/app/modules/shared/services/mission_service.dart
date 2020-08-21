import 'package:dio/dio.dart';

class MissionService {
  final Dio _dio;

  MissionService(this._dio);

  Future<Response> fetchMissions(String userId) {
    return _dio.get('/missions');
  }

  Future<Response> fetchSecretMission(String missionId) {
    return _dio.get('/missions?secret_code=$missionId');
  }

  Future<Response> createMissionAnswer(
      String missionId, Map<String, dynamic> data) {
    return _dio.post(
      '/missions/$missionId/answers',
      data: data,
    );
  }
}
