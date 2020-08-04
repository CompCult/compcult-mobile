import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museu_vivo/app/modules/shared/models/mission.dart';

class ItemCard extends StatelessWidget {
  final dynamic item;
  final String routeName;
  final String imageAssetPath;

  ItemCard({this.item, this.routeName, this.imageAssetPath});

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
                      content: Text(
                        'Enviado com sucesso!',
                        style: TextStyle(color: Colors.white),
                      ),
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
                  child: Image.asset(imageAssetPath),
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
                    width: MediaQuery.of(context).size.width / 2,
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
                      SvgPicture.asset(
                        'assets/leratos/points.svg',
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text('${item.lux}',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          )),
                      SizedBox(
                        width: 7,
                      ),
                      SvgPicture.asset(
                        'assets/leratos/coins.svg',
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${item.resources}',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  if (item is Mission && item.isEntrepreneurial)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.green,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Empreendedorismo',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
