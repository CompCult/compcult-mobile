import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';

part 'sign_up_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  final auth = Modular.get<AuthController>();
  
  @action
  Future registerUser(String name, String institution, String email, String password) async {
    try {
      await auth.registerUser(name, institution, email, password);
      Modular.to.pushNamedAndRemoveUntil("/register/success", (_) => false);
    } catch(error) {
      print("[ERROR] Erro ao tentar regitrar usuário: $error");
    }
  }
}
