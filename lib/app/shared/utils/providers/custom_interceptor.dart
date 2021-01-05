import 'package:dio/dio.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    print("REQUEST[${options.method}] => PATH: ${options.path} \n");
  }

  @override
  Future onResponse(Response response) {
    // HTTP STATUS CODE 200, 201...
    print("RESPONSE[STATUS: ${response.statusCode}]: ${response.data}"
        " => PATH: ${response.request.path} \n");

    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) {
    // Exception...
    print("ERROR[STATUS: ${error.response.statusCode}]: $error =>"
        " PATH: ${error.request.path} \n");
    return super.onError(error);
  }
}
