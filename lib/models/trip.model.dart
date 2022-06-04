class TripModel {
  final String? tripCode;
  final String? statusId;
  final int? fileStatus;
  final int? empId;
  final String? userName;
  final int? desingId;
  final String? tripId;

  TripModel({
    this.tripCode,
    this.statusId,
    this.fileStatus,
    this.empId,
    this.userName,
    this.desingId,
    this.tripId,
  });

  TripModel.fromJson(Map<String, dynamic> json)
      : tripCode = json['TripCode'] as String?,
        statusId = json['StatusId'] as String?,
        fileStatus = json['fileStatus'] as int?,
        empId = json['EmpId'] as int?,
        userName = json['UserName'] as String?,
        desingId = json['DesingId'] as int?,
        tripId = json['TripId'] as String?;

  Map<String, dynamic> toJson() => {
        'TripCode': tripCode,
        'StatusId': statusId,
        'fileStatus': fileStatus,
        'EmpId': empId,
        'UserName': userName,
        'DesingId': desingId,
        'TripId': tripId
      };
}
