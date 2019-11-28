import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';

class SignInBloc extends BlocBase {
  final UserRepository userRepository;

  SignInBloc(this.userRepository);

  Future<User> authenticate(String email, String password) {
    return userRepository.authenticate(email, password);
  }
}
