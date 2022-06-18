import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/models/salesReport.model.dart';
import 'package:janajaldoot/ui/helping_widget/rating_dailog.dart';
import 'package:janajaldoot/utils/api_calls.dart';
import 'package:provider/provider.dart';

import '../utils/api_body.dart';

class WOWServices {
  static getWowSalesReport(
    BuildContext context,
    String wowId,
    String startDate,
    String endDate,
  ) async {
    List<SalesReportModel> salesReportModelList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.getWowSalesReportBody(
            '$username',
            password ?? "",
            startDate,
            endDate,
            wowId,
          ),
          context: context);
      print(data);

      if (data.isNotEmpty) {
        if (data['S:Envelope']['S:Body']['ns2:getWowSalesDataResponse']
                ['return']
            .toString()
            .isNotEmpty) {
          String stringData = data['S:Envelope']['S:Body']
                  ['ns2:getWowSalesDataResponse']['return']
              .toString();
          jsonDecode(stringData).forEach((element) {
            salesReportModelList.add(SalesReportModel.fromJson(element));
          });
          Provider.of<AuthController>(context, listen: false)
              .changeSalesReportList(salesReportModelList);
        } else {
          // EasyLoading.showToast('Oops!\nSomething Went Wrong');
        }
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
      }
    } catch (e) {
      print("object $e");
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
    }
  }

  static getTodaysCollection(
    BuildContext context,
    String wowId,
    String startDate,
    String endDate,
  ) async {
    List<SalesReportModel> salesReportModelList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: '',
          body: ApiBody.getWowSalesReportBody(
            '$username',
            password ?? "",
            startDate,
            endDate,
            wowId,
          ),
          context: context);
      print(data);

      if (data.isNotEmpty) {
        if (data['S:Envelope']['S:Body']['ns2:getWowSalesDataResponse']
                ['return']
            .toString()
            .isNotEmpty) {
          String stringData = data['S:Envelope']['S:Body']
                  ['ns2:getWowSalesDataResponse']['return']
              .toString();
          jsonDecode(stringData).forEach((element) {
            salesReportModelList.add(SalesReportModel.fromJson(element));
          });
          Provider.of<AuthController>(context, listen: false)
              .changeTodaysCollection(salesReportModelList[0].d1amt.toString());
        } else {
          // EasyLoading.showToast('Oops!\nSomething Went Wrong');
        }
      } else {
        print("object");
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
      }
    } catch (e) {
      print("object $e");
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
    }
  }
}
