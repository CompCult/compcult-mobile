import 'package:dio/dio.dart';

class UserService {
  final Dio dio;

  UserService(this.dio);

  Future<dynamic> authenticate(String email, String password) async {
    final Response response = await dio.post('/users/auth', data: {
      'email': email,
      'password': password,
    });

    return response.data;
  }

  Future<void> createUser(
      {String name, String institution, String email, String password}) async {
    await dio.post('/users/register', data: {
      'name': name,
      'type': 'estudante',
      'institution': institution,
      'email': email,
      'password': password,
    });
  }
}
