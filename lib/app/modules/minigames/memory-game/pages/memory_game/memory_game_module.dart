import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/minigames/memory-game/models/memory_game.dart';

import 'memory_game_controller.dart';
import 'memory_game_page.dart';

class MemoryGameModule extends ModuleWidget {
  static const String routeName = '/memory-game';

  final MemoryGame _memoryGame;

  MemoryGameModule(this._memoryGame);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => MemoryGameController()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MemoryGamePage(_memoryGame);

  static Inject get to => Inject<MemoryGameModule>.of();
}
