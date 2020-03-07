import 'dart:async';

import 'package:mobx/mobx.dart';

part 'memory_game_controller.g.dart';

class MemoryGameController = _MemoryGameControllerBase
    with _$MemoryGameController;

abstract class _MemoryGameControllerBase with Store {
  Timer timer;

  @observable
  int time = 0;
  @observable
  @action
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      time += 1;
    });
  }

  @action
  endTime() {
    timer.cancel();
  }
}
