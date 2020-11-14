import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'activities_controller.g.dart';

@Injectable()
class ActivitiesController = _ActivitiesControllerBase
    with _$ActivitiesController;

abstract class _ActivitiesControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
