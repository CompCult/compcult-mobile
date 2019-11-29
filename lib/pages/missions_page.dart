import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:museu_vivo/pages/missions_bloc.dart';
import 'package:museu_vivo/pages/teams_page.dart';
import 'package:museu_vivo/shared/components/secret_code_field.dart';
import 'package:provider/provider.dart';

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
    final Dio dio = Provider.of<Dio>(context);

    final MissionsBloc missionsBloc = BlocProvider.getBloc<MissionsBloc>();

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
                try {
                  Response response =
                      await dio.get('/missions/private?secret_code=$missionId');
                  Mission mission = Mission.fromJson(response.data);

                  Navigator.of(context)
                      .pushNamed(MissionSubmit.routeName, arguments: mission);
                } on DioError catch (e) {
                  if (e.response.statusCode == 404) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Missão não existe'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (e.response.statusCode == 401) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Essa missão expirou'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: 15),
            FutureBuilder(
              future: missionsBloc.missions,
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
