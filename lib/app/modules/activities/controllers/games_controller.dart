import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'games_controller.g.dart';

@Injectable()
class GamesController = _GamesControllerBase with _$GamesController;

abstract class _GamesControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
