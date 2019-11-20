import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/providers/user_provider.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class SignUpBloc extends BlocBase {
  final UserRepository userRepository;

  SignUpBloc(this.userRepository);

  Future<User> createUser({
    String name,
    String institution,
    String email,
    String password,
  }) async =>
      await this.userRepository.createUser(
            name: name,
            institution: institution,
            email: email,
            password: password,
          );

  updateUserInfo(BuildContext context, User user) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    userProvider.updateUserId(user.id);
    userProvider.updateEmail(user.email);
    userProvider.updateName(user.name);
    userProvider.updateInstitution(user.instituition);
  }
}
