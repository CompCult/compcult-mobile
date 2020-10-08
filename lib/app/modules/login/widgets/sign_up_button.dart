import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ),
        ); */
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

/* 
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
*/
