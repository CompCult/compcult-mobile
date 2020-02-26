import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/bloc/user_bloc.dart';
import 'package:museu_vivo/shared/models/user.dart';

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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green,
              ),
              height: 15,
              width: 20,
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.yellow,
              ),
              height: 15,
              width: 20,
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.red,
              ),
              height: 15,
              width: 20,
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.blue,
              ),
              height: 15,
              width: 20,
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
