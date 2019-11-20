import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/services/user_service.dart';

class UserRepository extends BlocBase {
  final UserService userService;
  User _user;

  User get user => _user;

  UserRepository(this.userService);

  Future<User> createUser(
      {String name, String institution, String email, String password}) async {
    _user = User.fromJson(await userService.createUser(
      name: name,
      institution: institution,
      email: email,
      password: password,
    ));

    return _user;
  }
}
