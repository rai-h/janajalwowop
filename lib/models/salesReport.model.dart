class SalesReportModel {
  final String? dispenserCount;
  final String? d2ltr;
  final String? requestAmount;
  final String? creditLimit;
  final String? coinAmount;
  final String? d3amt;
  final String? qrAmt;
  final String? d1ltr;
  final String? wowId;
  final String? d2amt;
  final String? address;
  final String? activeInd;
  final String? freightAmount;
  final String? rfidAmt;
  final String? d1amt;
  final String? lotDeviceId;
  final String? d3ltr;

  SalesReportModel({
    this.dispenserCount,
    this.d2ltr,
    this.requestAmount,
    this.creditLimit,
    this.coinAmount,
    this.d3amt,
    this.qrAmt,
    this.d1ltr,
    this.wowId,
    this.d2amt,
    this.address,
    this.activeInd,
    this.freightAmount,
    this.rfidAmt,
    this.d1amt,
    this.lotDeviceId,
    this.d3ltr,
  });

  SalesReportModel.fromJson(Map<String, dynamic> json)
      : dispenserCount = json['dispenserCount'] as String?,
        d2ltr = json['d2ltr'] as String?,
        requestAmount = json['requestAmount'] as String?,
        creditLimit = json['creditLimit'] as String?,
        coinAmount = json['coinAmount'] as String?,
        d3amt = json['d3amt'] as String?,
        qrAmt = json['qrAmt'] as String?,
        d1ltr = json['d1ltr'] as String?,
        wowId = json['wowId'] as String?,
        d2amt = json['d2amt'] as String?,
        address = json['address'] as String?,
        activeInd = json['activeInd'] as String?,
        freightAmount = json['freightAmount'] as String?,
        rfidAmt = json['rfidAmt'] as String?,
        d1amt = json['d1amt'] as String?,
        lotDeviceId = json['lotDeviceId'] as String?,
        d3ltr = json['d3ltr'] as String?;

  Map<String, dynamic> toJson() => {
        'dispenserCount': dispenserCount,
        'd2ltr': d2ltr,
        'requestAmount': requestAmount,
        'creditLimit': creditLimit,
        'coinAmount': coinAmount,
        'd3amt': d3amt,
        'qrAmt': qrAmt,
        'd1ltr': d1ltr,
        'wowId': wowId,
        'd2amt': d2amt,
        'address': address,
        'activeInd': activeInd,
        'freightAmount': freightAmount,
        'rfidAmt': rfidAmt,
        'd1amt': d1amt,
        'lotDeviceId': lotDeviceId,
        'd3ltr': d3ltr
      };
}
