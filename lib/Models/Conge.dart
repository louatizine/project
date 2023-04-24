import 'package:gestionConge/Models/EmployeInformation.dart';
import 'package:gestionConge/Models/TypeConge.dart';
import 'package:gestionConge/Models/statutConge.dart';

class Conge {
   int? id;
   DateTime? requestDate;
   DateTime? startDate;
   DateTime? endDate;
 //final DateTime startTime;
 //final DateTime endTime;
   String? reason;
   EmployeInformation? employe;
   LeaveStatus? status;
   TypeConge? typeConge;

  Conge({
     this.id,
     this.requestDate,
     this.startDate,
     this.endDate,
  //  required this.startTime,
   // required this.endTime,
     this.reason,
     this.employe,
     this.status,
     this.typeConge,
  });

  factory Conge.fromJson(Map<String, dynamic> json) {
    return Conge(
      id: json['id'],
      requestDate: DateTime(json['request_date'][0], json['request_date'][1],
          json['request_date'][2]),
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
      employe: EmployeInformation.fromJson(json['employe']),
      status: LeaveStatus.fromJson(json['status']),
      typeConge: TypeConge.fromJson(json['typeConge']),
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
}
