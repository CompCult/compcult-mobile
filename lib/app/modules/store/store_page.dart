import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/models/item.dart';
import 'package:museu_vivo/app/modules/store/store_page_bloc.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  
  @override
  Widget build(BuildContext context) {

    final ItensBloc itensBloc = BlocProvider.getBloc<ItensBloc>();

    return Scaffold(
      appBar: AppBar(title: Text("Loja")),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder(
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
                    return _buildList(snapshot.data);
                  },
                ),
          ],
        ),
      )
    );
  }

  _buildList(List<Item> itens) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itens.length,
      itemBuilder: (_, i) {
        final item = itens[i];

        return Container(
          child: Text(item.title),
        );
      },
    );
  }
}
