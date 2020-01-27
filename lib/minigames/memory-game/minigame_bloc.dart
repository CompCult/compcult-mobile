import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/minigame.dart';
import 'package:museu_vivo/shared/repositories/minigame_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

class MinigamesBloc extends BlocBase {
  final MinigameRepository _minigameRepository;

  MinigamesBloc(this._minigameRepository);

  Observable<List<Minigame>> get missions => _minigameRepository.minigames;

  Future<Minigame> getSecretMinigame(String minigameId) async {
    try {
      return await _minigameRepository.fetchSecretMinigame(minigameId);
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
