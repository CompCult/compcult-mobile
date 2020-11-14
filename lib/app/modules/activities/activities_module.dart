import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/modules/activities/controllers/games_controller.dart';
import 'package:museu_vivo/app/modules/activities/controllers/mission_controller.dart';
import 'package:museu_vivo/app/modules/activities/controllers/quiz_controller.dart';
import 'package:museu_vivo/app/modules/activities/screens/games_page.dart';
import 'package:museu_vivo/app/modules/activities/screens/mission_page.dart';
import 'package:museu_vivo/app/modules/activities/screens/quiz_page.dart';

import 'activities_controller.dart';
import 'activities_page.dart';

class ActivitiesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ActivitiesController()),
        Bind((i) => GamesController()),
        Bind((i) => QuizController()),
        Bind((i) => MissionController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ActivitiesPage()),
        ModularRouter("/quizzes", child: (_, args) => QuizPage()),
        ModularRouter("/missions", child: (_, args) => MissionPage()),
        ModularRouter("/games", child: (_, args) => GamesPage()),
      ];

  static Inject get to => Inject<ActivitiesModule>.of();
}
