import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:gestionConge/Models/Conge.dart';
import 'package:gestionConge/Service/conge_service.dart';
import 'package:intl/intl.dart';

class EmployeeCongeListPage extends StatefulWidget {
  const EmployeeCongeListPage({Key? key}) : super(key: key);

  @override
  _EmployeeCongeListPageState createState() => _EmployeeCongeListPageState();
}

class _EmployeeCongeListPageState extends State<EmployeeCongeListPage> {
  CongeService congeService = CongeService();
  late Future<List<Conge>> congeList;
  int page = 1;
  @override
  void initState() {
// TODO: implement initState
    super.initState();
//  scrollController.addListener(_scrolleListener);
    congeList = congeService.getCongeByEmployee();
  }

  void deleteRequest(Conge conge) {
     congeService.deleteConge(conge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: congeList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Oops'),
            );
          } else {
            return const Center(
              child: Text('No request'),
            );          }
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
                      if(conge.status!.label=="En cours")
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmation"),
                                content: const Text("Voulez-vous vraiment supprimer?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Non"),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text("Oui"),
                                    onPressed: () {
                                      deleteRequest(conge);
                                      congeList = congeService.getCongeByEmployee();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();

                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }

                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Supprimer',
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
          height: 200,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: _getBackgroundColor(conge.status!.label),// Set the border radius
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (Text(conge.status!    .label,
                                  style: const TextStyle(
                                    color: Colors.white, // Set the text color
                                    fontSize: 10.0,
                                  ),
                                  textAlign: TextAlign.center, // Center the text horizontally),
                                )

                                ),
                              ),
                            ),
                          ),)                      ]),
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

  Color _getBackgroundColor(String status) {
    switch (status) {
      case 'Valider':
        return Colors.green;
      case 'Refuser':
        return Colors.red;
      case 'En cours':
      default:
        return Colors.orange;
    }

  }
}
