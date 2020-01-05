import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/shared/models/group.dart';
import 'package:provider/provider.dart';

class TeamDetails extends StatefulWidget {
  static const String routeName = '/group-details';

  final Group group;

  TeamDetails(this.group);

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  var _teamMembers = List();

  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(children: <Widget>[
          _buildField("Adicionar membro"),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: _getMembersGroup(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                _teamMembers = snapshot.data.data;

                return ListView.builder(
                  itemCount: _teamMembers.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(_teamMembers[index]);
                    return ListTile(
                      title: Text(_teamMembers[index]['_user']['name']),
                      leading: Icon(Icons.person),
                      trailing: _buildRemoveMemberButton(index),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildField(String label) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person_add),
      ),
      style: TextStyle(
        fontSize: 15,
        fontFamily: "Poppins",
      ),
      onSubmitted: (value) {
        setState(() {
          _textFieldController.clear();
          _createMembersGroup(value);
        });
      },
    );
  }

  Widget _buildRemoveMemberButton(int index) {
    return IconButton(
      focusColor: Colors.transparent,
      icon: Icon(Icons.close),
      onPressed: () {
        setState(() {
          var member = _teamMembers.removeAt(index);
          _deleteMemberGroup(member['_id']);
        });
      },
    );
  }

  Future<dynamic> _createMembersGroup(String email) async {
    final Dio dio = Provider.of<Dio>(context);
    Response response = await dio.post('/group_members/',
        data: {"email": email, "_group": widget.group.id, "is_admin": false});

    return response;
  }

  Future<dynamic> _deleteMemberGroup(String id) async {
    final Dio dio = Provider.of<Dio>(context);
    Response response = await dio.delete('/group_members/$id');
    return response;
  }

  Future<dynamic> _getMembersGroup() async {
    final Dio dio = Provider.of<Dio>(context);
    Response response =
        await dio.get('/group_members/query/fields?_group=${widget.group.id}');

    return response;
  }
}
