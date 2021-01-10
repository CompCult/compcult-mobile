import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/profile/widgets/description_field.dart';
import 'package:museu_vivo/app/modules/profile/widgets/title_field.dart';
import 'package:museu_vivo/app/shared/widgets/custom_submit_button.dart';

import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key key, this.title = "Profile"}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileController> {
  //use 'controller' variable to access controller

  // TODO: Obter dados da API...
  var items = [
    {
      "quantity": "3",
      "label": "Missões cumpridas",
    },
    {
      "quantity": "2",
      "label": "Quizzes respondidos",
    },
    {
      "quantity": "0",
      "label": "Itens comprados na Loja",
    },
    {
      "quantity": "1",
      "label": "Grupos em que participa",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.045,
                  left: 15.0,
                  right: 15.0,
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            bottom: 15.0,
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://img.pngio.com/profile-icon-png-image-free-download"
                                "-searchpngcom-profile-icon-png-673_673.png"),
                            radius: 50,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        TitleField(title: controller.user.name),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 30.0,
                          ),
                          child: DescriptionField(
                            description: controller.user.email,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: 20.0,
                  right: 20.0,
                  child: Column(
                    children: this
                        .items
                        .map(
                          (element) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    element["quantity"],
                                    style: TextStyle(
                                      fontFamily: "Product Sans",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Text(
                                    element["label"],
                                    style: TextStyle(
                                      fontFamily: "Product Sans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 40,
                  right: 40,
                  child: CustomSubmitButton(
                    label: "SAIR",
                    functionSubmit: controller.logout,
                    labelColor: Colors.white,
                    backgroundColor: Color(0xFF0072D5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
