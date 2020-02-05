import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';

class SignUpBloc extends BlocBase {
  final UserRepository userRepository;

  SignUpBloc(this.userRepository);

  Future<User> createUser({
    String name,
    String institution,
    String email,
    String password,
  }) async =>
      await this.userRepository.createUser(
            name: name,
            institution: institution,
            email: email,
            password: password,
          );
}
