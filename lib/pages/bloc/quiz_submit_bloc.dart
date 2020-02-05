import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/repositories/quiz_repository.dart';

class QuizSubmitBloc extends BlocBase {
  final QuizRepository _quizRepository;

  QuizSubmitBloc(this._quizRepository);

  Future createQuizAnswer(quizId, answer) =>
      _quizRepository.createQuizAnswer(quizId, answer);
}
