import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key key, this.title = "Profile"}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: controller.logout,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://img.pngio.com/profile-icon-png-image-free-download"
                      "-searchpngcom-profile-icon-png-673_673.png"),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                "Marcelo Barros",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.purple[50],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                "marcelo@compcult.net",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.purple[50],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
