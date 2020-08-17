import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/user/radial_progress.dart';

import 'rounded_image.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String email;

  const UserInfo({Key key, this.name, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RadialProgress(
            width: 4,
            goalCompleted: 1  ,
            child: RoundedImage(
              imagePath: "assets/logo-profile.png",
              size: Size.fromWidth(120.0),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Text(
            email,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
