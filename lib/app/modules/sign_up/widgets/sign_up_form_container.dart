import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/sign_up/sign_up_controller.dart';
import 'package:museu_vivo/app/shared/loading/loading_controller.dart';
import 'package:museu_vivo/app/shared/widgets/custom_form_field.dart';
import 'package:museu_vivo/app/shared/widgets/custom_submit_button.dart';

class SignUpFormContainer extends StatelessWidget {
  final _loadingController = Modular.get<LoadingController>();

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
            toggleViewIcon: false,
            textEditingController: nameController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "E-mail",
            permissionToObscure: false,
            toggleViewIcon: false,
            textEditingController: emailController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Instituição",
            permissionToObscure: false,
            toggleViewIcon: false,
            textEditingController: institutionController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Senha",
            permissionToObscure: true,
            toggleViewIcon: false,
            textEditingController: passwordController,
          ),
          SizedBox(height: 10),
          CustomFormField(
            label: "Confirmar Senha",
            permissionToObscure: true,
            toggleViewIcon: false,
            textEditingController: confirmPasswordController,
          ),
          SizedBox(height: 50),
          CustomSubmitButton(
            label: "CADASTRAR",
            functionSubmit: _submitRegister,
            labelColor: Color(0xFF0072D5),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  bool _validatePassword() {
    return this.passwordController.text == this.confirmPasswordController.text;
  }

  void _submitRegister() async {
    try {
      _loadingController.setLoading(true);
      if (formKey.currentState.validate() && _validatePassword()) {
        final controller = Modular.get<SignUpController>();

        String name = this.nameController.text.trim();
        String email = this.emailController.text.trim();
        String password = this.passwordController.text.trim();
        String institution = this.institutionController.text.trim();
        await controller.registerUser(name, institution, email, password);
      }
    } catch (error) {
      print("[ERROR] Erro ao efetuar cadastro: $error");
    } finally {
      _loadingController.setLoading(false);
    }
  }
}
