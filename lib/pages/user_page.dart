import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/sign_in_page.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sair'),
        onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
          SignInPage.routeName,
          (_) => false,
        ),
      ),
    );
  }
}
