import 'package:dio/dio.dart';
import 'package:museu_vivo/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/app/app_widget.dart';
import 'package:museu_vivo/app/modules/home/home_module.dart';
import 'package:museu_vivo/app/modules/login/login_module.dart';
import 'package:museu_vivo/app/screens/splash/splash_screen.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_hive.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_interface.dart';
import 'package:museu_vivo/app/shared/services/mission_service.dart';
import 'package:museu_vivo/app/shared/services/quiz_service.dart';
import 'package:museu_vivo/app/shared/services/user_service.dart';
import 'package:museu_vivo/app/shared/utils/providers/dio_provider.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind<ILocalStorage>((i) => LocalStorageHive()),
        Bind((i) => DioProvider()),
        Bind((i) => UserService(i.get<DioProvider>().dio)),
        Bind((i) => MissionService(i.get<DioProvider>().dio)),
        Bind((i) => QuizService(i.get<DioProvider>().dio)),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SplashScreen()),
        Router('/login',
            module: LoginModule(), transition: TransitionType.noTransition),
        Router('/home', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
