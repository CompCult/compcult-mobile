import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final dynamic item;
  final String routeName;

  ItemCard({this.item, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(routeName, arguments: item)
              .then(
            (value) {
              if (value) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Enviado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.name,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${item.description.length > 140 ? item.description.substring(0, 140) : item.description}...',
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
