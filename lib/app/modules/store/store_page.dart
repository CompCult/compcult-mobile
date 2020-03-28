import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';
import 'package:museu_vivo/app/modules/shared/components/list_items_store.dart';
import 'package:museu_vivo/app/modules/store/store_page_bloc.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final ItensBloc itensBloc = BlocProvider.getBloc<ItensBloc>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: CustomAppBar(),
            bottom: TabBar(
              unselectedLabelColor: Colors.grey,

              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Loja",
                    style: TextStyle(
                        fontFamily: "Poppins", fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Meus itens",
                    style: TextStyle(
                        fontFamily: "Poppins", fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff00036c).withOpacity(0.2),
              Color(0xff00036c).withOpacity(0.4)
            ])),
            child: TabBarView(
              children: <Widget>[
                SingleChildScrollView(
                    child: listItemsStore(context, itensBloc, false)),
                SingleChildScrollView(
                    child: listItemsStore(context, itensBloc, true)),
              ],
            ),
          )),
    );
  }
}
