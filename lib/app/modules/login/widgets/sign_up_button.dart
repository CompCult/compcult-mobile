import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Modular.to.pushNamed("/register");
      },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            letterSpacing: 0.5,
            fontFamily: "Product Sans",
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 17,
          ),
          text: "Não possui uma conta? ",
          children: [
            TextSpan(
              text: "Cadastre-se.",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
