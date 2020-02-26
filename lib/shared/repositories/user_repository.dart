import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/dio_repository.dart';
import 'package:museu_vivo/shared/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class UserRepository extends BlocBase {
  final UserService _userService;
  User _user;
  Box _userBox;
  BehaviorSubject<User> _userController = BehaviorSubject<User>();
  DioRepository _dioRepository;

  Observable<User> get user => _userController.stream;

  UserRepository(this._userService, _user, this._userBox, this._dioRepository) {
    user.listen((user) {
      _dioRepository.addToken(user.token);
      _userBox.put(0, user.toJson());
    });

    _userController.sink.add(_user);
  }

  updateUser() {
    user.asyncMap((user) async {
      final response = await _userService.fetchUser(user.id);
      _userController.sink.add(User.fromJson(response.data));
    });
  }

  Future<List<User>> fetchUsers() async {
    final Response usersResponse = await _userService.fetchUsers();
    final List<User> users =
        List<User>.from(usersResponse.data.map((user) => User.fromJson(user)));
    users.sort((a, b) => b.lux - a.lux);

    return users;
  }

  Future<User> createUser(
      {String name, String institution, String email, String password}) async {
    _userController.sink.add(User.fromJson(await _userService.createUser(
      name: name,
      institution: institution,
      email: email,
      password: password,
    )));

    return _user;
  }

  Future authenticate(String email, String password) async {
    Response response = await _userService.authenticate(email, password);
    final User user = User.fromJson(response.data);
    _userController.sink.add(user);
  }

  logout() => _userBox.delete(0);

  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }
}
