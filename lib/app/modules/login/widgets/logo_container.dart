import "package:flutter/material.dart";
import 'package:museu_vivo/config.dart';

class LogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.24,
      height: MediaQuery.of(context).size.width * 0.24,
      child: Image.asset(
        'assets/images/${config.assetsDirectoryName}/icon.png',
      ),
    );
  }
}