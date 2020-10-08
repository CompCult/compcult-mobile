import 'package:dio/dio.dart';

class UserService {
  final Dio _client;

  UserService(this._client);

  Future<Response> fetchUser(String userId) {
    return _client.get('/users/$userId');
  }

  Future<Response> fetchUsers() {
    return _client.get('/users');
  }

  Future<Response> authenticate(String email, String password) async {
    final Response response = await _client.post('/users/auth', data: {
      'email': email,
      'password': password,
    });

    return response;
  }

  Future<Response> createUser(
      {String name, String institution, String email, String password}) async {
    final response = await _client.post('/users/register', data: {
      'name': name,
      'type': 'estudante',
      'institution': institution,
      'email': email,
      'password': password,
    });

    return response;
  }
}
