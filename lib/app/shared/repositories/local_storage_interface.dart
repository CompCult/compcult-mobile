import 'package:hive/hive.dart';

abstract class ILocalStorage {
  Future<Map<String, dynamic>> get(String key);
  Future put(String key, Map<String, dynamic> value);
  Future delete(String key);
  Future close();
  Box getBox(String key);
}
