import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/minigames/memory-game/repositories/memory_game_repository.dart';
import 'package:museu_vivo/app/modules/minigames/memory-game/services/memory_game_service.dart';
import 'package:museu_vivo/app/modules/shared/repositories/dio_repository.dart';

import 'memory_game_dashboard_controller.dart';
import 'memory_game_dashboard_page.dart';

class MemoryGameDashboardModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => MemoryGameDashboardController(
              i.getDependency<MemoryGameRepository>(),
            )),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => MemoryGameRepository(i.getDependency<MemoryGameService>())),
        Dependency((i) =>
            MemoryGameService(BlocProvider.getDependency<DioRepository>().dio))
      ];

  @override
  Widget get view => MemoryGameDashboardPage();

  static Inject get to => Inject<MemoryGameDashboardModule>.of();
}
