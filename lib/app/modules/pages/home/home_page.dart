import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/coins/coins_page.dart';
import 'package:museu_vivo/app/modules/pages/games/games_page.dart';
import 'package:museu_vivo/app/modules/pages/user/user_page.dart';
import 'package:museu_vivo/app/modules/store/store_page.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = GamesPage(); // A view inicial
  int _currentIndex = 0;

  final tabs = [
    // DashboardPage(),
    CoinsPage(),
    GamesPage(),
    StorePage(),
    UserPage(),
  ];

  @override
  void didChangeDependencies() {
    HomeBloc homeBloc = BlocProvider.getBloc<HomeBloc>();
    homeBloc.fetchMissions();
    homeBloc.fetchQuizzes();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Color(0xff60B3FC) : Colors.black,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset,
                  color: _currentIndex == 1 ? Color(0xff60B3FC) : Colors.black),
              title: Text(
                'Minijogos',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_shopping_cart,
                  color: _currentIndex == 2 ? Color(0xff60B3FC) : Colors.black),
              title: Text(
                'Loja',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _currentIndex == 3 ? Color(0xff60B3FC) : Colors.black),
              title: Text(
                'Perfil',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
