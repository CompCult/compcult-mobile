import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/sign_in/sign_in_page.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';

import 'user_bloc.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.getBloc<UserBloc>();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<User>(
            stream: bloc.user,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return Text(
                'Olá, ${snapshot.data.name}!',
                style: TextStyle(fontFamily: "Poppins", fontSize: 18),
              );
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logout(bloc),
          ),
        ],
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
      ),
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
