import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/models/item.dart';
import 'package:museu_vivo/app/modules/store/store_page_bloc.dart';

class ListItens extends StatefulWidget {
  @override
  _ListItensState createState() => _ListItensState();
}

class _ListItensState extends State<ListItens> {
  @override
  Widget build(BuildContext context) {
    final ItensBloc itensBloc = BlocProvider.getBloc<ItensBloc>();
    return StreamBuilder(
      stream: itensBloc.itens,
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
                  child: Text(
                    "O professor não cadastrou nenhum item.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        }
        return _buildListItens(snapshot.data, itensBloc);
      },
    );
  }

  _buildListItens(List<Item> itens, ItensBloc itensBloc) {
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
                                    Text('${item.value}',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        )),
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
                                    Text('${item.quantity}',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width:
                                  MediaQuery.of(context).size.width / 2 - 150),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            onPressed: () async {
                               await itensBloc.createItemOrder(item.id);
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
}
