import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/activities/controllers/mission_controller.dart';

class MissionPage extends StatefulWidget {
  final String title;
  const MissionPage({Key key, this.title = "Mission"}) : super(key: key);

  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends ModularState<MissionPage, MissionController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.fetchMissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: controller.missions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${controller.missions[index].name}'),
          );
        },
      ),
    );
  }
}
