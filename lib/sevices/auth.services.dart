import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/ui/screens/main_widget.dart';
import 'package:janajaldoot/utils/api_body.dart';
import 'package:janajaldoot/utils/api_calls.dart';
import 'package:janajaldoot/utils/shared_pref.dart';
import 'package:provider/provider.dart';

class AuthServices {
  static authenticateUser(
      BuildContext context, String username, String password) async {
    Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: '',
        body: ApiBody.getAuthenticationBody('118@$username', password),
        context: context);
    if (data.isNotEmpty) {
      if (int.tryParse(data['S:Envelope']['S:Body']
                          ['ns2:authenticateUserResponse']['return']
                      .toString())
                  .runtimeType ==
              int
          ? true
          : false) {
        EasyLoading.showSuccess('Login Successful');
        await SharedPref.updateUserInSharedPrefs(username, password);
        Provider.of<AuthController>(context, listen: false)
            .changeUserNamePass(username, password);
        await getWOWdata(context, username, password);
      } else if (data['S:Envelope']['S:Body']['ns2:authenticateUserResponse']
              ['return'] ==
          'Invalid Credentials') {
        EasyLoading.showToast('Invalid Credentials');
      }
    } else {
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
    }
  }

  static getWOWdata(
      BuildContext context, String username, String password) async {
    String wowId = '';
    String pH = '';
    String remainingWater = '';
    String tds = '';
    Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: '',
        body: ApiBody.getWOWDetails('118@$username', password),
        context: context);
    if (data.isNotEmpty) {
      if (data['S:Envelope']['S:Body']['ns2:getWOWDataResponse']['return']
              .toString() !=
          0) {
        String dataString = data['S:Envelope']['S:Body']
                ['ns2:getWOWDataResponse']['return']
            .toString();
        wowId = dataString.split('-')[0];
        pH = dataString.split('-')[1];
        remainingWater = dataString.split('-')[3];
        tds = dataString.split('-')[2];
        Provider.of<AuthController>(context, listen: false).changeWowId(wowId);
        Provider.of<AuthController>(context, listen: false)
            .changeWowStatus(remainingWater, pH, tds);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainWidget(),
          ),
        );
      } else {
        EasyLoading.showToast('Oops!\nSomething Went Wrong');
      }
    } else {
      EasyLoading.showToast('Oops!\nSomething Went Wrong');
    }
  }

  static Future<void> logout() async {
    SharedPref.removeUserFromSharedPrefs();
  }
}
