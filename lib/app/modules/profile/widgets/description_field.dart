import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  final String description;

  const DescriptionField({@required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.description,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontFamily: "Product Sans",
      ),
    );
  }
}
