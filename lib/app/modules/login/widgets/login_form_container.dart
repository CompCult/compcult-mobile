import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/login/login_controller.dart';
import 'package:museu_vivo/app/shared/widgets/custom_form_field.dart';
import 'package:museu_vivo/app/shared/widgets/custom_submit_button.dart';

class LoginFormContainer extends StatefulWidget {
  @override
  _LoginFormContainerState createState() => _LoginFormContainerState();
}

class _LoginFormContainerState extends State<LoginFormContainer> {
  final loginController = Modular.get<LoginController>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomFormField(
            label: "E-mail",
            permissionToObscure: false,
            textEditingController: _emailController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Senha",
            permissionToObscure: true,
            textEditingController: _passwordController,
          ),
          SizedBox(height: 30),
          Observer(
            builder: (_) {
              if (loginController.showErrorMessage) {
                return Text(
                  "Login ou senha inválidos",
                  style: TextStyle(
                    fontFamily: "Product Sans",
                    fontSize: 20,
                    color: Colors.yellow,
                  ),
                );
              }
              return Container();
            },
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

  void _submitLogin() async {
    if (_formKey.currentState.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      await loginController.login(email, password);
    }
  }
}
