import 'package:hive/hive.dart';
import 'package:museu_vivo/app/shared/models/user_modal.dart';

abstract class ILocalStorage {
  Future<UserModel> get(String key);
  Future put(String key, UserModel value);
  Future delete(String key);
  Future close();
  Box getBox(String key);
}
