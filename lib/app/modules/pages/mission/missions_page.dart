import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/mission_submit/mission_submit.dart';
import 'package:museu_vivo/app/modules/pages/teams/teams_page.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';
import 'package:museu_vivo/app/modules/shared/components/item_card.dart';
import 'package:museu_vivo/app/modules/shared/components/secret_code_field.dart';
import 'package:museu_vivo/app/modules/shared/models/mission.dart';

import 'missions_bloc.dart';

class MissionsPage extends StatefulWidget {
  @override
  _MissionsPageState createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final MissionsBloc missionsBloc = BlocProvider.getBloc<MissionsBloc>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: CustomAppBar(),
        elevation: 0,
      ),
      body: Container(
        child: ListView(children: <Widget>[
          SizedBox(height: 15),
          Container(
            child: SecretCodeField(
              label: 'Código secreto da missão',
              onSubmited: (missionId) async {
                try {
                  Mission mission =
                      await missionsBloc.getSecretMission(missionId);

                  Navigator.of(context)
                      .pushNamed(MissionSubmit.routeName, arguments: mission);
                } catch (e) {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                        content: Text(
                            'Ops! Algo deu errado, por vafor verifique o código e tente novamente.'),
                        backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                border: Border.all(color: Colors.black38)),
            height: 40,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () =>
                  Navigator.of(context).pushNamed(TeamsPage.routeName),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.group,
                    color: Color(0xff60B3FC),
                    size: 16,
                  ),
                  Text(
                    "Minhas Equipes",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.black38),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color(0xff60B3FC),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: missionsBloc.missions,
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return _buildList(snapshot.data);
            },
          ),
        ]),
      ),
    );
  }

  _buildList(List<Mission> missions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: missions.length,
      itemBuilder: (_, i) {
        final mission = missions[i];

        return ItemCard(
          item: mission,
          routeName: MissionSubmit.routeName,
          imageAssetPath: getImageAssetPathFromMission(mission),
        );
      },
    );
  }

  String getImageAssetPathFromMission(Mission mission) {
    String path = '';

    if (mission.hasImage || mission.hasVideo) path += 'camera';
    if (mission.hasAudio) path += 'audio';
    if (mission.hasText) path += 'text';
    if (mission.hasGeolocation) path += 'localization';

    if (path == '') path = 'cameraaudiotextlocalization';

    path = 'assets/leratos/$path.png';

    return path;
  }
}
