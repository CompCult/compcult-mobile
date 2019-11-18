import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';

class SignUpBloc extends BlocBase {
  final UserRepository userRepository;

  SignUpBloc(this.userRepository);

  createUser({
    String name,
    String institution,
    String email,
    String password,
  }) =>
      this.userRepository.createUser(
            name: name,
            institution: institution,
            email: email,
            password: password,
          );
}
