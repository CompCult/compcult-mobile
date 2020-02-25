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
        borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.white    
      ),
      height: 45,
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
           borderRadius: BorderRadius.all(Radius.circular(40))
          ),
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () => onSubmited(_secretCodeController.text),
          ),
        ),
        style: TextStyle(
          fontSize: 13,
          fontFamily: "Poppins",
        ),
        
      ),
    );
  }
}
