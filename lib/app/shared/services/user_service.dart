import 'package:dio/dio.dart';
import 'package:museu_vivo/app/shared/utils/providers/custom_dio.dart';

class UserService {
  final CustomDio dio;

  UserService(this.dio);

  Future<Response> fetchUser(String userId) {
    return dio.client.get('/users/$userId');
  }

  Future<Response> fetchUsers() {
    return dio.client.get('/users');
  }

  Future<Response> authenticate(String email, String password) async {
    final Response response = await dio.client.post('/users/auth', data: {
      'email': email,
      'password': password,
    });

    return response;
  }

  Future<Response> createUser(
      {String name, String institution, String email, String password}) async {
    final response = await dio.client.post('/users/register', data: {
      'name': name,
      'type': 'estudante',
      'institution': institution,
      'email': email,
      'password': password,
    });

    return response;
  }
}
