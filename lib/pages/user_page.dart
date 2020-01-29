import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/sign_in_page.dart';
import 'package:museu_vivo/pages/user_bloc.dart';
import 'package:museu_vivo/shared/models/user.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // final _nameController = TextEditingController();
  // final _institutionController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.getBloc<UserBloc>();
    // _nameController.text = userBloc.user.name;
    // _emailController.text = userBloc.user.email;

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<User>(
            stream: bloc.user,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return Text(
                'Olá, ${snapshot.data.name}!',
                style: TextStyle(fontFamily: "Poppins", fontSize: 18),
              );
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logout(bloc),
          ),
        ],
      ),
      body: StreamBuilder<User>(
          stream: bloc.user,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // padding: EdgeInsets.only(top: 30, left: 40, right: 40),
                children: <Widget>[
                  _profilePicture(),
                  SizedBox(height: 30),
                  Text(snapshot.data.name),
                  // _buildFormField("Nome", _nameController, false),
                  SizedBox(height: 10),
                  Text(snapshot.data.email),
                  // _buildFormField("E-mail", _emailController, false),
                  SizedBox(height: 10),
                  // _buildFormField("Senha", _passwordController, true),
                  SizedBox(height: 15),
                  // _buildButton(userBloc.user.id),
                ],
              ),
            );
          }),
    );
  }

  Widget _profilePicture() {
    return GestureDetector(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/logo-profile.png"),
          ),
        ),
      ),
      onTap: _getImage,
    );
  }

  // Capturar a imagem e substituir no BD
  Future _getImage() async {}

  Widget _buildFormField(String label, TextEditingController controller,
      bool permissionToObscure) {
    return TextFormField(
      controller: controller,
      keyboardType: permissionToObscure == true
          ? TextInputType.text
          : TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        border: OutlineInputBorder(),
        prefixIcon: _iconFormFiel(label),
      ),
      style: TextStyle(
        fontSize: 13,
        fontFamily: "Poppins",
      ),
      validator: (value) {
        if (value.isEmpty)
          return "O campo \"${label.toLowerCase()}\" não pode ser vazio";
      },
      obscureText: permissionToObscure,
    );
  }

  Widget _buildButton(int userId) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: SizedBox.expand(
        child: FlatButton(
          onPressed: () {},
          child: Text(
            "ATUALIZAR DADOS",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: "Poppins",
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          // onPressed: () => _updateUserData(userId),
        ),
      ),
    );
  }

  // _updateUserData(int userId) {
  //   final Dio dio = Provider.of<Dio>(context);
  //   dio.put('/users/${userId}', data: {
  //     if (_nameController.text.isNotEmpty) 'name': _nameController.text,
  //     if (_institutionController.text.isNotEmpty)
  //       'institution': _institutionController.text,
  //     if (_emailController.text.isNotEmpty) 'email': _emailController.text,
  //     if (_passwordController.text.isNotEmpty)
  //       'password': _passwordController.text,
  //   });
  // }

  Icon _iconFormFiel(String label) {
    switch (label.toLowerCase()) {
      case "nome":
        return Icon(Icons.person);
        break;
      case "instituição":
        return Icon(Icons.school);
        break;
      case "e-mail":
        return Icon(Icons.mail_outline);
        break;
      case "senha":
        return Icon(Icons.lock_outline);
        break;
      default:
        return null;
    }
  }

  // Future<bool> _requestPop() {
  //   // Se o campo de nome for mudado (só por exemplo)...
  //   if (_nameController.value != null) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           // Diálogo que aparece no centro da tela
  //           return AlertDialog(
  //             title: Text("Descartar alterações?"),
  //             content: Text(
  //               "Se você sair, as suas modificações serão perdidas.",
  //               textAlign: TextAlign.justify,
  //               style: TextStyle(
  //                 fontFamily: "SourceSansPro",
  //                 fontSize: 15,
  //               ),
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text(
  //                   "Sim",
  //                   style: TextStyle(
  //                     fontFamily: "SourceSansPro",
  //                     fontSize: 17,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context); // Remove o diálogo
  //                   // Remove o diálogo e vai para HomePage()
  //                   Navigator.of(context).pushAndRemoveUntil(
  //                       MaterialPageRoute(builder: (context) => HomePage()),
  //                       (_) => false);
  //                 },
  //               ),
  //               FlatButton(
  //                 child: Text(
  //                   "Cancelar",
  //                   style: TextStyle(
  //                     fontFamily: "SourceSansPro",
  //                     fontSize: 17,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context); // Remove o diálogo
  //                 },
  //               ),
  //             ],
  //           );
  //         });
  //     // Não permite sair automaticamente da tela, caso pressione o botão "voltar".
  //     Future.value(false);
  //   } else {
  //     //Permite sair automaticamente da tela pressionando o botão "voltar".
  //     Future.value(true);
  //   }
  // }

  logout(UserBloc bloc) {
    bloc.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
      SignInPage.routeName,
      (_) => false,
    );
  }
}
