import 'package:dio/dio.dart';

class MissionService {
  final Dio dio;

  MissionService(this.dio);

  Future<Response> fetchMissions(int userId) {
    return dio.get('/missions/public?user_id=$userId');
  }
}
