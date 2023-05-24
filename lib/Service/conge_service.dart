import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestionConge/Models/Conge.dart';
import 'package:gestionConge/Models/CongeRequest.dart';
import 'package:gestionConge/src/features/conge/employeeCongeList.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

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

  addConge(CongeRequest conge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? employe_id = prefs.getString('employe_id');
    conge.employe_id = int.parse(employe_id!);

    final response =
    await http.post(Uri.parse('http://localhost:8090/api/conge/add'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(conge.toJson()));

    if (response.statusCode == 200) {
      Get.to(() => const EmployeeCongeListPage());

      Fluttertoast.showToast(
        msg: "Congé ajouter avec succès!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    } else {
      throw Exception('Failed to add event');
    }
  }

  Future<List<Conge>> getCongeByEmployee() async {
    List<Conge> LeaveList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? employeeId = prefs.getString('employe_id');

    final response = await http.get(
      Uri.parse('http://localhost:8090/api/conge/getByEmployeId/${employeeId}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> leave in data) {
        Conge lea = Conge.fromJson(leave);
        LeaveList.add(lea);
      }
      return LeaveList;
    } else {
      throw Exception("error ");
    }
  }

  void deleteConge(Conge conge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.get(
      Uri.parse('http://localhost:8090/api/conge/delete/${conge.id}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<int> congeNumberByEmploye() async {
    return await getCongeByEmployee().then((value) {
      return value.length;
    });
  }



  Future<List<Conge>> getCongeEnCours() async {
    List<Conge> LeaveList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? employeeId = prefs.getString('employe_id');

    final response = await http.get(
      Uri.parse('http://localhost:8090/api/conge/getByEmployeId/$employeeId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> leave in data) {
        Conge lea = Conge.fromJson(leave);
        if (lea.status?.label == "en cours") {
          LeaveList.add(lea);
        }
      }
      return LeaveList;
    } else {
      throw Exception("error ");
    }
  }

  Future<List<Conge>> getTotalList() async {
    List<Conge> LeaveList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
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
      }
      return LeaveList;
    } else {
      throw Exception("error ");
    }
  }



}
