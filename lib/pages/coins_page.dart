import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/ranking.dart';
import 'package:museu_vivo/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CoinsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = Provider.of<UserProvider>(context).userId;

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
              child: _buildPoints(context, userId),
            ),
            Expanded(
              child: Ranking(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoints(BuildContext context, int userId) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Suas gemas',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.monetization_on,
              color: Colors.red,
            ),
          ],
        ),
        SizedBox(height: 10),
        FutureBuilder(
          future: _getCoins(context, userId),
          builder: (_, snapshot) {
            return snapshot.hasData
                ? Text(
                    '${snapshot.data['points']}',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  );
          },
        ),
      ],
    );
  }

  Future<dynamic> _getCoins(BuildContext context, int userId) async {
    final Dio dio = Provider.of<Dio>(context);
    Response response = await dio.get('/users/$userId');

    return response.data;
  }
}
