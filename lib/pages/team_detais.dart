import 'package:flutter/material.dart';
import 'package:museu_vivo/shared/models/group.dart';

class TeamDetails extends StatelessWidget {
  static const String routeName = '/group-details';

  final Group group;

  TeamDetails(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Id do grupo: ${group.id}'),
      ),
    );
  }
}
