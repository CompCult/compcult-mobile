import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/shared/models/group.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'mission_submit_bloc.dart';

class MissionSubmit extends StatefulWidget {
  static const String routeName = '/mission-submit';
  final Mission mission;

  MissionSubmit(this.mission);

  @override
  _MissionSubmitState createState() => _MissionSubmitState();
}

class _MissionSubmitState extends State<MissionSubmit> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final MissionSubmitBloc missionSubmitBloc =
        BlocProvider.getBloc<MissionSubmitBloc>();

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
                _buildTitle(missionSubmitBloc, widget.mission),
                SizedBox(
                  height: 20,
                ),
                _buildDescription(missionSubmitBloc, widget.mission),
                SizedBox(
                  height: 15,
                ),
                if (widget.mission.isGrupal) _buildTeamField(missionSubmitBloc),
                SizedBox(height: 15),
                if (widget.mission.hasText) _buildTextField(missionSubmitBloc),
                if (widget.mission.hasImage)
                  _buildImageField(missionSubmitBloc),
                const SizedBox(height: 40),
                if (widget.mission.hasImage)
                  _buildImageValidator(missionSubmitBloc),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: _buildButton(context, "ENVIAR RESPOSTA", missionSubmitBloc),
    );
  }

  Widget _buildTeamField(MissionSubmitBloc bloc) {
    return StreamBuilder<User>(
        stream: bloc.user,
        builder: (_, userSnapshot) {
          if (!userSnapshot.hasData) return Container();
          return FutureBuilder(
            future: _getGroups(userSnapshot.data.id),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return Container();

              final Response response = snapshot.data;

              final List<Group> groups = List<Group>.from(
                  response.data.map((group) => Group.fromJson(group)));

              var items = groups.map((Group group) {
                return DropdownMenuItem<String>(
                  value: group.id.toString(),
                  child: Text(group.name),
                );
              }).toList();

              return StreamBuilder<String>(
                  stream: bloc.groupAnswer,
                  builder: (context, groupSnapshot) {
                    return DropdownButton<String>(
                      hint: Text('Selecione um grupo'),
                      items: items,
                      onChanged: (value) => bloc.changeGroup(int.parse(value)),
                      value: groupSnapshot.data,
                    );
                  });
            },
          );
        });
  }

  Widget _buildImageValidator(MissionSubmitBloc missionSubmitBloc) {
    return StreamBuilder(
        stream: missionSubmitBloc.imageAnswer,
        builder: (context, snapshot) {
          return !snapshot.hasData
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
                );
        });
  }

  Widget _buildImageField(MissionSubmitBloc missionSubmitBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _flatButtonIcon("Câmera", Icons.add_a_photo,
            () => _getImageFromCamera(missionSubmitBloc)),
        _flatButtonIcon("Galeria", Icons.wallpaper,
            () => _getImageFromGallery(missionSubmitBloc)),
      ],
    );
  }

  Widget _buildTextField(MissionSubmitBloc missionSubmitBloc) {
    return StreamBuilder<String>(
        stream: missionSubmitBloc.textAnswer,
        builder: (context, snapshot) {
          return TextField(
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            onChanged: missionSubmitBloc.changeTextAnswer,
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
          );
        });
  }

  Widget _buildDescription(
      MissionSubmitBloc missionSubmitBloc, Mission mission) {
    return Text(
      mission.description,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "SourceSansPro",
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildTitle(MissionSubmitBloc missionSubmitBloc, Mission mission) {
    return Text(
      mission.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String label, MissionSubmitBloc bloc) {
    return Container(
      height: 50,
      color: Theme.of(context).accentColor,
      child: SizedBox.expand(
        child: FlatButton(
          child: _isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });

            try {
              await bloc.createMissionAnswer(widget.mission);
              Navigator.of(context).pop(true);
            } catch (e) {
              setState(() {
                _isLoading = false;
              });
            }
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

  Future<dynamic> _getGroups(String userId) async {
    final Dio dio = Provider.of<Dio>(context);
    Response response = await dio.get('/group_members/groups?_user=$userId');

    return response;
  }

  Future _getImageFromCamera(MissionSubmitBloc bloc) async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    bloc.changeImageAnswer(image);
  }

  Future _getImageFromGallery(MissionSubmitBloc bloc) async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    bloc.changeImageAnswer(image);
  }
}
