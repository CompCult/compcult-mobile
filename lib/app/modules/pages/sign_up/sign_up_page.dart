import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/home/home_page.dart';
import 'package:museu_vivo/app/modules/shared/components/button_submit_form.dart';
import 'package:museu_vivo/app/modules/shared/components/text_form_field.dart';
import 'package:museu_vivo/config.dart';

import 'sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                          'assets/${config.assetsDirectoryName}/icon.png'),
                    ),
                    SizedBox(height: 20),
                    buildFormField("Nome", _nameController, false),
                    SizedBox(height: 10),
                    buildFormField(
                        "Instituição", _institutionController, false),
                    SizedBox(height: 10),
                    buildFormField("E-mail", _emailController, false),
                    SizedBox(height: 10),
                    buildFormField("Senha", _passwordController, true),
                    SizedBox(height: 20),
                    buildButton("CADASTRAR", context, false, _submitRegister),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submitRegister() async {
    SignUpBloc signUpBloc = BlocProvider.getBloc<SignUpBloc>();

    // Esconde o teclado caso esteja aberto ao clicar no botão
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (_formKey.currentState.validate()) {
      try {
        await signUpBloc.createUser(
          name: _nameController.text,
          institution: _institutionController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.of(context).pushNamed(HomePage.routeName);
      } catch (exception) {
        print(exception);
      }
    }
  }
}
