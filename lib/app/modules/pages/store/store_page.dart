import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/modules/pages/store/components/item_store.dart';
import 'package:museu_vivo/app/modules/pages/store/store_bloc.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final StoreBloc storeBloc = BlocProvider.getBloc<StoreBloc>();

  @override
  void initState() {
    super.initState();
    storeBloc.updateUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: storeBloc.itens,
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
            return Center(
              child: Text("Nenhuma obra para exibir!"),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (_, i) {
              final item = snapshot.data[i];
              return ItemStore(item: item);
            },
          );
        },
      ),
    );
  }
}
