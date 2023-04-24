import 'dart:convert';
import 'package:gestionConge/src/features/Dashboard/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentification/screens/login/LOG1/login_screen.dart';
import 'api_endpoints.dart';

class Registerontroller extends GetxController {
  TextEditingController UsernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        'name': UsernameController.text,
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'role': roleController.text

      };

      final SharedPreferences prefs = await _prefs;
      var token = prefs.getString('accessToken');

      var headers = {'Content-Type': 'application/json'};

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200)
      {
        final json = jsonDecode(response.body);
        var token = json['accessToken'];
       // final SharedPreferences prefs = await _prefs;
        prefs.setString('accessToken', token);

        UsernameController.clear();
        emailController.clear();
        passwordController.clear();
        roleController.clear();
        Get.off(const LoginScreen());
        Get.to(() =>HomePage());
      }else{
        throw jsonDecode(response.body)["message"] ?? "Account Exist!";
      }

      //if (response.statusCode == 200) {
        //final json = jsonDecode(response.body);
        //if (json['code'] == 0) {
          ///var token = json['accessToken'];
         // print(accessToken);
          //final SharedPreferences prefs = await _prefs;
          //prefs.setString('accessToken', token);
          //prefs.setString('username', json['username']);

          //nameController.clear();
         // emailController.clear();
        //  passwordController.clear();
         // Get.off(const LoginScreen());
         // Get.to(() =>HomePage());

       // } else {
        //  throw jsonDecode(response.body)["message"] ?? "Failed To Load Data";
       // }
     // } else {
      //  throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      //}
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
