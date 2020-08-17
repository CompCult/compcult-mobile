import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/sign_in/sign_in_page.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';

import '../games/games_page.dart';
import '../teams/teams_page.dart';
import 'card_points.dart';
import 'opaque_image.dart';
import 'user_bloc.dart';
import 'user_info.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.getBloc<UserBloc>();

    return Scaffold(
        body: StreamBuilder<User>(
      stream: bloc.user,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: <Widget>[
                      OpaqueImage(
                        image: "assets/logo-profile.png",
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Meu perfil",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => logout(bloc),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            "Sair ",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.exit_to_app,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              UserInfo(
                                  name: snapshot.data.name,
                                  email: snapshot.data.email)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 50, right: 8.0, left: 8.0),
                      child: Table(
                        children: [
                          TableRow(children: [
                            CardPoints(
                              icon: 'assets/leratos/points.svg',
                              point: snapshot.data.lux,
                              pointName: "Lux",
                            ),
                            CardPoints(
                              icon: 'assets/leratos/coins.svg',
                              point: snapshot.data.resources,
                              pointName: "Resources",
                            )
                          ]),
                          TableRow(
                            children: [
                              CardPoints(
                                icon: 'assets/leratos/group.svg',
                                point: snapshot.data.imp,
                                pointName: "Imp",
                              ),
                              CardPoints(
                                icon: 'assets/leratos/help.svg',
                                point: snapshot.data.people,
                                pointName: "People",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * (4 / 10) - 20,
              left: 16,
              right: 16,
              child: Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(TeamsPage.routeName),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.group),
                                  Text(
                                    "Minhas Equipes",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(GamesPage.routeName),
                        child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.gamepad),
                                ],
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "12°",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "Ranking",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    )

        /*appBar: AppBar(
        title: StreamBuilder<User>(
            stream: bloc.user,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Olá, ${snapshot.data.name}!',
                    style: TextStyle(fontFamily: "Poppins", fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => logout(bloc),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Sair ",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                        ),
                        Icon(Icons.exit_to_app),
                      ],

                    ),
                  )
                ],
              );
            }),
      ),
      body: StreamBuilder<User>(
        stream: bloc.user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // padding: EdgeInsets.only(top: 30, left: 40, right: 40),
              children: <Widget>[
                _profilePicture(),
                SizedBox(height: 30),
                Text(snapshot.data.name),
                SizedBox(height: 10),
                Text(snapshot.data.email),
                SizedBox(height: 10),
                SizedBox(height: 15),
              ],
            ),
          );
        },
      ),*/
        );
  }

  Widget _profilePicture() {
    return GestureDetector(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/logo-profile.png"),
          ),
        ),
      ),
      onTap: _getImage,
    );
  }

  // Capturar a imagem e substituir no BD
  Future _getImage() async {}

  logout(UserBloc bloc) {
    bloc.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
      SignInPage.routeName,
      (_) => false,
    );
  }
}
