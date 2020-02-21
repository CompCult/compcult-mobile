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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green,
              ),
              height: 20,
              width: 25,
              child: Text("."),
            ),
            SizedBox(
              width: 5,
            ),
            Text("FASE XL"),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.yellow,
              ),
              height: 20,
              width: 25,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.red,
              ),
              height: 20,
              width: 25,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.blue,
              ),
              height: 20,
              width: 25,
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
