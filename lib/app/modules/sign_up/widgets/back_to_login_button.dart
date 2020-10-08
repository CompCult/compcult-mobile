import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BackToLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Modular.to.pushNamed("/login");
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
          text: "Já possui uma conta? ",
          children: [
            TextSpan(
              text: "Faça o login.",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
