import 'package:dio/dio.dart';

class MissionService {
  final Dio dio;

  MissionService(this.dio);

  Future<Response> fetchMissions(String userId) {
    return dio.get('/missions/public?user_id=$userId');
  }

  Future<Response> fetchSecretMission(String missionId) {
    return dio.get('/missions/private?secret_code=$missionId');
  }
}
