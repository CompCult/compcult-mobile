import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Vivo Museu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        buttonTheme: ButtonThemeData(minWidth: 10),
        textTheme: TextTheme(
          button: TextStyle(fontSize: 10),
        ),
      ),
      home: LoginPage(),
    );
  }
}
