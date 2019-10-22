import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './sign_in_page.dart';
import 'event_page.dart';
import 'feed_page.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Meu Vivo Museu',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                SignInPage.routeName,
                (route) => false,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Sair",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "FEED",
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
              Tab(
                child: Text(
                  "EVENTOS",
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FeedPage(),
            EventPage(),
          ],
        ),
      ),
    );
  }
}
