import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/app_controller.dart';
import 'package:museu_vivo/app/app_widget.dart';
import 'package:museu_vivo/app/modules/activities/activities_module.dart';
import 'package:museu_vivo/app/modules/initial/initial_module.dart';
import 'package:museu_vivo/app/modules/login/login_module.dart';
import 'package:museu_vivo/app/modules/sign_up/sign_up_module.dart';
import 'package:museu_vivo/app/screens/splash/splash_screen.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';
import 'package:museu_vivo/app/shared/auth/auth_repository.dart';
import 'package:museu_vivo/app/shared/auth/auth_repository_interface.dart';
import 'package:museu_vivo/app/shared/loading/loading_controller.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_hive.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_interface.dart';
import 'package:museu_vivo/app/shared/services/mission_service.dart';
import 'package:museu_vivo/app/shared/services/quiz_service.dart';
import 'package:museu_vivo/app/shared/services/user_service.dart';
import 'package:museu_vivo/app/shared/utils/providers/custom_dio.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        // Database offline
        Bind<ILocalStorage>((i) => LocalStorageHive()),
        Bind<IAuthRepository>((i) => AuthRepository()),
        // Auth
        Bind((i) => AuthController()),
        // HTTP Provider
        Bind((i) => Dio()),
        Bind((i) => CustomDio(i.get<Dio>())),
        // Services
        Bind((i) => UserService(i.get<CustomDio>())),
        Bind((i) => MissionService(i.get<CustomDio>())),
        Bind((i) => QuizService(i.get<CustomDio>())),
        // Global Loading
        Bind((i) => LoadingController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashScreen()),
        ModularRouter('/login',
            module: LoginModule(), transition: TransitionType.noTransition),
        ModularRouter('/initial', module: InitialModule()),
        ModularRouter('/activities', module: ActivitiesModule()),
        ModularRouter('/register', module: SignUpModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
