import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:museu_vivo/app/shared/models/user_modal.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_interface.dart';
import 'package:museu_vivo/app/shared/services/user_service.dart';

import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final ILocalStorage _storage = Modular.get();
  final UserService _userService = Modular.get<UserService>();

  @override
  Future<UserModel> getUser() async {
    Map<String, dynamic> persistedUser = await _storage.get("user");

    if (persistedUser != null) {
      Response response = await _userService.fetchUser(persistedUser["_id"]);
      UserModel user = UserModel.fromJson(response.data);
      return user;
    } else {
      return null;
    }
  }

  @override
  Future login(String email, String password) async {
    Response response = await _userService.authenticate(email, password);
    final UserModel user = UserModel.fromJson(response.data);
    _storage.put("user", response.data);
    return user;
  }

  @override
  logout() async {
    await _storage.delete("user");
    await _storage.close();
  }
}
