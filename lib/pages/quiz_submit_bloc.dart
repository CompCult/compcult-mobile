import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';

class QuizSubmitBloc extends BlocBase {
  final UserRepository userRepository;

  QuizSubmitBloc(this.userRepository);

  User get user => userRepository.user;
}
