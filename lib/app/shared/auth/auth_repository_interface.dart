import 'package:museu_vivo/app/shared/models/user_modal.dart';

abstract class IAuthRepository {
  Future<UserModel> getUser();
  Future login(String email, String password);
  logout();
}
