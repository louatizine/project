import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:flutter/material.dart';
import 'package:gestionConge/Models/employe.dart';
import 'package:gestionConge/Service/employe_service.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
//  final scrollController =  ScrollController();
  EmployeService employeService = EmployeService();
  late Future<List<Employe>> employeesList;
  int page = 1;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
//  scrollController.addListener(_scrolleListener);
    employeesList = employeService.getListUser(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: employeesList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return buildCard(snapshot.data![index]);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Oops'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  buildCard(Employe employe) {
    const SizedBox(height: 10);
    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(left: 16, right: 16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(40),
          )),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: ListTile(
          title: Text('${employe.firstName} ${employe.lastName}'),
          leading: ProfilePicture(
            name: employe.firstName,
            radius: 20,
            fontsize: 15,
          ),
          subtitle: Text(employe.email),
        ),
      ),
    );
  }
}
