import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/widgets/custom_submit_button.dart';
import 'package:museu_vivo/app/shared/widgets/form_container.dart';
import 'package:museu_vivo/app/shared/widgets/sign_up_button.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Esconde o teclado caso esteja aberto ao clicar na tela
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          color: Color(0xFF2d91e7),
          child: ListView(
            padding: EdgeInsets.fromLTRB(40, 50, 40, 10),
            children: <Widget>[
              SizedBox(height: 30),
              FormContainer(formKey: _formKey),
              SizedBox(height: 30),
              CustomSubmitButton(
                formKey: _formKey,
                label: "ENTRAR",
                functionSubmit: controller.login,
              ),
              SizedBox(height: 20),
              SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
