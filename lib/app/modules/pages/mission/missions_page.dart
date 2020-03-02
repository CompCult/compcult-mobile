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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Minhas equipes',
                  style: TextStyle(),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () =>
                    Navigator.of(context).pushNamed(TeamsPage.routeName),
              ),
              SizedBox(height: 15),
              SecretCodeField(
                label: 'Código secreto da missão',
                onSubmited: (missionId) async {
                  try {
                    Mission mission =
                        await missionsBloc.getSecretMission(missionId);

                    Navigator.of(context)
                        .pushNamed(MissionSubmit.routeName, arguments: mission);
                  } catch (e) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(e), backgroundColor: Colors.red),
                    );
                  }
                },
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
        ),
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
        );
      },
    );
  }
}
