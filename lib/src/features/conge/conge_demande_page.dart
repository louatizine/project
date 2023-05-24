import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:gestionConge/Models/Conge.dart';
import 'package:gestionConge/Service/conge_service.dart';
import 'package:gestionConge/src/features/Dashboard/chart.dart';
import 'package:gestionConge/src/features/Dashboard/home.dart';
import 'package:gestionConge/src/features/Dashboard/homeEmployee.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CongeDemandePage extends StatefulWidget {
  const CongeDemandePage({Key? key}) : super(key: key);

  @override
  _CongeDemandePageState createState() => _CongeDemandePageState();
}

class _CongeDemandePageState extends State<CongeDemandePage> {
  CongeService congeService = CongeService();
  late Future<List<Conge>> congeList;
  int page = 1;

  @override
  void initState() {
    super.initState();
    congeList = congeService.getLeaveList(page, true);
  }

  void editCongeStatuts(bool validate, Conge conge) {
    if (validate) {
      conge.status!.id = 3;
    } else {
      conge.status!.id = 2;
    }
    congeService.editConge(conge);
    congeList = congeService.getLeaveList(page, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: congeList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length != 0) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 15.0),
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return buildCard(snapshot.data![index]);
                },
              );
            } else {
              return const Center(
                child: Text('Aucune Demande en cours ...'),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Oops'),
            );
          } else {
            return const Center(
              child: Text('Oops'),
            );
          }
        },
      ),
    );
  }

  buildCard(Conge conge) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String startDate = formatter.format(conge.startDate!);
    String endDate = formatter.format(conge.endDate!);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirmation"),
                            content: const Text(
                                "Êtes-vous sûre de vouloir accepter?"),
                            actions: [
                              TextButton(
                                  child: const Text("Non"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }),
                              TextButton(
                                child: const Text("Oui"),
                                onPressed: () {
                                  editCongeStatuts(true, conge);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Get.to(() => HomePage());
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Valider',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirmation"),
                            content:
                                const Text("Voulez-vous vraiment supprimer?"),
                            actions: [
                              TextButton(
                                  child: const Text("Non"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }),
                              TextButton(
                                child: const Text("Oui"),
                                onPressed: () {
                                  editCongeStatuts(false, conge);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Get.to(() => HomePage());
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Refuser',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Fermer ',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 7,
        margin: const EdgeInsets.only(left: 16, right: 16),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(40),
        )),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: ProfilePicture(
                  name: conge.employe!.firstName,
                  radius: 20,
                  fontsize: 15,
                ),
                title: Text(
                    '${conge.employe!.firstName} ${conge.employe!.lastName}'),
                subtitle: Expanded(
                  flex: 1,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Reason : ${conge.reason}",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time,
                                    size: 16), // Add icon here
                                const SizedBox(
                                    width:
                                        3), // Add some spacing between icon and text
                                Text(
                                    "Start at : $startDate"), // Use string interpolation to add variable to text
                              ],
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time,
                                    size: 16), // Add icon here
                                const SizedBox(
                                    width:
                                        3), // Add some spacing between icon and text
                                Text(
                                    "End at : $endDate"), // Use string interpolation to add variable to text
                              ],
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                const Icon(Icons.type_specimen_outlined,
                                    size: 16), // Add icon here
                                const SizedBox(
                                    width:
                                        3), // Add some spacing between icon and text
                                Text(
                                    "Type :  ${conge.typeConge!.label}"), // Use string interpolation to add variable to text
                              ],
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green, // Set the background color
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  conge.status!.label,
                                  style: const TextStyle(
                                    color: Colors.white, // Set the text color
                                    fontSize: 13.0,
                                  ),
                                  textAlign: TextAlign
                                      .center, // Center the text horizontally),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
