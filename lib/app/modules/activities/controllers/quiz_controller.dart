import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/models/quiz_model.dart';
import 'package:museu_vivo/app/shared/services/quiz_service.dart';

part 'quiz_controller.g.dart';

@Injectable()
class QuizController = _QuizControllerBase with _$QuizController;

abstract class _QuizControllerBase with Store {
  final _quizService = Modular.get<QuizService>();

  @observable
  List<QuizModel> quizzes = [];

  @action
  Future<void> fetchQuizzes() async {
    Response quizzesResponse = await _quizService.fetchQuizzes();
    print(quizzesResponse);
  }
}
