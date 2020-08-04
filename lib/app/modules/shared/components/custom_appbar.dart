import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museu_vivo/app/modules/pages/user/user_bloc.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.getBloc<UserBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // **** Pontuação de LUX ****
        Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/leratos/points.svg',
            ),
            SizedBox(
              width: 5,
            ),
            StreamBuilder<User>(
              stream: bloc.user,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Text(
                  '${snapshot.data.lux}',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                );
              },
            ),
          ],
        ),
        // **** Pontuação de Recursos ****
        Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/leratos/coins.svg',
            ),
            SizedBox(
              width: 5,
            ),
            StreamBuilder<User>(
              stream: bloc.user,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Text(
                  '${snapshot.data.resources}',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                );
              },
            ),
          ],
        ),
        // **** Pontuação de Impactos ****
        Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/leratos/group.svg',
            ),
            SizedBox(
              width: 5,
            ),
            StreamBuilder<User>(
              stream: bloc.user,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Text(
                  '${snapshot.data.imp}',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                );
              },
            ),
          ],
        ),
        // **** Pontuação de Pessoas ****
        Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/leratos/help.svg',
            ),
            SizedBox(
              width: 5,
            ),
            StreamBuilder<User>(
              stream: bloc.user,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Text(
                  '${snapshot.data.people}',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
