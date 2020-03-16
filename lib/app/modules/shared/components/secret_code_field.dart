import 'package:flutter/material.dart';

class SecretCodeField extends StatelessWidget {
  final String label;
  final Function onSubmited;
  final _secretCodeController = TextEditingController();

  SecretCodeField({this.label, this.onSubmited});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white),
      height: 35,
      width: 280,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _secretCodeController,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black38,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Color(0xff60B3FC),
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.send,
              color: Color(0xff60B3FC),
              size: 20,
            ),
            onPressed: () => onSubmited(_secretCodeController.text),
          ),
        ),
        style: TextStyle(
          fontSize: 12,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
