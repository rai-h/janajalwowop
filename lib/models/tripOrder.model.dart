class TripOrderModel {
  final String? tripCode;
  final String? quantity;
  final int? empId;
  final String? deliveryWindow;
  final String? googleCityName;
  final String? userName;
  final String? deliveryLocation;
  final String? customerName;
  final String? orderStatus;
  final String? customerMobile;
  final String? tripId;
  final String? statusId;
  final String? orderNo;
  final int? fileStatus;
  final String? deliveryPoint;
  final String? longtitude;
  final String? latitude;
  final int? desingId;
  final String? orderId;

  TripOrderModel({
    this.tripCode,
    this.quantity,
    this.empId,
    this.deliveryWindow,
    this.googleCityName,
    this.userName,
    this.deliveryLocation,
    this.customerName,
    this.orderStatus,
    this.customerMobile,
    this.tripId,
    this.statusId,
    this.orderNo,
    this.fileStatus,
    this.deliveryPoint,
    this.longtitude,
    this.latitude,
    this.desingId,
    this.orderId,
  });

  TripOrderModel.fromJson(Map<String, dynamic> json)
      : tripCode = json['TripCode'] as String?,
        quantity = json['Quantity'] as String?,
        empId = json['EmpId'] as int?,
        deliveryWindow = json['deliveryWindow'] as String?,
        googleCityName = json['GoogleCityName'] as String?,
        userName = json['UserName'] as String?,
        deliveryLocation = json['DeliveryLocation'] as String?,
        customerName = json['CustomerName'] as String?,
        orderStatus = json['orderStatus'] as String?,
        customerMobile = json['CustomerMobile'] as String?,
        tripId = json['TripId'] as String?,
        statusId = json['StatusId'] as String?,
        orderNo = json['OrderNo'] as String?,
        fileStatus = json['fileStatus'] as int?,
        deliveryPoint = json['deliveryPoint'] as String?,
        longtitude = json['longtitude'] as String?,
        latitude = json['latitude'] as String?,
        desingId = json['DesingId'] as int?,
        orderId = json['orderId'] as String?;

  Map<String, dynamic> toJson() => {
        'TripCode': tripCode,
        'Quantity': quantity,
        'EmpId': empId,
        'deliveryWindow': deliveryWindow,
        'GoogleCityName': googleCityName,
        'UserName': userName,
        'DeliveryLocation': deliveryLocation,
        'CustomerName': customerName,
        'orderStatus': orderStatus,
        'CustomerMobile': customerMobile,
        'TripId': tripId,
        'StatusId': statusId,
        'OrderNo': orderNo,
        'fileStatus': fileStatus,
        'deliveryPoint': deliveryPoint,
        'longtitude': longtitude,
        'latitude': latitude,
        'DesingId': desingId,
        'orderId': orderId
      };
}
