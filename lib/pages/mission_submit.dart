import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:museu_vivo/shared/providers/user_provider.dart';

import '../shared/models/mission.dart';

class MissionSubmit extends StatefulWidget {
  static const String routeName = '/mission-submit';

  final Mission _mission;

  MissionSubmit(this._mission);

  @override
  _MissionSubmitState createState() => _MissionSubmitState();
}

class _MissionSubmitState extends State<MissionSubmit> {
  File _image;
  String _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                  widget._mission.name,
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
                Container(
                  height: 100,
                  child: SingleChildScrollView(
                    child: Text(
                      widget._mission.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SourceSansPro",
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) => _text = value,
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
                    _flatButtonIcon(
                        "Câmera", Icons.add_a_photo, _getImageFromCamera),
                    _flatButtonIcon(
                        "Galeria", Icons.wallpaper, _getImageFromGallery),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  child: _image == null
                      ? Text(
                          "Nenhuma imagem selecionada...",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.red,
                          ),
                        )
                      : Text(
                          "Imagem carregada!",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: _buildButton("ENVIAR RESPOSTA"),
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
        // borderRadius: BorderRadius.all(
        //   Radius.circular(5),
        // ),
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
          onPressed: () async {
            final int userId = Provider.of<UserProvider>(context).userId;
            String base64 = await _changeFormatImage();

            await Dio().post(
              'https://museu-vivo-api.herokuapp.com/missions_answers',
              data: {
                '_user': userId,
                '_mission': widget._mission.id,
                'image': base64,
                'text_msg': _text,
              },
            );

            Navigator.of(context).pop(true);
          },
        ),
      ),
    );
  }

  Widget _flatButtonIcon(String label, IconData icon, Function func) {
    return FlatButton.icon(
      padding: EdgeInsets.only(left: 10, right: 10),
      onPressed: func,
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

  Future _getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  // Transforma em Base64
  // Caso as imagens sejam muito grandes, é necessário usar um Future.
  Future<String> _changeFormatImage() async {
    List<int> imageBytes = await _image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
