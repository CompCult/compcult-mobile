import 'package:flutter/material.dart';

class SecretCodeField extends StatelessWidget {
  final String label;
  final Function onSubmited;
  final _secretCodeController = TextEditingController();

  SecretCodeField({this.label, this.onSubmited});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:15.0, left: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white),
        height: 40,
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: _secretCodeController,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black38,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 14,
  
            ),
          
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: Color(0xff60B3FC),
              size: 16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                color: Color(0xff60B3FC),
                size: 16,
              ),
              onPressed: () => onSubmited(_secretCodeController.text),
            ),
          ),
          style: TextStyle(
            fontSize: 12,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
