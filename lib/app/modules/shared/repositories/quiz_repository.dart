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
      List<Quiz> quizzes = List<Quiz>.from(
        quizzesReponse.data.map((quiz) {
          quiz['answered'] = quiz['users'].contains(user.id);

          return Quiz.fromJson(quiz);
        }),
      );

      _quizController.sink.add(quizzes.reversed.toList());
    });
  }

  Future<Quiz> fetchSecretQuiz(String quizId) async {
    final Response quizzesReponse = await _quizService.fetchSecretQuiz(quizId);

    return Quiz.fromJson(quizzesReponse.data[0]);
  }

  Future createQuizAnswer(String quizId, String answer) async {
    userRepository.updateUserAsync();

    var response = await _quizService.createQuizAnswer(quizId, answer);

    List<Quiz> quizes = _quizController.value.map((q) {
      if (q.id == quizId) q.answered = true;
      return q;
    }).toList();

    _quizController.sink.add(quizes);

    return response;
  }

  @override
  void dispose() {
    _quizController.close();
    super.dispose();
  }
}
