import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';

class SignInBloc extends BlocBase {
  final UserRepository userRepository;

  SignInBloc(this.userRepository);

  Future authenticate(String email, String password) =>
      userRepository.authenticate(email, password);
}
