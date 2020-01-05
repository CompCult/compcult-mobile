import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/config.dart';
import 'package:museu_vivo/pages/ranking.dart';
import 'package:museu_vivo/shared/models/user.dart';

import 'coins_bloc.dart';

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
    return Container(
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
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.monetization_on,
              color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  );
          },
        ),
      ],
    );
  }
}
