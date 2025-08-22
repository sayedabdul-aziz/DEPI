import 'package:hive_flutter/hive_flutter.dart';

class LocalHelper {
  static late Box _userBox;

  static String kName = 'name';
  static String kImage = 'image';
  static String kIsUpload = 'isUpload';

  static init() async {
    await Hive.openBox("user");
    _userBox = Hive.box('user');
  }

  static cacheData(String key, dynamic value) {
    _userBox.put(key, value);
  }

  static getData(String key) {
    return _userBox.get(key);
  }
}
