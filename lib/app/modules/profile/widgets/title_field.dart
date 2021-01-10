import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final String title;

  const TitleField({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Product Sans",
        color: Colors.black,
      ),
    );
  }
}
