import 'dart:async';

import 'package:mobx/mobx.dart';

import 'memory_game_repository.dart';
part 'memory_game_controller.g.dart';

class MemoryGameController = _MemoryGameControllerBase
    with _$MemoryGameController;

abstract class _MemoryGameControllerBase with Store {
  MemoryGameRepository _minigameRepository;
  Timer timer;
  _MemoryGameControllerBase(this._minigameRepository);

  Future getMemoryGames() {
    return _minigameRepository.fetchSecretMemoryGame('YUMr2E');
  }

  @observable
  int time = 0;

  @action
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      time = time + 1;
      print(time);
    });
  }

  @action
  endTime() {
    timer.cancel();
  }
}
