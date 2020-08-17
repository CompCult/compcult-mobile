import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardPoints extends StatelessWidget {
  final int point;
  final String pointName;
  final String icon;

  const CardPoints({Key key, this.point, this.pointName, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10.0, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SvgPicture.asset(
                    icon,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${point}",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                pointName,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  color: Colors.black45,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
