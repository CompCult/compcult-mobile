import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final dynamic item;
  final String routeName;

  ItemCard({this.item, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          splashColor: Color(0xff60B3FC),
          onTap: () async {
            await Navigator.of(context)
                .pushNamed(routeName, arguments: item)
                .then(
              (value) {
                if (value != null) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Enviado com sucesso!'),
                      backgroundColor: Colors.grey,
                    ),
                  );
                }
              },
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    "...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Colors.blue),
                height: 100,
                width: 100,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${item.description.length > 30 ? item.description.substring(0, 30) : item.description}...',
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${item.lux} LUX | ${item.resources} RSC',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
