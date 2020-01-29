import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/minigames/memory-game/memory_game_repository.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';
import 'package:museu_vivo/shared/repositories/quiz_repository.dart';

class HomeBloc extends BlocBase {
  final MissionRepository _missionRepository;
  final QuizRepository _quizRepository;
  final MemoryGameRepository _minigameRepository;

  HomeBloc(this._missionRepository, this._quizRepository, this._minigameRepository);

  fetchMissions() => _missionRepository.fetchMissions();

  fetchQuizzes() => _quizRepository.fetchQuizzes();

  fetchMemoryGames() => _minigameRepository.fetchMemoryGames();
}
