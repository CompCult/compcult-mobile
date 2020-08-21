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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        elevation: 3,
        child: Row(
          children: <Widget>[
            Container(
              child: Center(
                child: Image.asset(imageAssetPath),
              ),
              height: 80,
              width: 80,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF50555C),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontFamily: "SourceSansPro",
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item is Mission && item.isEntrepreneurial)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xff60B3FC),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Empreendedorismo',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    SizedBox(height: 10),
                    buildSelectButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectButton(BuildContext context) {
    Widget notAnsweredSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          height: 25,
          child: MaterialButton(
              onPressed: () async => await Navigator.of(context)
                  .pushNamed(routeName, arguments: item),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: Color(0xff1fce27),
              child: Text(
                item.answered ? "REALIZADO" : "REALIZAR",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),
      ],
    );

    Widget answeredSection = MaterialButton(
      height: 25,
      onPressed: item.singleAnswer
          ? () {}
          : () async =>
              await Navigator.of(context).pushNamed(routeName, arguments: item),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: item.singleAnswer
          ? Color.fromRGBO(196, 196, 196, 0.4)
          : Color(0xff1fce27),
      child: Center(
        child: Text(
          item.singleAnswer ? "REALIZADO" : "REALIZAR NOVAMENTE",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );

    return item.answered ? answeredSection : notAnsweredSection;
  }
}
