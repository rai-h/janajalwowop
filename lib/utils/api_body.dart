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

  static String getTripOrderList(
    String userName,
    String password,
    String tripId,
    String status,
    String tripStartKm,
  ) {
    String body = '<soapenv:Body>'
        '<web:getWOWTripOrderList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<tripId>$tripId</tripId>'
        '<status>$status</status>'
        '<tripStartKm>$tripStartKm</tripStartKm>'
        '</web:getWOWTripOrderList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getOrderOTPBody(
      String userName,
      String password,
      String tripId,
      String status,
      String orderId,
      String orderStatus,
      String mobile,
      String orderNo) {
    String body = '<soapenv:Body>'
        '<web:getorderOTP>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<tripId>$tripId</tripId>'
        '<status>$status</status>'
        '<orderId>$orderId</orderId>'
        '<orderStatus>$orderStatus</orderStatus>'
        '<custMobile>$mobile</custMobile>'
        '<orderNo>$orderNo</orderNo>'
        '</web:getorderOTP>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String updateOrderStatusBody(
      String userName,
      String password,
      String tripId,
      String status,
      String orderId,
      String orderStatus,
      String mobile,
      String orderNo,
      String otp) {
    String body = '<soapenv:Body>'
        '<web:updateOrderStatus>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<tripId>$tripId</tripId>'
        '<status>$status</status>'
        '<orderId>$orderId</orderId>'
        '<orderStatus>$orderStatus</orderStatus>'
        '<custMobile>$mobile</custMobile>'
        '<orderNo>$orderNo</orderNo>'
        '<orderNo>$orderNo</orderNo>'
        '<OTP>$otp</OTP>'
        '</web:updateOrderStatus>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String uploadTripStartImageBody(
    String userName,
    String password,
    String tripId,
    String value,
    String deliveredPersonName,
    String customerSignature,
  ) {
    String body = '<soapenv:Body>'
        '<web:uploadTripImage>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<tripId>$tripId</tripId>'
        '<value>$value</value>'
        '<deliveredPersonName>$deliveredPersonName</deliveredPersonName>'
        '<CustomerSignature>$customerSignature</CustomerSignature>'
        '</web:uploadTripImage>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String updateTripEndStatusBody(
    String userName,
    String password,
    String tripId,
    String tripEndKm,
  ) {
    String body = '<soapenv:Body>'
        '<web:updateTripStatus>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<tripId>$tripId</tripId>'
        '<tripEndKm>$tripEndKm</tripEndKm>'
        '</web:updateTripStatus>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String saveRatings(
    String userName,
    String password,
    String orderId,
    String ratingLevel,
    String remarks,
    String personType,
  ) {
    String body = '<soapenv:Body>'
        '<web:saveRatings>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<orderId>$orderId</orderId>'
        '<ratingLevel>$ratingLevel</ratingLevel>'
        '<remarks>$remarks</remarks>'
        '<personType>$personType</personType>'
        '</web:saveRatings>'
        '</soapenv:Body>';
    print(body);
    return topHeader + body + closeEnvelope;
  }

  static String getWowSalesReportBody(
    String userName,
    String password,
    String startDate,
    String endDate,
    String vehicleNo,
  ) {
    String body = '<soapenv:Body>'
        '<web:getWowSalesData>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<startDate>$startDate</startDate>'
        '<endDate>$endDate</endDate>'
        '<startTimeHr>00</startTimeHr>'
        '<startTimeSec>00</startTimeSec>'
        '<endTimeHr>00</endTimeHr>'
        '<endTimeSec>00</endTimeSec>'
        '<clusterId>14</clusterId>'
        '<vehicleNo>$vehicleNo</vehicleNo>'
        '</web:getWowSalesData>'
        '</soapenv:Body>';

    print(body);
    return topHeader + body + closeEnvelope;
  }
}

// updateTripStatus{userName=118@wowoperator; password=121212; tripId=80; tripId=80; tripEndKm=123456; tripEndKm=123456; }