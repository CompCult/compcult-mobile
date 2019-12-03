import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';

class UserBloc extends BlocBase {
  final UserRepository userRepository;

  UserBloc(this.userRepository);

  User get user => userRepository.user;

  logout() => userRepository.logout();
}
