import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/login/widgets/login_form_container.dart';
import 'package:museu_vivo/app/modules/login/widgets/logo_container.dart';
import 'package:museu_vivo/app/modules/login/widgets/sign_up_button.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Esconde o teclado caso esteja aberto ao clicar na tela
          // FocusManager.instance.primaryFocus.unfocus();
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          color: Color(0xFF2d91e7),
          child: Column(
            children: [
              SizedBox(height: 80),
              LogoContainer(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
                  children: <Widget>[
                    LoginFormContainer(),
                    SizedBox(height: 20),
                    SignUpButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
