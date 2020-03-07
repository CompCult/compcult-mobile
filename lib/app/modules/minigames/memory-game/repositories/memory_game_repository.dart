import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/modules/minigames/memory-game/services/memory_game_service.dart';
import '../models/memory_game.dart';

part 'memory_game_repository.g.dart';

class MemoryGameRepository = _MemoryGameRepositoryBase
    with _$MemoryGameRepository;

abstract class _MemoryGameRepositoryBase with Store {
  final MemoryGameService _memoryGameService;

  _MemoryGameRepositoryBase(this._memoryGameService);

  @observable
  ObservableList<MemoryGame> memoryGames = ObservableList();

  @action
  Future getAll() async {
    final Response response = await _memoryGameService.getAll();
    final memoryGamesList = List<MemoryGame>.from(
        response.data.map((dream) => MemoryGame.fromJson(dream)));
    memoryGames.clear();
    memoryGames.addAll(memoryGamesList);
  }

  @action
  Future fetchSecretMemoryGame(String memoryGameId) async {
    final Response memoryGamesResponse =
        await _memoryGameService.getSecret(memoryGameId);

    return MemoryGame.fromJson(memoryGamesResponse.data[0]);
  }

  @action
  Future createMemoryGameAnswer(String memoryGameId) async {
    return await _memoryGameService.createMemoryGameAnswer(memoryGameId);
  }
}
