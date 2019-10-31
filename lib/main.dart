import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/team_details.dart';
import 'package:museu_vivo/pages/quiz_submit.dart';
import 'package:museu_vivo/pages/teams_page.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/games_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/mission_submit.dart';
import 'pages/splash_page.dart';
import 'shared/providers/user_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Dio dio = Dio(
    BaseOptions(baseUrl: 'https://museu-vivo-api.herokuapp.com'),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(
          value: UserProvider(),
        ),
        Provider<Dio>.value(
          value: dio,
        ),
      ],
      child: MaterialApp(
        title: 'Meu Vivo Museu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.red,
          accentColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          buttonTheme: ButtonThemeData(minWidth: 10),
          textTheme: TextTheme(
            button: TextStyle(fontSize: 10),
          ),
        ),
        home: SplashPage(),
        routes: {
          SignInPage.routeName: (_) => SignInPage(),
          GamesPage.routeName: (_) => GamesPage(),
          HomePage.routeName: (_) => HomePage(),
          TeamsPage.routeName: (_) => TeamsPage(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
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
    );
  }
}
