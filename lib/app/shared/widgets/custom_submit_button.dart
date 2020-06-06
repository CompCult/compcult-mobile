import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final String label;
  final GlobalKey<FormState> formKey;
  final Function functionSubmit;

  CustomSubmitButton({
    Key key,
    @required this.label,
    @required this.formKey,
    @required this.functionSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: SizedBox.expand(
        child: FlatButton(
          onPressed: formKey.currentState.validate() ? functionSubmit : null,
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
          color: Color(0xFF0072d5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    );
  }
}
