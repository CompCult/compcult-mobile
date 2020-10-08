import 'package:museu_vivo/app/modules/sign_up/sign_up_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/sign_up/sign_up_page.dart';
import 'package:museu_vivo/app/screens/sign_up/confirm_sign_up.dart';

class SignUpModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SignUpController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SignUpPage()),
        ModularRouter("/success", child: (_, args) => ConfirmSignUp()),
      ];

  static Inject get to => Inject<SignUpModule>.of();
}