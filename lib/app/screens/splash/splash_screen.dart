import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';
import 'package:museu_vivo/app/shared/models/user_modal.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_hive.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_interface.dart';
import 'package:museu_vivo/app/shared/utils/providers/dio_provider.dart';
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
    return Scaffold(
      body: Center(
        child: CustomLoading(),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
