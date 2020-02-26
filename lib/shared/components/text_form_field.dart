import 'package:flutter/material.dart';

Widget buildFormField(
    String label, TextEditingController controller, bool permissionToObscure) {
  return TextFormField(
    controller: controller,
    keyboardType: permissionToObscure == true
        ? TextInputType.text
        : TextInputType.emailAddress,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: label,
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
        fontSize: 13,
        fontFamily: "PTSans",
        fontWeight: FontWeight.w500),
    validator: (value) {
      if (value.isEmpty) {
        return "O campo \"${label.toLowerCase()}\" não pode ser vazio";
      }
    },
    obscureText: permissionToObscure,
  );
}
