import 'package:flutter/cupertino.dart';

class ApiBody {
  static String topHeader =
      '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"'
      ' xmlns:web="http://web.ws.batch.to.ets.com/">'
      '<soapenv:Header/>';

  static String closeEnvelope = '</soapenv:Envelope>';

  static String getAuthenticationBody(String userName, String password) {
    print(userName);
    print(password);
    String body = '<soapenv:Body>'
        '<web:authenticateUser>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:authenticateUser>'
        '</soapenv:Body>';
    print(body);
    return topHeader + body + closeEnvelope;
  }

  static String getWOWDetails(String userName, String password) {
    String body = '<soapenv:Body>'
        '<web:getWOWData>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:getWOWData>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getTripList(String userName, String password) {
    String body = '<soapenv:Body>'
        '<web:getWOWTripList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:getWOWTripList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }
}
