import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/services/user_service.dart';

class UserRepository extends BlocBase {
  final UserService userService;

  UserRepository(this.userService);

  createUser({
    String name,
    String institution,
    String email,
    String password,
  }) =>
      userService.createUser(
        name: name,
        institution: institution,
        email: email,
        password: password,
      );
}
