import 'dart:convert';
import 'dart:io';
import 'package:gestionConge/Models/SoldConge.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class SoldCongeService {
  // get list of leave ...

  Future<double>  getSoldByEmploye() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String idEmploye = prefs.getString('employe_id') ?? '';

    final response = await http.get(
      Uri.parse('http://localhost:8090/api/soldeConge/getByEmployeeId/$idEmploye'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      SoldConge soldConge = SoldConge.fromJson(data);
      return soldConge.currentBalance;
    } else {
      throw Exception("error ");
    }
  }
/*
  Future<int> congeNumberByEmploye() async {
    return await getCongeByEmployee().then((value) {
      return value.length;
    });
  }*/
}
