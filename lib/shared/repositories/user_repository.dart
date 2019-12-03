import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/services/user_service.dart';

class UserRepository extends BlocBase {
  final UserService userService;
  User _user;
  Box _userBox;

  User get user => _user;

  UserRepository(this.userService, this._user, this._userBox);

  Future<User> createUser(
      {String name, String institution, String email, String password}) async {
    _user = User.fromJson(await userService.createUser(
      name: name,
      institution: institution,
      email: email,
      password: password,
    ));
    _userBox.put(0, _user.toJson());

    return _user;
  }

  Future<User> authenticate(String email, String password) async {
    Response response = await userService.authenticate(email, password);
    _user = User.fromJson(response.data);
    _userBox.put(0, _user.toJson());

    return _user;
  }

  logout() => _userBox.delete(0);
}
