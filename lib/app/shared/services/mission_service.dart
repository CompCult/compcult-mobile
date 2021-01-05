import 'package:dio/dio.dart';
import 'package:museu_vivo/app/shared/utils/providers/custom_dio.dart';

class MissionService {
  final CustomDio dio;

  MissionService(this.dio);

  Future<Response> fetchMissions() {
    return dio.client.get('/missions?answered=0');
  }

  Future<Response> fetchSecretMission(String missionId) {
    return dio.client.get('/missions?secret_code=$missionId');
  }

  Future<Response> createMissionAnswer(
      String missionId, Map<String, dynamic> data) {
    return dio.client.post(
      '/missions/$missionId/answers',
      data: data,
    );
  }
}
