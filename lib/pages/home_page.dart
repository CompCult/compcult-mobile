import 'package:flutter/material.dart';

import 'coins_page.dart';
import 'dashboard_page.dart';
import 'main_page.dart';
import 'user_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Acompanha o índice da guia atual
  int currentTab = 0;

  // O intervalo de armazenamento da página a ser usado para esta subárvore
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = MainPage(); // A view inicial
  int _currentIndex = 0;

  final tabs = [
    DashboardPage(),
    CoinsPage(),
    MainPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cria um widget que fornece um depósito de armazenamento para seus descendentes
      body: PageStorage(
        bucket: bucket,
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Timeline'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Gemas'),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            title: Text('Atividades'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            backgroundColor: Colors.grey,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
