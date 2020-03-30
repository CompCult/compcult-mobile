import 'package:bloc_pattern/bloc_pattern.dart';
import "package:flutter/material.dart";
import 'package:museu_vivo/app/modules/shared/components/list_items_store.dart';
import 'package:museu_vivo/app/modules/store/store_page_bloc.dart';

class MyItems extends StatefulWidget {
  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  final ItemsBloc itensBloc = BlocProvider.getBloc<ItemsBloc>();

  @override
  void initState() {
    print("ENTROU NOS MEUS ITENS!");
    itensBloc.updateUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: listItemsStore(context, itensBloc, true),
    );
  }
}
