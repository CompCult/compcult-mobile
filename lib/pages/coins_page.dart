import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/challenges_session_home.dart';
import 'package:museu_vivo/pages/ranking_session_home.dart';
import 'package:museu_vivo/pages/thematic_session_home.dart';
import 'package:museu_vivo/shared/components/custom_appbar.dart';

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
        title: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Ranking(),
                SizedBox(
                  height: 8,
                ),
                
                ThematicSession(),
                SizedBox(
                  height: 8,
                ),
                Challenges(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
