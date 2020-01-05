import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/ranking_bloc.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:provider/provider.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RankingBloc rankingBloc = BlocProvider.getBloc<RankingBloc>();
    final Dio dio = Provider.of<Dio>(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 0),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Text(
              'Ranking',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Divider(),
          FutureBuilder(
            future: rankingBloc.fetchUsers(),
            builder: (_, snapshot) {
              if (!snapshot.hasData)
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              final List<User> users = snapshot.data;

              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: users.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      leading: Text(
                        '#${i + 1}',
                        style: TextStyle(fontSize: 18),
                      ),
                      title: Text(users[i].name),
                      trailing: Text(
                        '${users[i].points}',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<Response> _getUsers(Dio dio) {
    return dio.get('/users');
  }
}
