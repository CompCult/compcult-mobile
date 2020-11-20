import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final auth = Modular.get<AuthController>();

  @observable
  bool loading = false;

  @observable
  bool showErrorMessage = false;

  @observable
  bool visibilityInputText = false;

  @action
  void setVisibilityInputText(bool newValue) => visibilityInputText = newValue;

  @action
  Future login(String email, String password) async {
    try {
      loading = true;
      showErrorMessage = false;
      await auth.authenticate(email, password);
      Modular.to.pushNamedAndRemoveUntil('/initial', (_) => false);
    } catch (error) {
      loading = false;
      showErrorMessage = true;
      print("[ERROR] Erro ao efetuar login: $error");
    } finally {
      loading = false;
    }
  }
}
