import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/app/modules/shared/models/mission.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';
import 'package:museu_vivo/app/modules/shared/services/mission_service.dart';

import 'package:rxdart/rxdart.dart';

class MissionRepository extends BlocBase {
  final MissionService _missionService;
  final UserRepository userRepository;

  BehaviorSubject<List<Mission>> _missionsController =
      BehaviorSubject<List<Mission>>();

  MissionRepository(this._missionService, this.userRepository);

  Observable<List<Mission>> get missions => _missionsController.stream;

  fetchMissions() {
    userRepository.user.listen((user) async {
      final Response missionsResponse =
          await _missionService.fetchMissions(user.id);

      _missionsController.sink.add(List<Mission>.from(
        missionsResponse.data.map((mission) => Mission.fromJson(mission)),
      ));
    });
  }

  Future<Mission> fetchSecretMission(String missionId) async {
    final Response missionsResponse =
        await _missionService.fetchSecretMission(missionId);

    return Mission.fromJson(missionsResponse.data[0]);
  }

  Future createMissionAnswer(
      String missionId, Map<String, dynamic> data) async {
    userRepository.user.listen((user) async {
      return await _missionService.createMissionAnswer(missionId, data);
    });
  }

  @override
  void dispose() {
    _missionsController.close();
    super.dispose();
  }
}
