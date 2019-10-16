import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              alignment: Alignment(0.0, 1.15),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage("images/logo.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 15),
            _buildFormField("Nome", _nameController, false),
            SizedBox(height: 10),
            _buildFormField("Instituição", _institutionController, false),
            SizedBox(height: 10),
            _buildFormField("E-mail", _emailController, false),
            SizedBox(height: 10),
            _buildFormField("Senha", _passwordController, true),
            SizedBox(height: 15),
            Container(
              height: 60,
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
                  child: Text(
                    "CADASTRAR",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    try {
                      await _createUser();
                      Navigator.of(context).pushNamed(SignInPage.routeName);
                    } catch (exception) {
                      print(exception);
                    }
                  },
                ),
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
          fontSize: 13,
        ),
        border: OutlineInputBorder(),
        prefixIcon: _iconFormFiel(label),
      ),
      style: TextStyle(
        fontSize: 11,
        fontFamily: "Poppins",
      ),
      validator: (value) {
        if (value.isEmpty)
          return "O campo \"${label.toLowerCase()}\" não pode ser vazio";
      },
      obscureText: permissionToObscure,
    );
  }

  Icon _iconFormFiel(String label) {
    switch (label.toLowerCase()) {
      case "nome":
        return Icon(Icons.person);
        break;
      case "instituição":
        return Icon(Icons.school);
        break;
      case "e-mail":
        return Icon(Icons.mail_outline);
        break;
      case "senha":
        return Icon(Icons.lock_outline);
        break;
      default:
        return null;
    }
  }

  Future _createUser() async {
    await Dio()
        .post('https://museu-vivo-api.herokuapp.com/users/register', data: {
      'name': _nameController.text,
      'type': 'estudante',
      'institution': _institutionController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    });
  }
}
