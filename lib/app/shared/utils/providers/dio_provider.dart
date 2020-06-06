import 'package:dio/dio.dart';
import 'package:museu_vivo/config.dart';

class DioProvider {
  Dio _dio = Dio(
    BaseOptions(baseUrl: config.apiUrl),
  );

  Dio get dio => _dio;

  Dio addToken(String token) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) =>
              _requestInterceptor(options, token),
        ),
      );
  }

  dynamic _requestInterceptor(RequestOptions options, String token) async {
    options.headers.addAll({"Authorization": "Bearer $token"});
    return options;
  }
}
