import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/shared/components/list_items_store.dart';
import 'package:museu_vivo/app/modules/store/store_page_bloc.dart';

class ItemsStore extends StatefulWidget {
  @override
  _ItemsStoreState createState() => _ItemsStoreState();
}

class _ItemsStoreState extends State<ItemsStore> {
  final ItemsBloc itensBloc = BlocProvider.getBloc<ItemsBloc>();
  // bool _isLoading = false;

  @override
  void initState() {
    itensBloc.updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: listItemsStore(context, itensBloc, false),
    );
  }
}
