import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final bool permissionToObscure;

  CustomFormField({
    Key key,
    @required this.label,
    @required this.permissionToObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.permissionToObscure == true
          ? TextInputType.text
          : TextInputType.emailAddress,
      obscureText: this.permissionToObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: this.label,
        contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(
        color: Colors.grey,
        fontSize: 15,
        fontFamily: "PTSans",
        fontWeight: FontWeight.w500,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "O campo não pode ser vazio";
        } else {
          if (this.label.toLowerCase() == "e-mail" &&
              !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                  .hasMatch(value)) {
            return "O e-mail não é válido";
          } else if (value.length < 5) {
            return "O campo precisa ter mais de 5 caracteres";
          }
        }
      },
    );
  }
}
