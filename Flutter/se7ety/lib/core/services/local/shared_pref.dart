import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static String kUserData = 'user_data';
  static String kToken = 'token';
  static String kWishlist = 'wishlist';

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static setToken(String? token) async {
    if (token == null) return;
    await pref.setString(kToken, token);
  }

  static String? getToken() {
    return pref.getString(kToken);
  }

  static setData(String key, dynamic value) {
    if (value is int) {
      pref.setInt(key, value);
    } else if (value is bool) {
      pref.setBool(key, value);
    } else if (value is String) {
      pref.setString(key, value);
    } else if (value is double) {
      pref.setDouble(key, value);
    } else if (value is List<String>) {
      pref.setStringList(key, value);
    }
  }

  static dynamic getData(String key) {
    return pref.get(key);
  }

  static Future<bool> clear() {
    return pref.clear();
  }

  static Future<bool> remove(String key) {
    return pref.remove(key);
  }
}
