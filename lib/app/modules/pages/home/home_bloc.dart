import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/app/modules/shared/repositories/item_repository.dart';
import 'package:museu_vivo/app/modules/shared/repositories/mission_repository.dart';
import 'package:museu_vivo/app/modules/shared/repositories/quiz_repository.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';

class HomeBloc extends BlocBase {
  final MissionRepository _missionRepository;
  final QuizRepository _quizRepository;
  final ItemRepository _itemRepository;

  HomeBloc(this._missionRepository, this._quizRepository, this._itemRepository);

  fetchMissions() => _missionRepository.fetchMissions();

  fetchQuizzes() => _quizRepository.fetchQuizzes();

  fetchItens() => _itemRepository.fetchItens();

  fetchItensPurchased() => _itemRepository.fetchPurchasedItens();

}
