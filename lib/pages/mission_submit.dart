import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/models/mission.dart';

class MissionSubmit extends StatelessWidget {
  static const String routeName = '/mission-submit';

  final Mission _mission;

  MissionSubmit(this._mission);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // _mission.name,
          "Submeter resposta",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  _mission.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _mission.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "SourceSansPro",
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  maxLines: 7,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Resposta",
                    labelStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    hintText: "Insira um texto...",
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _flatButtonIcon("Câmera", Icons.add_a_photo),
                    _flatButtonIcon("Galeria", Icons.wallpaper),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                _buildButton("ENVIAR RESPOSTA"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label) {
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
            label,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          // Aqui estarah a funcao para efetuar login. Por enquanto, está só uma validação de campos.
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _flatButtonIcon(String label, IconData icon) {
    return FlatButton.icon(
      padding: EdgeInsets.only(left: 10, right: 10),
      onPressed: () {},
      icon: Icon(icon),
      label: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
