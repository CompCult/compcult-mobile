import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/team_detais.dart';
import 'package:museu_vivo/shared/components/custom_bottom_sheet.dart';
import 'package:museu_vivo/shared/models/group.dart';
import 'package:museu_vivo/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

class TeamsPage extends StatelessWidget {
  static const String routeName = '/teams';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              CustomBottomSheet.showCustomBottomSheet(
                context: context,
                child: new TeamNameForm(),
              );
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _getGroups(context),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final Response response = snapshot.data;

            final List<Group> groups = List<Group>.from(
                response.data.map((group) => Group.fromJson(group)));

            return _buildGroupList(context, groups);
          },
        ),
      ),
    );
  }

  Future<dynamic> _getGroups(BuildContext context) async {
    final int userId = Provider.of<UserProvider>(context).userId;
    final Dio dio = Provider.of<Dio>(context);
    Response response = await dio.get('/group_members/groups?_user=$userId');

    return response;
  }

  Widget _buildGroupList(BuildContext context, List<Group> groups) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (_, i) => Column(
        children: <Widget>[
          ListTile(
            title: Text(groups[i].name),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.of(context)
                .pushNamed(TeamDetails.routeName, arguments: groups[i]),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}

class TeamNameForm extends StatefulWidget {
  const TeamNameForm({
    Key key,
  }) : super(key: key);

  @override
  _TeamNameFormState createState() => _TeamNameFormState();
}

class _TeamNameFormState extends State<TeamNameForm> {
  String _teamName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildTeamForm(),
            SizedBox(height: 30),
            RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Criar Equipe',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              onPressed: () => _createGroup(context, _teamName),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  TextFormField _buildTeamForm() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nome da equipe',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() => _teamName = value),
      autofocus: true,
    );
  }

  Future<dynamic> _createGroup(BuildContext context, String groupName) async {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final Dio dio = Provider.of<Dio>(context);
    Response response = await dio.post('/groups', data: {'name': groupName});

    await dio.post(
      '/group_members',
      data: {
        'email': userProvider.email,
        'isAdmin': true,
        'group': response.data['_id']
      },
    );

    Navigator.of(context).pushNamed(
      TeamDetails.routeName,
      arguments: Group.fromJson(response.data),
    );
  }
}
