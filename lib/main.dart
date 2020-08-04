import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:museu_vivo/app/modules/pages/store/store_bloc.dart';
import 'package:museu_vivo/app/modules/shared/repositories/item_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app/modules/minigames/memory-game/pages/memory_game/memory_game_module.dart';
import 'app/modules/pages/coins/coins_bloc.dart';
import 'app/modules/pages/games/games_page.dart';
import 'app/modules/pages/home/home_bloc.dart';
import 'app/modules/pages/home/home_page.dart';
import 'app/modules/pages/mission/missions_bloc.dart';
import 'app/modules/pages/mission_submit/mission_submit.dart';
import 'app/modules/pages/mission_submit/mission_submit_bloc.dart';
import 'app/modules/pages/quiz/quizzes_bloc.dart';
import 'app/modules/pages/quiz_submit/quiz_submit.dart';
import 'app/modules/pages/quiz_submit/quiz_submit_bloc.dart';
import 'app/modules/pages/ranking/ranking_bloc.dart';
import 'app/modules/pages/sign_in/sign_in_bloc.dart';
import 'app/modules/pages/sign_in/sign_in_page.dart';
import 'app/modules/pages/sign_up/sign_up_bloc.dart';
import 'app/modules/pages/teams/team_details.dart';
import 'app/modules/pages/teams/teams_bloc.dart';
import 'app/modules/pages/teams/teams_page.dart';
import 'app/modules/pages/user/user_bloc.dart';
import 'app/modules/shared/models/user.dart';
import 'app/modules/shared/repositories/dio_repository.dart';
import 'app/modules/shared/repositories/mission_repository.dart';
import 'app/modules/shared/repositories/quiz_repository.dart';
import 'app/modules/shared/repositories/user_repository.dart';
import 'app/modules/shared/services/item_service.dart';
import 'app/modules/shared/services/mission_service.dart';
import 'app/modules/shared/services/quiz_service.dart';
import 'app/modules/shared/services/user_service.dart';
import 'config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Dio dio = Dio(
    BaseOptions(baseUrl: config.apiUrl),
  );

  Future<Box> openBox() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    return await Hive.openBox('user');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: openBox(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final lastUser = snapshot.data.get(0);
          User user;
          final DioRepository dioRepository = DioRepository();

          if (lastUser != null) {
            user = User.fromJson(Map<String, dynamic>.from(lastUser));
            dioRepository.addToken(user.token);
          }

          return BlocProvider(
            blocs: [
              Bloc((i) => HomeBloc(
                    i.get<MissionRepository>(),
                    i.get<QuizRepository>(),
                    i.get<ItemRepository>(),
                  )),
              Bloc((i) => RankingBloc(i.get<UserRepository>())),
              Bloc((i) => SignUpBloc(i.get<UserRepository>())),
              Bloc((i) => UserBloc(i.get<UserRepository>())),
              Bloc((i) => SignInBloc(i.get<UserRepository>())),
              Bloc((i) => CoinsBloc(i.get<UserRepository>())),
              Bloc((i) => QuizzesBloc(i.get<QuizRepository>())),
              Bloc((i) => QuizSubmitBloc(i.get<QuizRepository>())),
              Bloc((i) => StoreBloc(
                    i.get<ItemRepository>(),
                    i.get<UserRepository>(),
                  )),
              Bloc((i) => MissionsBloc(i.get<MissionRepository>())),
              Bloc((i) => MissionSubmitBloc(
                  i.get<MissionRepository>(), i.get<UserRepository>())),
              Bloc((i) => TeamsBloc(i.get<UserRepository>())),
            ],
            dependencies: [
              Dependency((i) => QuizRepository(
                    i.get<QuizService>(),
                    i.get<UserRepository>(),
                  )),
              Dependency((i) => ItemRepository(
                    i.get<ItemService>(),
                    i.get<UserRepository>(),
                  )),
              Dependency((i) => MissionRepository(
                    i.get<MissionService>(),
                    i.get<UserRepository>(),
                  )),
              Dependency((i) => UserRepository(
                    i.get<UserService>(),
                    user,
                    snapshot.data,
                    i.get<DioRepository>(),
                  )),
              Dependency((i) => UserService(i.get<DioRepository>().dio)),
              Dependency((i) => QuizService(i.get<DioRepository>().dio)),
              Dependency((i) => MissionService(i.get<DioRepository>().dio)),
              Dependency((i) => ItemService(i.get<DioRepository>().dio)),
              Dependency((i) => dioRepository),
            ],
            child: MultiProvider(
              providers: [
                Provider<Dio>.value(
                  value: dio,
                ),
              ],
              child: MaterialApp(
                title: config.name,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Poppins',
                  primaryColor: Colors.white,
                  accentColor: config.accentColor,
                  scaffoldBackgroundColor: Colors.white,
                  buttonTheme: ButtonThemeData(minWidth: 10),
                  textTheme: TextTheme(
                    button: TextStyle(fontSize: 10),
                  ),
                ),
                home: user == null ? SignInPage() : HomePage(),
                routes: {
                  SignInPage.routeName: (_) => SignInPage(),
                  GamesPage.routeName: (_) => GamesPage(),
                  HomePage.routeName: (_) => HomePage(),
                  TeamsPage.routeName: (_) => TeamsPage(),
                },
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case MemoryGameModule.routeName:
                      return MaterialPageRoute(
                        builder: (_) => MemoryGameModule(settings.arguments),
                      );
                      break;
                    case MissionSubmit.routeName:
                      return MaterialPageRoute(
                        builder: (_) => MissionSubmit(settings.arguments),
                      );
                      break;
                    case QuizSubmit.routeName:
                      return MaterialPageRoute(
                        builder: (_) => QuizSubmit(settings.arguments),
                      );
                      break;
                    case TeamDetails.routeName:
                      return MaterialPageRoute(
                        builder: (_) => TeamDetails(settings.arguments),
                      );
                      break;
                    default:
                      return null;
                  }
                },
              ),
            ),
          );
        } else {
          return Container(color: Colors.white);
        }
      },
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
