import 'package:flutter/material.dart';
import 'package:museu_vivo/pages/quiz_submit.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/mission_submit.dart';
import 'pages/splash_page.dart';
import 'shared/providers/user_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Raíz da aplicação.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(
          value: UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Meu Vivo Museu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          buttonTheme: ButtonThemeData(minWidth: 10),
          textTheme: TextTheme(
            button: TextStyle(fontSize: 10),
          ),
        ),
        home: SplashPage(),
        routes: {
          SignInPage.routeName: (_) => SignInPage(),
          MainPage.routeName: (_) => MainPage(),
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
            default:
              return null;
          }
        },
      ),
    );
  }
}
