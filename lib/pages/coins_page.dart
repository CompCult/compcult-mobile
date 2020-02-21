import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/config.dart';
import 'package:museu_vivo/pages/appbar_custom.dart';
import 'package:museu_vivo/pages/challenges.dart';
import 'package:museu_vivo/pages/ranking.dart';
import 'package:museu_vivo/pages/thematic_title.dart';
import 'package:museu_vivo/shared/models/user.dart';

import 'bloc/coins_bloc.dart';


class CoinsPage extends StatefulWidget {
  @override
  _CoinsPageState createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage> {
  @override
  void initState() {
    final coinsBloc = BlocProvider.getBloc<CoinsBloc>();
    coinsBloc.updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarCustom(),
      ),
      body: SingleChildScrollView(
              child: Container(
          
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Ranking(),
                SizedBox(height: 8,),
                ThematicTitle(),
                SizedBox(height: 8,),
                Challenges()
              ],
            ),
          )

        ),
      ),
    );
   /* Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: _buildPoints(context),
            ),
            Expanded(
              child: Ranking(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoints(BuildContext context) {
    CoinsBloc coinsBloc = BlocProvider.getBloc<CoinsBloc>();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              config.coinName,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.monetization_on,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
        SizedBox(height: 10),
        StreamBuilder<User>(
          stream: coinsBloc.user,
          builder: (_, snapshot) {
            return snapshot.hasData
                ? Text(
                    '${snapshot.data.points}',
                    style: TextStyle(
                      fontSize: 50,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  );
          },
        ),
      ],
    );*/
  }
}
