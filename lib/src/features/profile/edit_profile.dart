import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/EmployeInformation.dart';
import '../../../Service/employe_service.dart';
import '../../common_widget/form/button.dart';



class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();

}

class _EditProfilePageState extends State<EditProfilePage> {

  EmployeService employeService = EmployeService();
  late Future<EmployeInformation> employe;
  final emailController = TextEditingController();

  // EditRequest FromEmployeToEmployeRequest(EmployeInformation employe) {
  //   EditRequest editRequest = EditRequest(
  //       firstName:  employe.firstName,
  //       lastName: employe.lastName,
  //       adress: employe.adress,
  //       email: employe.email,
  //       tel: employe.tel,
  //       id: employe.id,
  //       contactStart: employe.contactStart,
  //       contactEnd: employe.contactEnd,
  //
  //   );
  //   return editRequest;
  // }

  Future<EmployeInformation> updateUser(int userId, String firstName, String lastName, String address, String email, String tel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final Map<String, dynamic> requestBody = {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'email': email,
      'tel': tel,
    };
    final response = await http.post(
        Uri.parse('http://localhost:8090/api/employe/edit'),

        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
        body: json.encode(requestBody)
    );

    if (response.statusCode == 200) {
      print('User information updated successfully');
      return EmployeInformation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("error ");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employe = employeService.getEmploye();
  }
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {},
        )
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image:  const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(''))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                buildTextField("Full Name", "Louati Zine", false),
                buildTextField("E-mail", "Zine@gmail.com", false),
                buildTextField("Password", "********", true),
                buildTextField("Location", "", false),
                buildTextField("Location", "", false),
                buildTextField("Location", "", false),
                buildTextField("Location", "", false),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(
                      label: 'Cancel',
                      ontap: () {},
                      style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                    MyButton(
                      label: 'SAVE',
                      ontap: () {},
                      style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
