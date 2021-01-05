import 'package:museu_vivo/app/shared/models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> getUser();
  Future login(String email, String password);
  Future registerUser(
      String name, String institution, String email, String password);
  logout();
}
