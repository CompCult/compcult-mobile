import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';

class HomeBloc extends BlocBase {
  final MissionRepository _missionRepository;

  HomeBloc(this._missionRepository);

  fetchMissions() => _missionRepository.fetchMissions();
}
