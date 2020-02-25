import 'package:flutter/material.dart';

Widget buildButton(
    String label, BuildContext context, bool isLoading, Function function) {
  return Container(
    height: 50,
    alignment: Alignment.centerLeft,
    child: SizedBox.expand(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Color(0xFF0072d5),
        child: isLoading
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
        onPressed: function,
      ),
    ),
  );
}
