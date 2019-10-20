import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text(
              'Ranking',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          FutureBuilder(
            future: _getUsers(),
            builder: (_, snapshot) {
              if (!snapshot.hasData)
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              final List users = snapshot.data.data;
              users.sort((a, b) => b['points'] - a['points']);

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: users.length,
                itemBuilder: (_, i) {
                  return ListTile(
                    title: Text(users[i]['name']),
                    trailing: Text('${users[i]['points']}'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<Response> _getUsers() {
    return Dio().get('https://museu-vivo-api.herokuapp.com/users');
  }
}
