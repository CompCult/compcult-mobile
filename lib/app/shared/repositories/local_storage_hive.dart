import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'local_storage_interface.dart';

class LocalStorageHive implements ILocalStorage {
  // Abre uma Future
  Completer<Box> _instance = Completer<Box>();

  _init() async {
    Directory dir = await getApplicationDocumentsDirectory();
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
  Future<Map<String, dynamic>> get(String key) async {
    var box = await _instance.future;
    var persisted = box.get(key);
    if (persisted != null) {
      var result = Map<String, dynamic>.from(persisted);
      return result;
    } else {
      return persisted;
    }
  }

  @override
  Future put(String key, Map<String, dynamic> value) async {
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
