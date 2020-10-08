import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/sign_up/sign_up_controller.dart';
import 'package:museu_vivo/app/shared/widgets/custom_form_field.dart';
import 'package:museu_vivo/app/shared/widgets/custom_submit_button.dart';

class SignUpFormContainer extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignUpFormContainer({
    Key key,
    @required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          CustomFormField(
            label: "Nome",
            permissionToObscure: false,
            textEditingController: nameController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "E-mail",
            permissionToObscure: false,
            textEditingController: emailController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Instituição",
            permissionToObscure: false,
            textEditingController: institutionController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Senha",
            permissionToObscure: true,
            textEditingController: passwordController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Confirmar Senha",
            permissionToObscure: true,
            textEditingController: confirmPasswordController,
          ),
          SizedBox(height: 50),
          CustomSubmitButton(
            label: "CADASTRAR",
            functionSubmit: _submitRegister,
          ),
        ],
      ),
    );
  }

  bool _validatePassword() {
    return this.passwordController.text == this.confirmPasswordController.text;
  }

  void _submitRegister() async {
    if (formKey.currentState.validate() && _validatePassword()) {
      final controller = Modular.get<SignUpController>();

      String name = this.nameController.text.trim();
      String email = this.emailController.text.trim();
      String password = this.passwordController.text.trim();
      String institution = this.institutionController.text.trim();
      await controller.registerUser(name, institution, email, password);
    }
  }
}
