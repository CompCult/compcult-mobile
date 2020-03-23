import 'package:dio/dio.dart';

class ItemService {
  final Dio dio;

  ItemService(this.dio);

  Future<Response> fetchPurchasedItens(String userId) {
    return dio.get('/store/items?purchased=1');
  }
  
  Future<Response> fetchItens(String userId) {
    return dio.get('/store/items?purchased=0');
  }
}
