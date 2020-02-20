import 'package:flutter/material.dart';

class AppBarCustom extends StatefulWidget {
  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              color: Colors.green,
              child: Text("."),
            ),
            SizedBox(
              width: 5,
            ),
            Text("120"),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              color: Colors.yellow,
              child: Text("."),
            ),
            SizedBox(
              width: 5,
            ),
            Text("350"),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              color: Colors.red,
              child: Text("."),
            ),
            SizedBox(
              width: 5,
            ),
            Text("40"),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              color: Colors.blue,
              child: Text("."),
            ),
            SizedBox(
              width: 5,
            ),
            Text("10"),
          ],
        ),
      ],
    );
  }
}
