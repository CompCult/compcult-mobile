import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/app/modules/shared/models/quiz.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';
import 'package:museu_vivo/app/modules/shared/services/quiz_service.dart';

import 'package:rxdart/rxdart.dart';

class QuizRepository extends BlocBase {
  final QuizService _quizService;
  final UserRepository userRepository;

  BehaviorSubject<List<Quiz>> _quizController = BehaviorSubject<List<Quiz>>();

  Observable<List<Quiz>> get quizzes => _quizController.stream;

  QuizRepository(this._quizService, this.userRepository);

  fetchQuizzes() {
    userRepository.user.listen((user) async {
      final Response quizzesReponse = await _quizService.fetchQuizzes(user.id);

      _quizController.sink.add(List<Quiz>.from(
        quizzesReponse.data.map((quiz) => Quiz.fromJson(quiz)),
      ));
    });
  }

  Future<Quiz> fetchSecretQuiz(String quizId) async {
    final Response quizzesReponse = await _quizService.fetchSecretQuiz(quizId);

    return Quiz.fromJson(quizzesReponse.data[0]);
  }

  Future createQuizAnswer(String quizId, String answer) {
    userRepository.updateUserAsync();
    return _quizService.createQuizAnswer(quizId, answer);
  }

  @override
  void dispose() {
    _quizController.close();
    super.dispose();
  }
}
