import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_repository_interface.dart';
import 'package:museu_vivo/app/shared/models/user_model.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository _authRepository = Modular.get();

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  UserModel user;

  _AuthControllerBase() {
    _authRepository.getUser().then((setUser)).catchError((error) {
      print(
          "[ERROR] Erro ao executar o método authRepository.getUser(): $error");
    });
  }

  @action
  setUser(UserModel newUser) {
    user = newUser;
    status = user == null ? AuthStatus.logoff : AuthStatus.login;
  }

  @action
  Future authenticate(String email, String password) async {
    user = await _authRepository.login(email, password);
  }

  @action
  Future registerUser(
      String name, String institution, String email, String password) async {
    user =
        await _authRepository.registerUser(name, institution, email, password);
  }

  logout() async {
    await _authRepository.logout();
  }
}

enum AuthStatus { loading, login, logoff }
