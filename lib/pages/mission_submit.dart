import 'package:flutter/material.dart';

import '../shared/models/mission.dart';

class MissionSubmit extends StatelessWidget {
  static const String routeName = '/mission-submit';

  final Mission _mission;

  MissionSubmit(this._mission);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mission.name),
      ),
      body: Center(
        child: Text('Id da missão: ${_mission.id}'),
      ),
    );
  }
}
