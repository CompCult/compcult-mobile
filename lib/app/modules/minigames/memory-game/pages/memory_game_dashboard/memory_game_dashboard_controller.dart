import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/app/modules/minigames/memory-game/repositories/memory_game_repository.dart';

import '../../models/memory_game.dart';
part 'memory_game_dashboard_controller.g.dart';

class MemoryGameDashboardController = _MemoryGameDashboardControllerBase
    with _$MemoryGameDashboardController;

abstract class _MemoryGameDashboardControllerBase with Store {
  final MemoryGameRepository _memoryGameRepository;

  _MemoryGameDashboardControllerBase(this._memoryGameRepository) {
    getAllMemoryGames();
  }

  Function get getAllMemoryGames => _memoryGameRepository.getAll;

  ObservableList<MemoryGame> get memoryGames =>
      _memoryGameRepository.memoryGames;

  Future<MemoryGame> getSecretMemoryGame(String memoryGameId) async {
    try {
      return await _memoryGameRepository.fetchSecretMemoryGame(memoryGameId);
    } on DioError catch (e) {
      final statusCode = e.response.statusCode;
      String errorMessage = "Erro no servidor";

      if (statusCode == 404) {
        errorMessage = "Minigame não existe";
      } else if (e.response.statusCode == 401) {
        errorMessage = "Essa minigame expirou";
      }

      throw errorMessage;
    }
  }

  Future createMemoryGameAnswer(MemoryGame memoryGame) async {
    return _memoryGameRepository.createMemoryGameAnswer(memoryGame.id);
  }
}
