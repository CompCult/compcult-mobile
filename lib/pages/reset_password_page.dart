import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/reset-password-icon.png"),
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
                SizedBox(height: 15),
                _buildField("E-mail"),
                SizedBox(height: 20),
                _buildButton("CONFIRMAR", context),
                // SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Ainda precisa-se fazer tratamento de validação do campo.
  Widget _buildField(String label) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.mail_outline),
      ),
      style: TextStyle(
        fontSize: 13,
        fontFamily: "Poppins",
      ),
    );
  }

  Widget _buildButton(String label, BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.9),
            Theme.of(context).primaryColor,
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
