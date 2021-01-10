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
      initialIndex: 0,
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
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TabBar(
            tabs: appTabs,
            labelColor: ThemeData().primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(bottom: 5.0),
            indicatorColor: ThemeData().primaryColor,
          ),
        ),
      ),
    );
  }
}
