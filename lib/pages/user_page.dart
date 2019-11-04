import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/home_page.dart';
import 'package:museu_vivo/pages/sign_in_page.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // Exibir o nome do usuário
          "Olá, fulano!",
          style: TextStyle(fontFamily: "Poppins", fontSize: 18),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              SignInPage.routeName,
              (_) => false,
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: _requestPop,
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            children: <Widget>[
              _profilePicture(),
              SizedBox(height: 30),
              _buildFormField("Nome", _nameController, false),
              SizedBox(height: 10),
              _buildFormField("Instituição", _institutionController, false),
              SizedBox(height: 10),
              _buildFormField("E-mail", _emailController, false),
              SizedBox(height: 10),
              _buildFormField("Senha", _passwordController, true),
              SizedBox(height: 15),
              _buildButton(),
            ],
          ),
        ),
      ),
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

  Widget _buildButton() {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [
            Color(0xFFf44336),
            Color(0XFFc62828),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: SizedBox.expand(
        child: FlatButton(
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
          onPressed: () {},
        ),
      ),
    );
  }

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

  Future<bool> _requestPop() {
    // Se o campo de nome for mudado (só por exemplo)...
    if (_nameController.value != null) {
      showDialog(
          context: context,
          builder: (context) {
            // Diálogo que aparece no centro da tela
            return AlertDialog(
              title: Text("Descartar alterações?"),
              content: Text(
                "Se você sair, as suas modificações serão perdidas.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: "SourceSansPro",
                  fontSize: 15,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Sim",
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Remove o diálogo
                    // Remove o diálogo e vai para HomePage()
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (_) => false);
                  },
                ),
                FlatButton(
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Remove o diálogo
                  },
                ),
              ],
            );
          });
      // Não permite sair automaticamente da tela, caso pressione o botão "voltar".
      Future.value(false);
    } else {
      //Permite sair automaticamente da tela pressionando o botão "voltar".
      Future.value(true);
    }
  }
}
