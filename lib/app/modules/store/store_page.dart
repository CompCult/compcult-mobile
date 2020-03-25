import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';
import 'package:museu_vivo/app/modules/store/list_itens.dart';
import 'package:museu_vivo/app/modules/store/list_purchased_itens.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<bool> _selected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: CustomAppBar()),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/leratos/fundo_quizzes.jpg",
                ),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () {
                        setState(() {
                          _selected[1] = false;
                          _selected[0] = true;
                        });
                      },
                      color: _selected[0] == true
                          ? Color(0xff00036c)
                          : Color(0xff00036c).withOpacity(0.3),
                      child: Text(
                        "Não comprados",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () {
                        setState(() {
                          _selected[0] = false;
                          _selected[1] = true;
                        });
                      },
                      color: _selected[1] == true
                          ? Color(0xff00036c)
                          : Color(0xff00036c).withOpacity(0.3),
                      child: Text(
                        "Comprados",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                  )
                ],
              ),
              if (_selected[0]) ListItens(),
              if (_selected[1]) ListPurchasedItens()
            ],
          ),
        ));
  }
}
