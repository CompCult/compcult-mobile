import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';
import 'package:museu_vivo/app/shared/widgets/custom_loading.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    disposer = autorun((_) {
      final auth = Modular.get<AuthController>();

      if (auth.status == AuthStatus.login) {
        Modular.to.pushReplacementNamed('/home');
      } else if (auth.status == AuthStatus.logoff) {
        Modular.to.pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoading();
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
