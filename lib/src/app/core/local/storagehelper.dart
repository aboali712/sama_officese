


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



mixin StorageHelper {
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.user_token.toString(), token);
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ln = prefs.getString(CacheManagerKey.user_token.toString());
    return ln;
  }

  Future<bool> setFirst(bool first) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(CacheManagerKey.isFirst.toString(), first);
    return true;
  }

  Future<bool> getFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(CacheManagerKey.isFirst.toString())??true;
  }

  Future<bool> saveLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.lang.toString(), lang);
    return true;
  }

  Future<String?> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ln = prefs.getString(CacheManagerKey.lang.toString());
    ln ??= "ar";
    return ln;
  }
  // Future<bool> saveUser(UserData? customer) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String user = jsonEncode(customer);
  //   pref.setString(CacheManagerKey.user.toString(), user);
  //   return true;
  // }

  // Future<UserData?> getUser() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.getString(CacheManagerKey.user.toString()) != null &&
  //       pref.getString(CacheManagerKey.user.toString()) != "null") {
  //     print(pref.getString(CacheManagerKey.user.toString()));
  //     Map<String, dynamic> jsonDatais =
  //     jsonDecode(pref.getString(CacheManagerKey.user.toString())!);
  //     var user = UserData.fromJson(jsonDatais);
  //     return user;
  //   }
  //   return null;
  // }


}

enum CacheManagerKey { user_token, isFirst, lang, currency, user,home, fave,cart,userApple,tokenDevice }
