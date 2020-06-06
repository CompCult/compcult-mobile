import 'dart:ui';

import 'package:flutter/material.dart';

/*
Para executar o dialog:
void _showCustomDialog() {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop(true);
      });
      return ErrorDialog(
        errorMessage:
            "Esse método necessita do preenchimento do email e senha.",
      );
    },
  );
}
*/
class ErrorDialog extends StatelessWidget {
  final String errorMessage;

  ErrorDialog({@required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: AlertDialog(
        elevation: 5.0,
        backgroundColor: Color(0xFFDC4E42),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                height: 45,
                width: 45,
                child: Image.asset("assets/images/alert.png"),
              ),
            ),
            SizedBox(width: 20.0),
            Flexible(
              flex: 4,
              child: Text(
                errorMessage,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Avenir Heavy",
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
