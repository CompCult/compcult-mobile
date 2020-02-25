import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Loja")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: Color(0xff00036c).withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 90,
                    width: 90,
                    child: Center(
                      child: Text(
                        "Loja não habilitada",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, ),
                      ),
                    ))
              ],
            ),
          ],
        ));
  }
}
