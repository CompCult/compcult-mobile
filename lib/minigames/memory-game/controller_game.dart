import 'dart:async';

import 'package:mobx/mobx.dart';
part 'controller_game.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  Timer timer;

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
