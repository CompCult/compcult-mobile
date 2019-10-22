import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              future: _getCoins(userId),
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? Text(
                        '${snapshot.data.data['points']}',
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
        ),
      ),
    );
  }

  Future<Response> _getCoins(int userId) {
    return Dio().get('https://museu-vivo-api.herokuapp.com/users/$userId');
  }
}
