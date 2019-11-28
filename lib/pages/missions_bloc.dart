import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';

class MissionsBloc extends BlocBase {
  final MissionRepository missionRepository;

  MissionsBloc(this.missionRepository);

  Future<List<Mission>> get missions => missionRepository.getMissions();
}
