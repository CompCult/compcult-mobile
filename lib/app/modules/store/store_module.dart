import 'package:museu_vivo/app/modules/store/store_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/store/store_page.dart';

class StoreModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => StoreController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => StorePage()),
      ];

  static Inject get to => Inject<StoreModule>.of();
}
