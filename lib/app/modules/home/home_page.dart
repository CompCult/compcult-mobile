import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';
import 'package:museu_vivo/app/shared/widgets/card_item.dart';
import 'package:museu_vivo/app/shared/widgets/custom_bottom_bar.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    final _authController = Modular.get<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logout();
              Modular.to.pushNamedAndRemoveUntil("/login", (_) => false);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(250, 250, 250, 1),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "O que vamos fazer hoje?",
                  style: TextStyle(
                    color: Color(0xFF2d91e7),
                    fontFamily: "Product Sans",
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: CardItem(
                        label: "QUIZZES",
                        imageFileName: "quizzes-icon.png",
                        routeName: "quiz_page",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: CardItem(
                        label: "MISSÕES",
                        imageFileName: "missions-icon.png",
                        routeName: "quiz_page",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: CardItem(
                        label: "MINI\nJOGOS",
                        imageFileName: "minigames-icon.png",
                        routeName: "quiz_page",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
