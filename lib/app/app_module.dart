import 'package:museu_vivo/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/app_widget.dart';
import 'package:museu_vivo/app/modules/home/home_module.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_hive.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_interface.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind<ILocalStorage>((i) => LocalStorageHive()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
