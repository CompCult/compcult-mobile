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
  @override
  Widget build(BuildContext context) {
    final MissionsBloc missionsBloc = BlocProvider.getBloc<MissionsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/leratos/fundo_quizzes.jpg",
              ),
              fit: BoxFit.cover),
        ),
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 160,
                    child: SecretCodeField(
                      label: 'Código secreto da missão',
                      onSubmited: (missionId) async {
                        try {
                          Mission mission =
                              await missionsBloc.getSecretMission(missionId);

                          Navigator.of(context).pushNamed(
                              MissionSubmit.routeName,
                              arguments: mission);
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Text(e), backgroundColor: Colors.red),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        border: Border.all(color: Colors.black38)),
                    height: 35,
                    width: 140,
                    child: FlatButton(
                      padding: EdgeInsets.all(2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () =>
                          Navigator.of(context).pushNamed(TeamsPage.routeName),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.group,
                            color: Color(0xff60B3FC),
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Minhas Equipes",
                            style: TextStyle(
                                fontSize: 10,
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
                ],
              ),
              SizedBox(height: 15),
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
            ],
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
          imageAssetPath: "assets/leratos/flag.png",
        );
      },
    );
  }
}
