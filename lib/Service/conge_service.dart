import 'dart:convert';
import 'dart:io';
import 'package:gestionConge/Models/Conge.dart';
import 'package:gestionConge/Models/CongeRequest.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class CongeService {
  // get list of leave ...

  Future<List<Conge>> getLeaveList(int page, bool getInProgress) async {
    List<Conge> LeaveList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String inProgress = 'En cours';
    final response = await http.get(
      Uri.parse('http://localhost:8090/api/conge/getAll'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> leave in data) {
        Conge lea = Conge.fromJson(leave);

        if (getInProgress) {
          if (lea.status!.label == inProgress) {
            LeaveList.add(lea);
          }
        } else if (lea.status!.label != inProgress) {
          LeaveList.add(lea);
        }
      }

      return LeaveList;
    } else {
      throw Exception("error ");
    }
  }

  editConge(Conge conge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    CongeRequest congeRequest = FromCongeToCongeRequest(conge);
    print(congeRequest.toJson());
    final response =
        await http.post(Uri.parse('http://localhost:8090/api/conge/edit'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
            body: json.encode(congeRequest.toJson()));
  }

  CongeRequest FromCongeToCongeRequest(Conge conge) {
    CongeRequest congeRequest = CongeRequest(
        id: conge.id,
        startDate: conge.startDate,
        endDate: conge.endDate,
        reason: conge.reason,
        employe_id: conge.employe!.id,
        status_id: conge.status!.id,
        typeConge_id: conge.typeConge?.id);
    return congeRequest;
  }




  Future<Conge> addConge(Conge conge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    CongeRequest congeRequest = FromCongeToCongeRequest(conge);
    final response = await http.post(
      Uri.parse('http://localhost:8090/api/conge/add'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
        body: json.encode(congeRequest.toJson())
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Conge co = Conge.fromJson(data);
      return co;
    } else {
      throw Exception('Failed to add event');
    }
  }
  // void  deleteConge(Conge conge) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? accessToken = prefs.getString('accessToken');
  //   final response = await http.get(
  //       Uri.parse('http://localhost:8090/api/conge/delete/{id}'),
  //       headers: {
  //         HttpHeaders.authorizationHeader: 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //
  //   );
  //   // return json.decode(response.body);
  // }


}
