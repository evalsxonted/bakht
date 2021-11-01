import 'package:bakht/core/error/exceptions.dart';
import 'package:hive/hive.dart';

abstract class PrefsLocalDatasource {
  Future<String> getFromPrefs(String key);
  Future<bool> setToPrefs(String key, String value);
}

class PrefsLocalDatasourceImpl implements PrefsLocalDatasource {
  @override
  Future<String> getFromPrefs(String key) async {
    String? fromHive;
    try {
      fromHive = (await Hive.openBox("prefs")).get(key);
    } catch (e) {
      throw UnknownException({
        "class": "PrefsLocalDatasourceImpl",
        "function": "getFromPrefs",
        "date": DateTime.now().toIso8601String(),
        "exception": e.toString()
      }.toString());
    }
    if (fromHive == null) {
      throw NotFoundException("prefs not found. key: " + key);
    } else {
      return fromHive;
    }
  }

  @override
  Future<bool> setToPrefs(String key, String value) async {
    try {
      (await Hive.openBox("prefs")).put(key, value);
      return true;
    } catch (e) {
      throw UnknownException({
        "class": "PrefsLocalDatasourceImpl",
        "function": "setToPrefs",
        "date": DateTime.now().toIso8601String(),
        "exception": e.toString()
      }.toString());
    }
  }
}
