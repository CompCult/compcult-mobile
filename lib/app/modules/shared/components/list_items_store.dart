import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/models/item.dart';
import 'package:museu_vivo/app/modules/store/store_page_bloc.dart';

Widget listItemsStore(
    BuildContext context, ItensBloc itensBloc, bool isItensPurchased) {
  return StreamBuilder(
    stream: isItensPurchased ? itensBloc.itensPurchased : itensBloc.itens,
    builder: (_, snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (snapshot.data.length == 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: isItensPurchased
                    ? Text(
                        "Você não comprou nenhum item...",
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "O professor não cadastrou nenhum item...",
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ],
        );
      }
      return _buildListItens(
          context, snapshot.data, itensBloc, isItensPurchased);
    },
  );
}

_buildListItens(BuildContext context, List<Item> itens, ItensBloc itensBloc,
    bool isItensPurchased) {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: itens.length,
    itemBuilder: (_, i) {
      final item = itens[i];

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.white,
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  child: Container(
                    child: Image.network(
                      item.image,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        '${item.description}',
                        style: TextStyle(
                          fontFamily: "SourceSansPro",
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Preço:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    width: 17,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.yellow),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '${item.value}',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Restam:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 150),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onPressed: () async {
                            try {
                              await itensBloc.createItemOrder(item.id);
                            } catch (err) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Algo deu errado')));
                            }
                          },
                          color: Colors.blue,
                          child: Text(
                            "COMPRAR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
