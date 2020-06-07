import 'package:flutter/material.dart';
import 'package:museu_vivo/app/shared/widgets/custom_form_field.dart';
import 'package:museu_vivo/config.dart';

class FormContainer extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  FormContainer({Key key, @required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          // Para redimensionar a logo
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(
              'assets/${config.assetsDirectoryName}/icon.png',
            ),
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "E-mail",
            permissionToObscure: false,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Senha",
            permissionToObscure: true,
          ),
        ],
      ),
    );
  }
}
