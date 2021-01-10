import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';
import 'package:museu_vivo/app/shared/models/user_model.dart';

part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  final _authController = Modular.get<AuthController>();

  UserModel user;

  _ProfileControllerBase() {
    getUser();
  }

  void logout() async {
    await _authController.logout();
    Modular.to.pushNamedAndRemoveUntil("/login", (_) => false);
  }

  void getUser() {
    user = _authController.user;
  }
}
