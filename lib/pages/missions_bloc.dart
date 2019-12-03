import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

class MissionsBloc extends BlocBase {
  final MissionRepository _missionRepository;

  MissionsBloc(this._missionRepository);

  Observable<List<Mission>> get missions => _missionRepository.missions;

  Future<Mission> getSecretMission(String missionId) async {
    try {
      return await _missionRepository.fetchSecretMission(missionId);
    } on DioError catch (e) {
      final statusCode = e.response.statusCode;
      String errorMessage = "Erro no servidor";

      if (statusCode == 404) {
        errorMessage = "Missão não existe";
      } else if (e.response.statusCode == 401) {
        errorMessage = "Essa missão expirou";
      }

      throw errorMessage;
    }
  }
}
