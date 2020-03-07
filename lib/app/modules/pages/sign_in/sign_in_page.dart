import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/home/home_page.dart';
import 'package:museu_vivo/app/modules/pages/sign_up/sign_up_page.dart';
import 'package:museu_vivo/app/modules/shared/components/button_submit_form.dart';
import 'package:museu_vivo/app/modules/shared/components/text_form_field.dart';
import 'package:museu_vivo/config.dart';

import 'sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/sign-in';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showErrorMessage = false;
  bool _isLoading = false;

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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Para redimensionar a logo
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                          'assets/${config.assetsDirectoryName}/icon.png'),
                    ),
                    SizedBox(height: 10),
                    if (_showErrorMessage)
                      Text(
                        'Usuário ou senha incorretos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    SizedBox(height: 10),
                    buildFormField("E-mail", _emailController, false),
                    SizedBox(height: 10),
                    buildFormField("Senha", _passwordController, true),
                    SizedBox(height: 30),
                    buildButton("ENTRAR", context, _isLoading, _submitLogin),
                    SizedBox(height: 15),
                    GestureDetector(
                      child: Text(
                        "Cadastre-se",
                        style: TextStyle(
                          fontFamily: "PTSans",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submitLogin() async {
    SignInBloc signInBloc = BlocProvider.getBloc<SignInBloc>();

    // Esconde o teclado caso esteja aberto ao clicar no botão
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        await signInBloc.authenticate(
            _emailController.text, _passwordController.text);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.routeName, (_) => false);
      } catch (exception) {
        setState(() {
          _showErrorMessage = true;
          _isLoading = false;
        });
      }
    }
  }
}
