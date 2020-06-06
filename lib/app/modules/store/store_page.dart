import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'store_controller.dart';

class StorePage extends StatefulWidget {
  final String title;
  const StorePage({Key key, this.title = "Store"}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends ModularState<StorePage, StoreController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
