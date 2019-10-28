import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/pages/teams_page.dart';
import 'package:museu_vivo/shared/components/secret_code_field.dart';
import 'package:provider/provider.dart';

import '../shared/providers/user_provider.dart';
import '../shared/components/item_card.dart';
import './mission_submit.dart';
import '../shared/models/mission.dart';

class MissionsPage extends StatefulWidget {
  @override
  _MissionsPageState createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  @override
  Widget build(BuildContext context) {
    final int userId = Provider.of<UserProvider>(context).userId;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Minhas equipes',
                style: TextStyle(),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.of(context).pushNamed(TeamsPage.routeName),
            ),
            SizedBox(height: 15),
            SecretCodeField(
              label: 'Código secreto da missão',
              onSubmited: (missionId) async {
                Response response = await Dio().get(
                    'https://museu-vivo-api.herokuapp.com/missions/private?secret_code=$missionId');
                Mission mission = Mission.fromJson(response.data);

                Navigator.of(context)
                    .pushNamed(MissionSubmit.routeName, arguments: mission);
              },
            ),
            SizedBox(height: 15),
            FutureBuilder(
              future: _getMissions(userId),
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

                final Response response = snapshot.data;

                final List<Mission> missions = List<Mission>.from(
                    response.data.map((mission) => Mission.fromJson(mission)));
                return _buildList(missions);
              },
            ),
          ],
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

  Future<Response> _getMissions(int userId) {
    return Dio().get(
        'https://museu-vivo-api.herokuapp.com/missions/public?user_id=$userId');
  }
}
