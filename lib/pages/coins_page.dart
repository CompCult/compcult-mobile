import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CoinsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = Provider.of<UserProvider>(context).userId;

    return Container(
      child: Center(
          child: FutureBuilder(
        future: _getCoins(userId),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Text('${snapshot.data.data['points']}');
        },
      )),
    );
  }

  Future<Response> _getCoins(int userId) {
    return Dio().get('https://museu-vivo-api.herokuapp.com/users/$userId');
  }
}
