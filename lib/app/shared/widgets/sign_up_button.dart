import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(
        top: 160,
      ),
      onPressed: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ),
        ); */
      },
      child: Text(
        "Não possui uma conta? Cadastre-se",
        textAlign: TextAlign.center,
        style: TextStyle(
          letterSpacing: 0.5,
          fontFamily: "PTSans",
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 12,
        ),
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
