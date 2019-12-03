import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/shared/models/quiz.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:museu_vivo/shared/services/quiz_service.dart';
import 'package:rxdart/rxdart.dart';

class QuizRepository extends BlocBase {
  final QuizService quizService;
  final UserRepository userRepository;

  BehaviorSubject<List<Quiz>> _quizController = BehaviorSubject<List<Quiz>>();

  Observable<List<Quiz>> get quizzes => _quizController.stream;

  QuizRepository(this.quizService, this.userRepository);

  fetchQuizzes() async {
    final Response quizzesReponse =
        await quizService.fetchQuizzes(userRepository.user.id);

    _quizController.sink.add(List<Quiz>.from(
      quizzesReponse.data.map((quiz) => Quiz.fromJson(quiz)),
    ));
  }

  Future<Quiz> fetchSecretQuiz(String quizId) async {
    final Response quizzesReponse = await quizService.fetchSecretQuiz(quizId);

    return Quiz.fromJson(quizzesReponse.data);
  }

  @override
  void dispose() {
    _quizController.close();
    super.dispose();
  }
}
