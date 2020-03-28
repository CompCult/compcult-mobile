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
                      content: Text('Enviado com sucesso!',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.blue.withOpacity(0.7),
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
                height: 125,
                width: 110,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2 ,
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 160,
                    child: Text(
                      '${item.description.length >= 30 ? item.description.substring(0, 30) : item.description}...',
                      style: TextStyle(
                        fontFamily: "SourceSansPro",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 17,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 3,),
                      Text(
                      '${item.lux}',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      )),
                      SizedBox(width: 7,),
                      Container(
                        width: 17,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.yellow
                        ),
                      ),
                      SizedBox(width: 3,),
                      Text(
                      '${item.resources}',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      )),
                    ],
                  )
                  
                  /*Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${item.lux} LUX | ${item.resources} RSC',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  )*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
