import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  String? _username;
  String? get getUserName => _username;

  String? _password;
  String? get getPassword => _password;

  changeUserNamePass(String username, String password) {
    _username = username;
    _password = password;
    notifyListeners();
  }

  String? _remainingWater;
  String? _pH;
  String? _tds;

  String? get getRemainingWater => _remainingWater;
  String? get getPH => _pH;
  String? get getTds => _tds;

  changeWowStatus(String remainingWater, String pH, String tds) {
    _remainingWater = remainingWater;
    _pH = pH;
    _tds = tds;
    notifyListeners();
  }

  String? _wowId;

  String? get getWowId => _wowId;

  changeWowId(String? wowId) {
    _wowId = wowId;
    notifyListeners();
  }
}
