import 'package:flutter/material.dart';
import 'package:janajaldoot/models/salesReport.model.dart';

import '../models/tripOrder.model.dart';

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

  List<TripOrderModel> _tripOrderList = [];
  List<TripOrderModel> get getTripTripOrderList => _tripOrderList;

  bool _isTripCompleted = false;
  bool _endTripFileStatus = false;

  bool get isTripCompleted => _isTripCompleted;
  bool get endTripFileStatus => _endTripFileStatus;

  changeTripOrderList(List<TripOrderModel> tripTripOrderList) {
    tripTripOrderList.forEach((element) {
      _isTripCompleted = element.orderStatus == '12' ? true : false;
      _endTripFileStatus = element.fileStatus == 1 ? true : false;
    });
    _tripOrderList = tripTripOrderList;
    notifyListeners();
  }

  List<SalesReportModel> _salesReportModelList = [];

  List<SalesReportModel> get getSalesReportModelList => _salesReportModelList;

  changeSalesReportList(List<SalesReportModel> salesReportModelList) {
    _salesReportModelList = salesReportModelList;
    notifyListeners();
  }

  String _todaysCollection = '0.0';

  String get getTodaysCollection => _todaysCollection;

  changeTodaysCollection(String todaysCollecTion) {
    _todaysCollection = todaysCollecTion;
    notifyListeners();
  }
}
