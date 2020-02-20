import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'bloc/sign_in_bloc.dart';
import 'home_page.dart';
import 'reset_password_page.dart';
import 'sign_up_page.dart';
import '../config.dart';

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
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.fromLTRB(40, 60, 40, 10),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Para redimensionar a logo.
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.asset(
                        'assets/${config.assetsDirectoryName}/logo.png'),
                  ),
                  SizedBox(height: 5),
                  if (_showErrorMessage)
                    Text(
                      'Usuário ou senha incorretos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  SizedBox(height: 15),
                  _buildFormField("E-mail", _emailController, false),
                  SizedBox(height: 10),
                  _buildFormField("Senha", _passwordController, true),
                  SizedBox(height: 15),
                  _buildButton("ENTRAR", context),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(
                            fontFamily: "PTSans",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // Aqui estarah a funcao para efetuar cadastro...
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Text(
                          "Recuperar senha",
                          style: TextStyle(
                            fontFamily: "PTSans",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // Aqui estarah a funcao para recuperar senha...
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller,
      bool permissionToObscure) {
    return TextFormField(
      controller: controller,
      keyboardType: permissionToObscure == true
          ? TextInputType.text
          : TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        border: OutlineInputBorder(),
        prefixIcon: permissionToObscure == true
            ? Icon(Icons.lock_outline)
            : Icon(Icons.mail_outline),
      ),
      style: TextStyle(
        fontSize: 13,
        fontFamily: "Poppins",
      ),
      validator: (value) {
        if (value.isEmpty)
          return "O campo \"${label.toLowerCase()}\" não pode ser vazio";
      },
      obscureText: permissionToObscure,
    );
  }

  Widget _buildButton(String label, BuildContext context) {
    SignInBloc signInBloc = BlocProvider.getBloc<SignInBloc>();

    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [
            Theme.of(context).accentColor.withOpacity(0.9),
            Theme.of(context).accentColor,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: SizedBox.expand(
        child: FlatButton(
          child: _isLoading
              ? CircularProgressIndicator()
              : Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
          onPressed: () async {
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
          },
        ),
      ),
    );
  }
}
