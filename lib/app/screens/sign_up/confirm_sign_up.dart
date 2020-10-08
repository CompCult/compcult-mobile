import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/widgets/custom_submit_button.dart';

class ConfirmSignUp extends StatelessWidget {
  Future<bool> _onBackPressed() {
    return Modular.to.pushNamedAndRemoveUntil(
      "/login",
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color(0xFF2d91e7),
        body: Stack(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/confetti.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Cadastro realizado com sucesso, Lucas! Vamos nessa?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Product Sans",
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: CustomSubmitButton(
                label: "ENTRAR NO APP",
                functionSubmit: _goToHome,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToHome() {
    Modular.to.pushNamedAndRemoveUntil("/home", (_) => false);
  }
}
