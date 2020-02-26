import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/bloc/ranking_bloc.dart';
import 'package:museu_vivo/shared/models/user.dart';

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
