import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/minigames/memory-game/memory.dart';
import 'package:museu_vivo/minigames/memory-game/memory_game_service.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class MemoryGameRepository extends BlocBase {
  final MemoryGameService _memoryGameService;
  final UserRepository userRepository;

  BehaviorSubject<List<MemoryGame>> _memoryGamesController =
      BehaviorSubject<List<MemoryGame>>();

  MemoryGameRepository(this._memoryGameService, this.userRepository);

  Observable<List<MemoryGame>> get memorygames => _memoryGamesController.stream;

  fetchMemoryGames() {
    userRepository.user.listen((user) async {
      final Response memoryGamesResponse =
          await _memoryGameService.fetchMemoryGames(user.id);

      _memoryGamesController.sink.add(List<MemoryGame>.from(
        memoryGamesResponse.data.map((memoryGame) => MemoryGame.fromJson(memoryGame)),
      ));
    });
  }

  Future<MemoryGame> fetchSecretMemoryGame(String memoryGameId) async {
    final Response memoryGamesResponse =
        await _memoryGameService.fetchSecretMemoryGame(memoryGameId);

    return MemoryGame.fromJson(memoryGamesResponse.data[0]);
  }

  Future createMemoryGameAnswer(
      String memoryGameId, Map<String, dynamic> data) async {
    userRepository.user.listen((user) async {
      return await _memoryGameService.createMemoryGameAnswer(memoryGameId, data);
    });
  }

  @override
  void dispose() {
    _memoryGamesController.close();
    super.dispose();
  }
}
