import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/minigames/memory-game/models/memory_game.dart';
import 'package:museu_vivo/minigames/memory-game/services/memory_game_service.dart';

import '../../../shared/repositories/user_repository.dart';
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
  Future createMemoryGameAnswer(
      String memoryGameId) async {
          return await _memoryGameService.createMemoryGameAnswer(memoryGameId);
  }

}

// class MemoryGameRepository extends BlocBase {
//   final MemoryGameService _memoryGameService;
//   final UserRepository userRepository;

//   BehaviorSubject<List<MemoryGame>> _memoryGamesController =
//       BehaviorSubject<List<MemoryGame>>();

//   MemoryGameRepository(this._memoryGameService, this.userRepository);

//   Observable<List<MemoryGame>> get memorygames => _memoryGamesController.stream;

//   fetchMemoryGames() {
//     userRepository.user.listen((user) async {
//       final Response memoryGamesResponse =
//           await _memoryGameService.fetchMemoryGames(user.id);

//       _memoryGamesController.sink.add(List<MemoryGame>.from(
//         memoryGamesResponse.data.map((memoryGame) => MemoryGame.fromJson(memoryGame)),
//       ));
//     });
//   }

//   Future<MemoryGame> fetchSecretMemoryGame(String memoryGameId) async {
//     final Response memoryGamesResponse =
//         await _memoryGameService.fetchSecretMemoryGame(memoryGameId);

//     return MemoryGame.fromJson(memoryGamesResponse.data[0]);
//   }

//   Future createMemoryGameAnswer(
//       String memoryGameId, Map<String, dynamic> data) async {
//     userRepository.user.listen((user) async {
//       return await _memoryGameService.createMemoryGameAnswer(memoryGameId, data);
//     });
//   }

//   @override
//   void dispose() {
//     _memoryGamesController.close();
//     super.dispose();
//   }
// }
