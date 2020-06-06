import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthController auth = Modular.get();

  @observable
  bool loading = false;

  @action
  Future login(String email, String password) async {
    try {
      loading = true;
      await auth.authenticate(email, password);
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      loading = false;
    }
  }
}
