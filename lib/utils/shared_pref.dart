import 'package:flutter/cupertino.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/utils/janajal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static getPrefInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<Null> updateUserInSharedPrefs(
      String username, String password) async {
    final SharedPreferences prefs = await getPrefInstance();
    prefs.setBool('isAuth', true);
    prefs.setString(Janajal.password, password);
    prefs.setString(Janajal.username, username);
  }

  static Future<bool> getUserInSharedPrefs(BuildContext context) async {
    final SharedPreferences prefs = await getPrefInstance();

    String? prefPassword = await prefs.getString(Janajal.password);
    String? prefUsername = await prefs.getString(Janajal.username);
    if (prefUsername != null && prefPassword != null) {
      Provider.of<AuthController>(context, listen: false)
          .changeUserNamePass(prefUsername, prefPassword);

      return true;
    }
    return false;
  }

  static Future<Null> removeUserFromSharedPrefs() async {
    final SharedPreferences prefs = await getPrefInstance();
    prefs.clear();
  }
}
