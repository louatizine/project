import 'dart:convert';
import 'dart:io';
import 'package:gestionConge/Models/Conge.dart';
import 'package:gestionConge/Models/EmployeInformation.dart';
import 'package:gestionConge/Models/employe.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeService {
  // get list of leave ...
  Future<List<Conge>> getLeaveList(int page) async {
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
        LeaveList.add(lea);
      }

      return LeaveList;
    } else {
      throw Exception("error ");
    }
  }

  //get list of Employees
  Future<List<Employe>> getListUser(int page) async {
    List<Employe> employeesList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse('http://localhost:8090/api/employe/getAllEmploye'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (Map<String, dynamic> e in data) {
        Employe emp = Employe.fromJson(e);
        employeesList.add(emp);
      }

      return employeesList;
    } else {
      throw Exception("error ");
    }
  }

  //get Employe Profile
  Future<EmployeInformation> getEmploye() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String id = prefs.getString('employe_id') ?? '';
    final response = await http.get(
      Uri.parse('http://localhost:8090/api/employe/getById/${id}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      EmployeInformation emp = EmployeInformation.fromJson(data);
      return emp;
    } else {
      throw Exception("error ");
    }
  }

  //update Employe
  Future<EmployeInformation> updateUser(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.post(
      Uri.parse('http://localhost:8090/api/employe/edit'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonEncode(<String, String>{
        'title': email,
      }),
    );
    if (response.statusCode == 200) {
      return EmployeInformation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("error ");
    }
  }
}
