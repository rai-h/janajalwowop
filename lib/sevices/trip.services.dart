import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/models/trip.model.dart';
import 'package:janajaldoot/models/tripOrder.model.dart';
import 'package:janajaldoot/ui/helping_widget/rating_dailog.dart';
import 'package:janajaldoot/ui/screens/main_widget.dart';
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
          Provider.of<AuthController>(context, listen: false)
              .changeTripOrderList(tripOrderList);
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

  static Future<String> getOrderOtp(
      BuildContext context,
      String tripId,
      String status,
      String orderId,
      String orderStatus,
      String mobile,
      String orderNo) async {
    String otp = '';
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.getOrderOTPBody(
            '118@$username',
            password ?? "",
            tripId,
            status,
            orderId,
            orderStatus,
            mobile,
            orderNo,
          ),
          context: context);

      if (data.isNotEmpty) {
        if (int.parse(data['S:Envelope']['S:Body']['ns2:getorderOTPResponse']
                        ['return']
                    .toString())
                .runtimeType ==
            int) {
          EasyLoading.showSuccess('Otp Sent');
          return data['S:Envelope']['S:Body']['ns2:getorderOTPResponse']
                  ['return']
              .toString();
        } else {
          EasyLoading.showToast('Oops!\nSomething Went Wrong');
          return '';
        }
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
        return '';
      }
    } catch (e) {
      print("object $e");
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
      return '';
    }
  }

  static Future<void> updateOrderStatus(
      BuildContext context,
      String tripId,
      String status,
      String orderId,
      String orderStatus,
      String mobile,
      String orderNo,
      String otp) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.updateOrderStatusBody(
            '118@$username',
            password ?? "",
            tripId,
            status,
            orderId,
            orderStatus,
            mobile,
            orderNo,
            otp,
          ),
          context: context);
      print(data);
      if (data.isNotEmpty) {
        if (data['S:Envelope']['S:Body']['ns2:updateOrderStatusResponse']
                    ['return']
                .toString() ==
            '1') {
          EasyLoading.showSuccess('Order Updated');
          await showRatingDialog(context, orderId);
          await TripServices.getTripOrderList(context, tripId, "10", "0");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainWidget(),
              ),
              (route) => false);
        } else {
          EasyLoading.showToast('Oops!\nSomething Went Wrong');
        }
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
      }
    } catch (e) {
      print("object $e");
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
    }
  }

  static Future<void> uploadTripStartImage(
    BuildContext context,
    String tripId,
    String value,
    String deliveredPersonName,
    String customerSignature,
  ) async {
    List<TripOrderModel> tripOrderList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.uploadTripStartImageBody(
            '118@$username',
            password ?? "",
            tripId,
            value,
            deliveredPersonName,
            customerSignature,
          ),
          context: context);

      if (data.isNotEmpty) {
        if (data['S:Envelope']['S:Body']['ns2:uploadTripImageResponse']
                    ['return']
                .toString() ==
            '1') {
          EasyLoading.showSuccess("Image Uploaded");
          Future.delayed(Duration(seconds: 1));
          await TripServices.getTripOrderList(
            context,
            tripId,
            '10',
            '0',
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainWidget(),
          ));
        } else {
          EasyLoading.showToast('Oops!\nSomething Went Wrong');
        }
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
      }
    } catch (e) {
      print("object $e");
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
    }
  }

  static Future<void> updateTripEndStatus(
    BuildContext context,
    String tripId,
    String tripEndKm,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.updateTripEndStatusBody(
            '118@$username',
            password ?? "",
            tripId,
            tripEndKm,
          ),
          context: context);

      if (data.isNotEmpty) {
        if (data['S:Envelope']['S:Body']['ns2:updateTripStatusResponse']
                    ['return']
                .toString() ==
            '1') {
          EasyLoading.showSuccess("Trip completed Successfully");
          await Future.delayed(Duration(seconds: 1));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainWidget(),
              ),
              (route) => false);
        } else {
          EasyLoading.showToast('Oops!\nSomething Went Wrong');
        }
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
      }
    } catch (e) {
      print("object $e");
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
    }
  }

  static Future<void> saveOrderRating(
    BuildContext context,
    String orderId,
    String ratingLevel,
    String remarks,
    String personType,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.saveRatings('118@$username', password!, orderId,
              ratingLevel, remarks, personType),
          context: context);
      print(data);
      String result = data['S:Envelope']['S:Body']['ns2:saveRatingsResponse']
              ['return']
          .toString();
      if (result == '1') {
        Navigator.of(context).pop();
        EasyLoading.showToast("Saved");
      }
    } catch (e) {
      print(e);
    }
  }
}
