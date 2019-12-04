import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';

class RankingBloc extends BlocBase {
  final UserRepository _userRepository;

  RankingBloc(this._userRepository);

  Future<List<User>> fetchUsers() => _userRepository.fetchUsers();
}
