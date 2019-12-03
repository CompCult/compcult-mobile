import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/quiz.dart';
import 'package:museu_vivo/shared/repositories/quiz_repository.dart';
import 'package:rxdart/rxdart.dart';

class QuizzesBloc extends BlocBase {
  final QuizRepository quizRepository;

  QuizzesBloc(this.quizRepository);

  Observable<List<Quiz>> get quizzes => quizRepository.quizzes;
}
