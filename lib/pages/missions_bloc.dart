import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';
import 'package:rxdart/rxdart.dart';

class MissionsBloc extends BlocBase {
  final MissionRepository _missionRepository;

  MissionsBloc(this._missionRepository);

  Observable<List<Mission>> get missions => _missionRepository.missions;
}
