import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_interface.dart';

import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final ILocalStorage _storage = Modular.get();

  @override
  getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  login() {
  }

  @override
  logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
