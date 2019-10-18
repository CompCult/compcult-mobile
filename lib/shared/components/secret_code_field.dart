import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/mission_submit.dart';
import 'package:museu_vivo/shared/models/mission.dart';

class SecretCodeField extends StatefulWidget {
  @override
  _SecretCodeFieldState createState() => _SecretCodeFieldState();
}

class _SecretCodeFieldState extends State<SecretCodeField> {
  final _secretCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _secretCodeController,
      decoration: InputDecoration(
        labelText: 'Código secreto da missão',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: () async {
            Response response = await Dio().get(
                'https://museu-vivo-api.herokuapp.com/missions/private?secret_code=${_secretCodeController.text}');
            Mission mission = Mission.fromJson(response.data);

            Navigator.of(context)
                .pushNamed(MissionSubmit.routeName, arguments: mission);
          },
        ),
      ),
      style: TextStyle(
        fontSize: 13,
        fontFamily: "Poppins",
      ),
    );
  }
}
