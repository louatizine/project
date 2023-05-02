import 'dart:convert';
import 'package:gestionConge/src/features/Dashboard/home.dart';
import 'package:gestionConge/src/features/Dashboard/homeEmployee.dart';
import 'package:gestionConge/src/features/authentification/screens/login/LOG1/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../src/features/core/controllers/api_endpoints.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> roles = [];

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'username': emailController.text.trim(),
        'password': passwordController.text,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var token = json['accessToken'];
        final SharedPreferences prefs = await _prefs;
        prefs.setString('accessToken', token);
        prefs.setString('username', json['username']);
        prefs.setString('id', json['id'].toString());
        prefs.setString('employe_id', json['employe_id'].toString());
        roles = List<String>.from(json['roles']);
        prefs.setStringList('user_roles', roles);

        if (roles.contains("ROLE_ADMIN")) {
          Get.to(() => HomePage());
        } else {
          Get.to(() => HomeEmployeePage());
        }
        emailController.clear();
        passwordController.clear();
        //Get.off( const LoginScreen());
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.off(() => const LoginScreen());

    Get.to(() => const LoginScreen());
  }
}
