import 'dart:convert';
import 'dart:io';

import 'package:gestionConge/Models/EmployeInformation.dart';
import 'package:gestionConge/Service/employe_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/function.dart';
import '../../common_widget/form/input.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  Future<void> updateUser(String firstName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final Map<String, dynamic> requestBody = {
      'firstName': firstName,
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

  @override
  Widget build(BuildContext context) {
    //_loadUserName();
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: FutureBuilder(
              future: employe,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildProfil(snapshot.data!);
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Oops'),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  buildProfil(EmployeInformation employe) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String contactEnd = formatter.format(employe.contactEnd);

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          const SizedBox(
            height: 250,
            width: double.infinity,
            child: Image(
              image: AssetImage(
                "assets/images/ent.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 200, 15, 15),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 95),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  employe.firstName + employe.lastName,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  //You can add Subtitle here
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/images/ent.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: <Widget>[
                      const ListTile(
                        title: Text("User Informations"),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your email',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(()  {
                                          updateUser(emailController.text);
                                        });
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text('Email'),
                          subtitle: Text(employe.email),
                          leading: const Icon(Icons.email),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 200,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          labelText: 'New phone number',
                                        ),
                                        onChanged: (value) {
                                          // update phone number in state
                                        },
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // update phone number in API
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text('Phone'),
                          subtitle: Text(employe.tel),
                          leading: const Icon(Icons.phone_in_talk_rounded),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return SizedBox(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'New Matricule',
                                            hintText: 'Enter the new matricule',
                                          ),
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text('Save'),
                                          onPressed: () {
                                            // Update the employe's matricule here using the newMatricule value
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text('Matricule'),
                          subtitle: Text(employe.matricule),
                          leading: const Icon(Icons.card_membership_rounded),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  String newDepartementLabel =
                                      employe.departement.label;
                                  return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          initialValue: newDepartementLabel,
                                          decoration: const InputDecoration(
                                            labelText: 'New departement label',
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              newDepartementLabel = value;
                                            });
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              employe.function =
                                                  FunctionEmploye(
                                                      label:
                                                          newDepartementLabel);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text('Departement'),
                          subtitle: Text(employe.departement.label),
                          leading: const Icon(Icons.add_home_rounded),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  String newFunctionLabel =
                                      employe.function.label;
                                  return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          initialValue: newFunctionLabel,
                                          decoration: const InputDecoration(
                                            labelText: 'New function label',
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              newFunctionLabel = value;
                                            });
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              employe.function =
                                                  FunctionEmploye(
                                                      label: newFunctionLabel);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text('Function'),
                          subtitle: Text(employe.function.label),
                          leading: const Icon(Icons.add_home_rounded),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return SizedBox(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'Nouvelle Adresse',
                                            hintText: 'Enter the new adresse',
                                          ),
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text('Save'),
                                          onPressed: () {
                                            // Update the employe's matricule here using the newMatricule value
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text('Adresse'),
                          subtitle: Text(employe.adress),
                          leading: const Icon(Icons.card_membership_rounded),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              final TextEditingController dateController =
                                  TextEditingController();
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    inputField(
                                      controller: dateController,
                                      hintText: "Select a date",
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon:
                                              const Icon(Icons.calendar_today),
                                          onPressed: () async {
                                            final DateTime? date =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(const Duration(
                                                      days: 365)),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                            );
                                            if (date != null) {
                                              dateController.text =
                                                  DateFormat.yMd().format(date);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    TextButton(
                                      child: const Text("Update"),
                                      onPressed: () {
                                        setState(() {
                                          contactEnd = dateController.text;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text("Contact Start"),
                          subtitle: Text(contactEnd),
                          leading: const Icon(Icons.calendar_month_outlined),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              final TextEditingController dateController =
                                  TextEditingController();
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    inputField(
                                      controller: dateController,
                                      hintText: "Select a date",
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon:
                                              const Icon(Icons.calendar_today),
                                          onPressed: () async {
                                            final DateTime? date =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(const Duration(
                                                      days: 365)),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                            );
                                            if (date != null) {
                                              dateController.text =
                                                  DateFormat.yMd().format(date);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    TextButton(
                                      child: const Text("Update"),
                                      onPressed: () {
                                        setState(() {
                                          contactEnd = dateController.text;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: const Text("Contact End"),
                          subtitle: Text(contactEnd),
                          leading: const Icon(Icons.calendar_month_outlined),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
