import 'dart:async';

import 'package:hive/hive.dart';
import 'package:museu_vivo/app/shared/models/user_modal.dart';
import 'package:path_provider/path_provider.dart';

import 'local_storage_interface.dart';

class LocalStorageHive implements ILocalStorage {
  // Abre uma Future
  Completer<Box> _instance = Completer<Box>();

  _init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox("db");
    // Quando a operação na linha acima for concluída
    // a Future da linha abaixo será executada.
    // OBS: Se a Future já tiver sido executada, chama ela mesmo.
    _instance.complete(box);
  }

  LocalStorageHive() {
    _init();
  }

  @override
  Future delete(String key) async {
    var box = await _instance.future;
    box.delete(key);
  }

  @override
  Future<UserModel> get(String key) async {
    var box = await _instance.future;
    return box.get(key);
  }

  @override
  Future put(String key, UserModel value) async {
    var box = await _instance.future;
    box.put(key, value);
  }

  Box getBox(String key) {
    var box = Hive.box(key);
    return box;
  }

  Future close() async {
    var box = await _instance.future;
    return box.close();
  }
}
