import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:museu_vivo/minigames/memory-game/pages/memory_game/memory_game_module.dart';
import 'package:museu_vivo/pages/bloc/coins_bloc.dart';
import 'package:museu_vivo/pages/bloc/home_bloc.dart';
import 'package:museu_vivo/pages/bloc/mission_submit_bloc.dart';
import 'package:museu_vivo/pages/bloc/missions_bloc.dart';
import 'package:museu_vivo/pages/bloc/quiz_submit_bloc.dart';
import 'package:museu_vivo/pages/bloc/quizzes_bloc.dart';
import 'package:museu_vivo/pages/bloc/ranking_bloc.dart';
import 'package:museu_vivo/pages/bloc/sign_in_bloc.dart';
import 'package:museu_vivo/pages/bloc/sign_up_bloc.dart';
import 'package:museu_vivo/pages/bloc/teams_bloc.dart';
import 'package:museu_vivo/pages/bloc/user_bloc.dart';
import 'package:museu_vivo/pages/team_details.dart';
import 'package:museu_vivo/pages/quiz_submit.dart';
import 'package:museu_vivo/pages/teams_page.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/dio_repository.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';
import 'package:museu_vivo/shared/repositories/quiz_repository.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:museu_vivo/shared/services/mission_service.dart';
import 'package:museu_vivo/shared/services/quiz_service.dart';
import 'package:museu_vivo/shared/services/user_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/games_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/mission_submit.dart';
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
                  )),
              Bloc((i) => RankingBloc(i.get<UserRepository>())),
              Bloc((i) => SignUpBloc(i.get<UserRepository>())),
              Bloc((i) => UserBloc(i.get<UserRepository>())),
              Bloc((i) => SignInBloc(i.get<UserRepository>())),
              Bloc((i) => CoinsBloc(i.get<UserRepository>())),
              Bloc((i) => QuizzesBloc(i.get<QuizRepository>())),
              Bloc((i) => QuizSubmitBloc(i.get<QuizRepository>())),
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
