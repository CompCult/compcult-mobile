import 'dart:async';

import 'package:mobx/mobx.dart';

import 'memory_game_repository.dart';
part 'controller_game.g.dart';

class ControllerMemoryGame = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  MemoryGameRepository _minigameRepository;
  Timer timer;
  ControllerBase(this._minigameRepository);

  Future getMemoryGames(){
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
