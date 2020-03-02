import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class CoinsBloc extends BlocBase {
  final UserRepository _userRepository;

  CoinsBloc(this._userRepository);

  Observable<User> get user => _userRepository.user;

  updateUser() => _userRepository.updateUser();
}
