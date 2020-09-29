import 'package:flutter/material.dart';

class ConfirmSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Seu cadastro foi realizado com sucesso! "
            "Clique no botão para entrar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
