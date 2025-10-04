import 'dart:convert';

import 'package:bookia/features/auth/data/models/response/auth_response/user.dart';
import 'package:bookia/features/home/data/models/books_list_response/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static late SharedPreferences pref;

  static String kUserData = 'user_data';
  static String kToken = 'token';
  static String kWishlist = 'wishlist';

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static setUserData(User? userData) async {
    if (userData == null) return;
    //1) parse object to Json (Map)
    var objectJson = userData.toJson();

    //2) encode to string using (JsonEncode)
    var userDataString = jsonEncode(objectJson);

    //3)  save to shared preferences
    await pref.setString(kUserData, userDataString);
  }

  static User? getUserData() {
    // 1) get string from shared preferences
    var source = pref.getString(kUserData);
    if (source == null) return null;

    // 2) decode string to Json
    var jsonData = jsonDecode(source);

    // 3) parse Json to object
    return User.fromJson(jsonData);
  }

  static setToken(String? token) async {
    if (token == null) return;
    await pref.setString(kToken, token);
  }

  static String? getToken() {
    return pref.getString(kToken);
  }

  static setWishlist(List<Product>? books) async {
    if (books == null) return;

    var listOfString = books.map((e) => jsonEncode(e.toJson())).toList();
    await pref.setStringList(kWishlist, listOfString);
  }

  static List<Product>? getWishlist() {
    var source = pref.getStringList(kWishlist);
    if (source == null) return null;
    var listOfObj = source.map((e) => Product.fromJson(jsonDecode(e))).toList();
    return listOfObj;
  }

  static String? getString(String key) {
    return pref.getString(key);
  }

  static Future<bool> setString(String key, String value) {
    return pref.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) {
    return pref.setBool(key, value);
  }

  static bool? getBool(String key) {
    return pref.getBool(key);
  }

  static Future<bool> setInt(String key, int value) {
    return pref.setInt(key, value);
  }

  static int? getInt(String key) {
    return pref.getInt(key);
  }

  static Future<bool> setDouble(String key, double value) {
    return pref.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return pref.getDouble(key);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return pref.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return pref.getStringList(key);
  }

  static Future<bool> clear() {
    return pref.clear();
  }

  static Future<bool> remove(String key) {
    return pref.remove(key);
  }
}
