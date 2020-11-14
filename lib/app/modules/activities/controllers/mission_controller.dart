import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'mission_controller.g.dart';

@Injectable()
class MissionController = _MissionControllerBase with _$MissionController;

abstract class _MissionControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
