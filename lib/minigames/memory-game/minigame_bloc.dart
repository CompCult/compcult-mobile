import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/minigames/memory-game/memory.dart';
import 'package:museu_vivo/minigames/memory-game/memory_game_repository.dart';


import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

class MemoryGamesBloc extends BlocBase {
  final MemoryGameRepository _memoryGameRepository;

  MemoryGamesBloc(this._memoryGameRepository);

  Observable<List<MemoryGame>> get memoryGames => _memoryGameRepository.memorygames;

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
}
