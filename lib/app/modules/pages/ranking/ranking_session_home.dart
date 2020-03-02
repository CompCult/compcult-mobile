import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/user/user_bloc.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';

import 'ranking_bloc.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RankingBloc rankingBloc = BlocProvider.getBloc<RankingBloc>();

    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff60B3FC),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 2, left: 10, right: 10),
          child: ExpansionTile(
            title: PersonalRank(),
            children: <Widget>[
              Container(
                height: 300,
                child: FutureBuilder(
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
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          title: Text(
                            users[i].name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Text(
                            '${users[i].lux}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalRank extends StatefulWidget {
  const PersonalRank({
    Key key,
  }) : super(key: key);

  @override
  _PersonalRankState createState() => _PersonalRankState();
}

class _PersonalRankState extends State<PersonalRank> {
  UserBloc bloc = BlocProvider.getBloc<UserBloc>();
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
        Row(
          children: <Widget>[
            StreamBuilder<User>(
              stream: bloc.user,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Text(
                  '${snapshot.data.name}',
                  style: TextStyle(
                      fontFamily: "Poppins", fontSize: 18, color: Colors.white),
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            StreamBuilder<User>(
                stream: bloc.user,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return Text(
                    '${snapshot.data.lux}',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        color: Colors.white),
                  );
                }),
          ],
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
