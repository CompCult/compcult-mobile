import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';

part 'sign_up_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  final auth = Modular.get<AuthController>();
  
  @action
  Future registerUser(String name, String institution, String email, String password) async {
    await auth.registerUser(name, institution, email, password);
  }
}
