import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:museu_vivo/shared/services/mission_service.dart';

class MissionRepository extends BlocBase {
  final MissionService missionService;
  final UserRepository userRepository;

  List<Mission> _missions;

  List<Mission> get missions => _missions;

  MissionRepository(this.missionService, this.userRepository);

  Future<List<Mission>> getMissions() async {
    final Response missionsReponse =
        await missionService.fetchMissions(userRepository.user.id);

    _missions = List<Mission>.from(
      missionsReponse.data.map((mission) => Mission.fromJson(mission)),
    );

    return _missions;
  }
}
