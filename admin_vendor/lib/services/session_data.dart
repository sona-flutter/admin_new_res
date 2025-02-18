import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;
  static String? uid;

  static setSessionData({required bool setLogin}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isLogin", setLogin);
  }

  static getSessionData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isLogin = pref.getBool("isLogin") ?? false;
  }

  static setUid({required String setUid}) async {
    log("set uid $setUid");
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("uid", setUid);
  }

  static getUid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    uid = pref.getString("uid");
    log("Get Uid$uid");
  }
}
