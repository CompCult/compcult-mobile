import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("images/reset-password-icon.png"),
              ),
              SizedBox(height: 20),
              Text(
                "Esqueceu sua senha?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Por favor, informe o e-mail associado a sua conta que "
                "enviaremos um link para o mesmo com as instruções "
                "para a restauração de sua senha.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildButton("CONFIRMAR"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label) {
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
          child: Text(
            label,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          // Aqui estarah a funcao para efetuar login. Por enquanto, está só uma validação de campos.
          onPressed: () {},
        ),
      ),
    );
  }
}
