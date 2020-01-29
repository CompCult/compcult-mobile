import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';
import 'package:museu_vivo/shared/repositories/quiz_repository.dart';

class HomeBloc extends BlocBase {
  final MissionRepository _missionRepository;
  final QuizRepository _quizRepository;

  HomeBloc(this._missionRepository, this._quizRepository);

  fetchMissions() => _missionRepository.fetchMissions();

  fetchQuizzes() => _quizRepository.fetchQuizzes();
}
