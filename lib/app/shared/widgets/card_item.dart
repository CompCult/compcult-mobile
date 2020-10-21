import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardItem extends StatefulWidget {
  final String label;
  final String imageFileName;
  final String routeName;

  const CardItem({
    this.label,
    this.imageFileName,
    this.routeName,
  });

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Modular.to.pushNamed("/${widget.routeName}");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.35),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.19,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.125,
                child: Image.asset("assets/images/${widget.imageFileName}"),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  "${widget.label}",
                  style: TextStyle(
                    color: Color(0xFF2d91e7),
                    fontFamily: "Product Sans",
                    fontSize: MediaQuery.of(context).size.height * 0.046,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Image.asset("assets/images/right-arrow.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
