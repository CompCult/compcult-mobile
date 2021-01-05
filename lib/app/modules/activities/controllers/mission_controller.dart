import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/models/mission_model.dart';
import 'package:museu_vivo/app/shared/services/mission_service.dart';

part 'mission_controller.g.dart';

@Injectable()
class MissionController = _MissionControllerBase with _$MissionController;

abstract class _MissionControllerBase with Store {
  final _missionService = Modular.get<MissionService>();

  @observable
  List<MissionModel> missions = [];

  @action
  Future<void> fetchMissions() async {
    Response missionsResponse = await _missionService.fetchMissions(); 
    print(missionsResponse);
  }
}
