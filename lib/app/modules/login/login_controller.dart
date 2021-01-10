import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';
import 'package:museu_vivo/app/shared/loading/loading_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final _authController = Modular.get<AuthController>();
  final _loadingController = Modular.get<LoadingController>();

  @observable
  bool loading = false;

  @observable
  bool showErrorMessage = false;

  @action
  Future login(String email, String password) async {
    try {
      _loadingController.setLoading(true);
      showErrorMessage = false;
      await _authController.authenticate(email, password);
      Modular.to.pushNamedAndRemoveUntil('/initial', (_) => false);
    } catch (error) {
      showErrorMessage = true;
      print("[ERROR] Erro ao efetuar login: $error");
    } finally {
      _loadingController.setLoading(false);
    }
  }
}
