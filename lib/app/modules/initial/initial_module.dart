import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/activities/activities_controller.dart';
import 'package:museu_vivo/app/modules/activities/activities_page.dart';
import 'package:museu_vivo/app/modules/home/home_controller.dart';
import 'package:museu_vivo/app/modules/home/home_page.dart';
import 'package:museu_vivo/app/modules/profile/profile_controller.dart';
import 'package:museu_vivo/app/modules/profile/profile_page.dart';
import 'package:museu_vivo/app/modules/store/store_controller.dart';
import 'package:museu_vivo/app/modules/store/store_page.dart';

import 'initial_controller.dart';
import 'initial_page.dart';

class InitialModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => InitialController()),
        Bind((i) => HomeController()),
        Bind((i) => ActivitiesController()),
        Bind((i) => StoreController()),
        Bind((i) => ProfileController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => InitialPage()),
        ModularRouter("/home", child: (_, args) => HomePage()),
        ModularRouter("/activities", child: (_, args) => ActivitiesPage()),
        ModularRouter("/store", child: (_, args) => StorePage()),
        ModularRouter("/profile", child: (_, args) => ProfilePage()),
      ];

  static Inject get to => Inject<InitialModule>.of();
}
