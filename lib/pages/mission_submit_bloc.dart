import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';

class MissionSubmitBloc extends BlocBase {
  final UserRepository userRepository;

  MissionSubmitBloc(this.userRepository);

  User get user => userRepository.user;
}
