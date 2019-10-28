import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/group_detais.dart';
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
            onPressed: () {},
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
                .pushNamed(GroupDetails.routeName, arguments: groups[i]),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}
