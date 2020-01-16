import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class TeamsBloc extends BlocBase {
  final UserRepository userRepository;

  TeamsBloc(this.userRepository);

  Observable<User> get user => userRepository.user;
}
