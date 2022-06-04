import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/ui/helping_widget/custom_loading.dart';
import 'package:janajaldoot/utils/apis.dart';
import 'package:xml2json/xml2json.dart';

import 'package:http/http.dart' as http;

class ApiCalls {
  static Xml2Json xml2json = new Xml2Json();
  static Future<dynamic> postCall({
    required String methodName,
    required String body,
    required BuildContext context,
  }) async {
    Map<String, String> headerData = new Map();
    Map<String, dynamic> responseData = {};
    String url = Apis.baseURL;
    headerData.putIfAbsent("Content-Type", () => "text/xml; charset=utf-8");
    headerData.putIfAbsent("SOAPAction", () => methodName);
    headerData.putIfAbsent("Host", () => "www.janajal.com");
    CustomLoading.showLoading();
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: headerData);
      print('response Body---> ${response.body}');
      print('response StatusCode---> ${response.statusCode}');
      if (response.statusCode == 200) {
        xml2json.parse(response.body);
        String jsonData = xml2json.toParker();
        responseData = json.decode(jsonData);
      }
      CustomLoading.removeLoading();
      return responseData;
    } catch (e) {
      CustomLoading.removeLoading();
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
      print("apiPostCall : $methodName has Error\n $e \n");
    }
    CustomLoading.removeLoading();
    return responseData;
  }
}
