import 'package:dio/dio.dart';
import 'package:museu_vivo/app/shared/utils/providers/custom_interceptor.dart';
import 'package:museu_vivo/config.dart';

class CustomDio {
  final Dio client;

  CustomDio(this.client) {
    client.options.baseUrl = config.apiUrl;
    client.options.connectTimeout = 15000;
    client.interceptors.add(CustomInterceptor());
  }

  void addToken(String token) {
    client.options.headers["Authorization"] = "Bearer $token";
  }
}
