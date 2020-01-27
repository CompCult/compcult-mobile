import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/shared/models/minigame.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:museu_vivo/shared/services/minigame_service.dart';
import 'package:rxdart/rxdart.dart';

class MinigameRepository extends BlocBase {
  final MinigameService _minigameService;
  final UserRepository userRepository;

  BehaviorSubject<List<Minigame>> _minigamesController =
      BehaviorSubject<List<Minigame>>();

  MinigameRepository(this._minigameService, this.userRepository);

  Observable<List<Minigame>> get minigames => _minigamesController.stream;

  fetchMinigames() {
    userRepository.user.listen((user) async {
      final Response minigamesResponse =
          await _minigameService.fetchMinigames(user.id);

      _minigamesController.sink.add(List<Minigame>.from(
        minigamesResponse.data.map((minigame) => Minigame.fromJson(minigame)),
      ));
    });
  }

  Future<Minigame> fetchSecretMinigame(String minigameId) async {
    final Response minigamesResponse =
        await _minigameService.fetchSecretMinigame(minigameId);

    return Minigame.fromJson(minigamesResponse.data[0]);
  }

  Future createMinigameAnswer(
      String minigameId, Map<String, dynamic> data) async {
    userRepository.user.listen((user) async {
      return await _minigameService.createMinigameAnswer(minigameId, data);
    });
  }

  @override
  void dispose() {
    _minigamesController.close();
    super.dispose();
  }
}
