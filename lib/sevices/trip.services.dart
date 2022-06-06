import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/models/trip.model.dart';
import 'package:janajaldoot/models/tripOrder.model.dart';
import 'package:janajaldoot/utils/api_body.dart';
import 'package:janajaldoot/utils/api_calls.dart';
import 'package:provider/provider.dart';

class TripServices {
  static Future<List<TripModel>> getWOWTripList(BuildContext context) async {
    print("object");
    List<TripModel> tripList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.getTripList('118@$username', password ?? ""),
          context: context);

      if (data.isNotEmpty) {
        if (data['S:Envelope']['S:Body']['ns2:getWOWTripListResponse']['return']
            .toString()
            .isNotEmpty) {
          List respData = jsonDecode(data['S:Envelope']['S:Body']
                  ['ns2:getWOWTripListResponse']['return']
              .toString());

          respData.forEach(((element) {
            tripList.add(TripModel.fromJson(element));
          }));
          return tripList;
        } else {
          EasyLoading.showToast('Oops!\nSomething Went Wrong');
          return tripList;
        }
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
        return tripList;
      }
    } catch (e) {
      print("object $e");
      return tripList;
    }
  }

  static Future<List<TripOrderModel>> getTripOrderList(
    BuildContext context,
    String tripId,
    String status,
    String tripStartKm,
  ) async {
    List<TripOrderModel> tripOrderList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.getTripOrderList(
            '118@$username',
            password ?? "",
            tripId,
            status,
            tripStartKm,
          ),
          context: context);

      if (data.isNotEmpty) {
        if (data['S:Envelope']['S:Body']['ns2:getWOWTripOrderListResponse']
                ['return']
            .toString()
            .isNotEmpty) {
          List respData = jsonDecode(data['S:Envelope']['S:Body']
                  ['ns2:getWOWTripOrderListResponse']['return']
              .toString());

          respData.forEach(((element) {
            tripOrderList.add(TripOrderModel.fromJson(element));
          }));
          return tripOrderList;
        } else {
          EasyLoading.showToast('Oops!\nSomething Went Wrong');
          return tripOrderList;
        }
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
        return tripOrderList;
      }
    } catch (e) {
      print("object $e");
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
      return tripOrderList;
    }
  }
}
