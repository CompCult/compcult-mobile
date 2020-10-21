import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/login/widgets/logo_container.dart';
import 'package:museu_vivo/app/modules/sign_up/widgets/back_to_login_button.dart';
import 'package:museu_vivo/app/modules/sign_up/widgets/sign_up_form_container.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key key, this.title = "SignUp"}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController> {
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
          child: Column(
            children: [
              SizedBox(height: 80),
              LogoContainer(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
                  children: <Widget>[
                    SignUpFormContainer(formKey: _formKey),
                    SizedBox(height: 20),
                    BackToLoginButton(),
                    SizedBox(height: 30),
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
