import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/models/item.dart';
import 'package:museu_vivo/app/modules/store/store_page_bloc.dart';

Widget listItemsStore(
    BuildContext context, ItensBloc itensBloc, bool isItemsPurchased) {
  return StreamBuilder(
    stream: isItemsPurchased ? itensBloc.itensPurchased : itensBloc.itens,
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
                child: isItemsPurchased
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
          context, snapshot.data, itensBloc, isItemsPurchased);
    },
  );
}

Widget _buildListItens(BuildContext context, List<Item> itens,
    ItensBloc itensBloc, bool isItemsPurchased) {
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  child: Container(
                    height: 150,
                    child: Center(
                      child: Image.network(
                        item.image,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 153,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item.name,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 153,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${item.description}',
                            style: TextStyle(
                              fontFamily: "SourceSansPro",
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Preço:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    width: 15,
                                    height: 13,
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
                                      fontSize: 15,
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
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (isItemsPurchased)
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        onPressed: () {
                          if (!isItemsPurchased) {
                            buyItem(context, itens, itensBloc, item);
                          }
                        },
                        color: Colors.blue,
                        child: Text(
                          "COMPRAR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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

void buyItem(
    BuildContext context, List<Item> itens, ItensBloc itensBloc, var item) {
  
  String successMessage = "A compra foi realizada com sucesso.";
  String failedMessage =
      "Você não possui pontos suficientes para comprar esse item.";
  // Se o item não foi comprado e a compra deu sucesso...
  itensBloc.createItemOrder(item.id).then((onValue) {
    print("Sucesso!");
    // Atualize os dados do usuário
    itensBloc.updateUser();

    // Exiba a SnackBar informando o sucesso da compra
    return _customSnackBar(context, successMessage);
  }).catchError((onError) {
    print("NAM!");
    // Caso contrário, retorne a SnackBar com o erro ocorrido
    return _customSnackBar(context, failedMessage);
  });
}

void _customSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Icon(Icons.error),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue,
    ),
  );
}
