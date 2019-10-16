import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';
import 'reset_password_page.dart';
import 'sign_up_page.dart';
import '../shared/providers/user_provider.dart';

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
                    child: Image.asset("images/logo.png"),
                  ),
                  SizedBox(height: 5),
                  if (_showErrorMessage)
                    Text(
                      'Usuário ou senha incorretos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
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
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [
            Color(0xFFf44336),
            Color(0XFFc62828),
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
                final int userId = await _auth();
                userProvider.updateUserId(userId);
                Navigator.of(context).pushNamed(MainPage.routeName);
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

  Future<int> _auth() async {
    setState(() {
      _isLoading = true;
    });

    final Response response = await Dio()
        .post('https://museu-vivo-api.herokuapp.com/users/auth', data: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    return response.data['_id'];
  }
}