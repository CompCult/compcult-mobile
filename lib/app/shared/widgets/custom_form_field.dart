import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final bool permissionToObscure;
  final bool toggleViewIcon;
  final TextEditingController textEditingController;

  CustomFormField({
    Key key,
    @required this.label,
    @required this.permissionToObscure,
    @required this.toggleViewIcon,
    @required this.textEditingController,
  });

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @observable
  bool fieldVisibility = false;

  @action
  void changeFieldVisibility(bool value) {
    fieldVisibility = value;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => TextFormField(
        controller: widget.textEditingController,
        // Verifica se o campo está habilitado para ser oculto.
        // Caso positivo, deixa o controle de visibilidade com o _loginController,
        // visto que, no caso do input de senha, é possível alterar a visilibidade.
        obscureText: widget.permissionToObscure,
        keyboardType: this.widget.permissionToObscure
            ? TextInputType.text
            : TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: this.widget.label,
          labelStyle: TextStyle(
            fontFamily: "Product Sans",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: this.widget.toggleViewIcon
              ? IconButton(
                  onPressed: () {
                    changeFieldVisibility(!fieldVisibility);
                  },
                  icon: Observer(
                    builder: (_) => Icon(
                      !fieldVisibility ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Product Sans",
          fontWeight: FontWeight.w500,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "O campo não pode ser vazio";
          } else {
            if (this.widget.label.toLowerCase() == "e-mail" &&
                !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                    .hasMatch(value)) {
              return "O e-mail não é válido";
            } else if (value.length < 5) {
              return "O campo precisa ter mais de 5 caracteres";
            }
          }
        },
      ),
    );
  }
}
