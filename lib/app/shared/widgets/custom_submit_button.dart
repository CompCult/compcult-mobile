import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/login/login_controller.dart';

class CustomSubmitButton extends StatelessWidget {
  final String label;
  final Function functionSubmit;

  CustomSubmitButton({
    Key key,
    @required this.label,
    @required this.functionSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Modular.get<LoginController>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.35),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      alignment: Alignment.centerLeft,
      child: SizedBox.expand(
        child: Observer(
          builder: (_) {
            return FlatButton(
              onPressed: functionSubmit,
              child: loginController.loading
                  ? CircularProgressIndicator()
                  : Text(
                      label,
                      style: TextStyle(
                        fontFamily: "Product Sanrs",
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0072D5),
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
