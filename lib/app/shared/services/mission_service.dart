import 'package:dio/dio.dart';

class MissionService {
  final Dio _client;

  MissionService(this._client);

  Future<Response> fetchMissions(String userId) {
    return _client.get('/missions?answered=0');
  }

  Future<Response> fetchSecretMission(String missionId) {
    return _client.get('/missions?secret_code=$missionId');
  }

  Future<Response> createMissionAnswer(
      String missionId, Map<String, dynamic> data) {
    return _client.post(
      '/missions/$missionId/answers',
      data: data,
    );
  }
}
