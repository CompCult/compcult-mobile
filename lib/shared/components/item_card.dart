import 'package:flutter/material.dart';
import 'package:museu_vivo/shared/models/mission.dart';

class ItemCard extends StatelessWidget {
  final Mission mission;
  final String routeName;

  ItemCard({this.mission, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(routeName, arguments: mission);
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                mission.name,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${mission.description.substring(0, 140)}...',
                style: TextStyle(
                  fontFamily: "SourceSansPro",
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${mission.points} PONTOS',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
