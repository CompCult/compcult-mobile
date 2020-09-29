import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/login/login_controller.dart';
import 'package:museu_vivo/app/shared/widgets/custom_form_field.dart';
import 'package:museu_vivo/app/shared/widgets/custom_submit_button.dart';
import 'package:museu_vivo/config.dart';

class LoginFormContainer extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginFormContainer({
    Key key,
    @required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          // Para redimensionar a logo
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(
              'assets/${config.assetsDirectoryName}/icon.png',
            ),
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "E-mail",
            permissionToObscure: false,
            textEditingController: emailController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Senha",
            permissionToObscure: true,
            textEditingController: passwordController,
          ),
          SizedBox(height: 30),
          CustomSubmitButton(
            label: "ENTRAR",
            functionSubmit: _submitLogin,
          ),
        ],
      ),
    );
  }

  _submitLogin() {
    if (formKey.currentState.validate()) {
      final controller = Modular.get<LoginController>();

      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      return controller.login(email, password);
    }
  }
}
