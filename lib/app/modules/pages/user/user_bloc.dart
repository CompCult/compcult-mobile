import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';

import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final UserRepository userRepository;

  UserBloc(this.userRepository);

  Observable<User> get user => userRepository.user;

  logout() => userRepository.logout();
}
