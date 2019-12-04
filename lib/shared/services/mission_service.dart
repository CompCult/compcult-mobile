import 'package:dio/dio.dart';

class MissionService {
  final Dio dio;

  MissionService(this.dio);

  Future<Response> fetchMissions(String userId) {
    return dio.get('/missions?answered=0');
  }

  Future<Response> fetchSecretMission(String missionId) {
    return dio.get('/missions?secret_code=$missionId');
  }
}
