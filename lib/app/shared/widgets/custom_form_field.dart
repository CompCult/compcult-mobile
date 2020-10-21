import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final bool permissionToObscure;
  final TextEditingController textEditingController;

  CustomFormField({
    Key key,
    @required this.label,
    @required this.permissionToObscure,
    @required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: this.permissionToObscure,
      keyboardType: this.permissionToObscure == true
          ? TextInputType.text
          : TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: Colors.white,
        labelText: this.label,
        labelStyle: TextStyle(
          fontFamily: "Product Sans",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        suffixIcon: this.permissionToObscure
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.visibility,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: "Product Sans",
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
