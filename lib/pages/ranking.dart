import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/ranking_bloc.dart';
import 'package:museu_vivo/shared/models/user.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RankingBloc rankingBloc = BlocProvider.getBloc<RankingBloc>();

    return Container(
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff60B3FC),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.only(top: 2, left: 10, right: 10),
          child: ExpansionTile(
            title: PersonalRank(),
            children: <Widget>[
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

              return ListView.builder(
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
              );
            },
          ),
            ],
          ),
        ),
      ),
    );

    /*Container(
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
    );*/
    
  }
}

class PersonalRank extends StatelessWidget {
  const PersonalRank({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "RANKING",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "#3 Italo Miguel",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 14, color: Colors.white),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "ver mais",
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ],
    );
  }
}
