class CongeRequest {
   int? id;
   DateTime? startDate;
   DateTime? endDate;
  //final DateTime startTime;
  //final DateTime endTime;
   String? reason;
   int? employe_id;
   int? status_id;
   int? typeConge_id;

  CongeRequest({
     this.id,
     this.startDate,
     this.endDate,
    //  required this.startTime,
    // required this.endTime,
     this.reason,
     this.employe_id,
     this.status_id,
     this.typeConge_id,
  });

  factory CongeRequest.fromJson(Map<String, dynamic> json) {
    return CongeRequest(
      id: json['id'],
      startDate: DateTime(
          json['start_date'][0], json['start_date'][1], json['start_date'][2]),
      endDate: DateTime(
          json['end_date'][0], json['end_date'][1], json['end_date'][2]),
      //  startTime: DateTime(
      //json['start_time'][0], json['start_time'][1], json['start_time'][2]),
      //  endTime: DateTime(
      //  json['end_time'][0], json['end_time'][1], json['end_time'][2]),
      // startTime: json['startTime'],
      // endTime: json['endTime'],
      reason: json['reason'],
      employe_id: json['employe_id'],
      status_id: json['status_id'],
      typeConge_id: json['typeConge_id'],
    );
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['request_date'] = this.requestDate;
//   data['start_date'] = this.startDate;
//   data['end_date'] = this.endDate;
//   data['start_time'] = this.startTime;
//   data['end_time'] = this.endTime;
//   data['reason'] = this.reason;
//   if (this.employe != null) {
//     data['employe'] = this.employe!.toJson();
//   }
//   if (this.status != null) {
//     data['status'] = this.status!.toJson();
//   }
//   data['typeConge'] = this.typeConge;
//   return data;
// }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = [
      this.startDate!.year,
      this.startDate!.month,
      this.startDate!.day
    ];
    data['end_date'] = [
      this.endDate!.year,
      this.endDate!.month,
      this.endDate!.day
    ];
    data['reason'] = this.reason;
    data['employe_id'] = this.employe_id;
    data['status_id'] = this.status_id;
    data['typeConge_id'] = this.typeConge_id;
    return data;
  }

}
