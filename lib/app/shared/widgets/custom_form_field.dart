import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/login/login_controller.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final bool permissionToObscure;

  CustomFormField({
    Key key,
    @required this.label,
    @required this.permissionToObscure,
  });

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  // Injeção de dependência
  final controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return TextFormField(
          keyboardType: widget.permissionToObscure == true
              ? TextInputType.text
              : TextInputType.emailAddress,
          obscureText: widget.permissionToObscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.label,
            contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontFamily: "PTSans",
            fontWeight: FontWeight.w500,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "O campo não pode ser vazio";
            } else {
              if (widget.label.toLowerCase() == "e-mail" &&
                  !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                      .hasMatch(value)) {
                return "O e-mail não é válido";
              } else if (value.length < 5) {
                return "O campo precisa ter mais de 5 caracteres";
              }
            }
          },
        );
      },
    );
  }
}
