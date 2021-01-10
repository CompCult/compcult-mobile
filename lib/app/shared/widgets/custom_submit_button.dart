import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/loading/loading_controller.dart';

class CustomSubmitButton extends StatelessWidget {
  final String label;
  final Function functionSubmit;
  final Color labelColor;
  final Color backgroundColor;

  CustomSubmitButton({
    Key key,
    @required this.label,
    @required this.functionSubmit,
    @required this.labelColor,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final loadingController = Modular.get<LoadingController>();

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
              child: loadingController.loading
                  ? CircularProgressIndicator()
                  : Text(
                      label,
                      style: TextStyle(
                        fontFamily: "Product Sanrs",
                        fontWeight: FontWeight.w700,
                        color: this.labelColor,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
              color: this.backgroundColor,
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
