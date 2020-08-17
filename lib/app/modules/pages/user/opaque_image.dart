import 'package:flutter/material.dart';

class OpaqueImage extends StatelessWidget {

  final image;

  const OpaqueImage({Key key, this.image}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          image,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.fill,
        ),
        Container(
          color: Color(0xff60B3FC).withOpacity(0.85 ),
        )
      ],
    );
  }
}