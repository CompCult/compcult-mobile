import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/activities/activities_page.dart';
import 'package:museu_vivo/app/modules/home/home_page.dart';
import 'package:museu_vivo/app/modules/profile/profile_page.dart';
import 'package:museu_vivo/app/modules/store/store_page.dart';

import 'initial_controller.dart';

class InitialPage extends StatefulWidget {
  final String title;
  const InitialPage({Key key, this.title = "Initial"}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends ModularState<InitialPage, InitialController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    final List<Tab> appTabs = <Tab>[
      Tab(
        icon: Icon(Icons.home),
      ),
      Tab(
        icon: Icon(Icons.videogame_asset),
      ),
      Tab(
        icon: Icon(Icons.store),
      ),
      Tab(
        icon: Icon(Icons.person),
      ),
    ];

    return DefaultTabController(
      length: appTabs.length,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomePage(),
            ActivitiesPage(),
            StorePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: appTabs,
          labelColor: ThemeData().primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.only(bottom: 5.0),
          indicatorColor: ThemeData().primaryColor,
        ),
      ),
    );
  }
}
