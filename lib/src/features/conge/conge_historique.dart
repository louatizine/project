import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:gestionConge/Models/Conge.dart';
import 'package:gestionConge/Service/conge_service.dart';
import 'package:intl/intl.dart';


class CongeHistoriquePage extends StatefulWidget {
  const CongeHistoriquePage({super.key});

  @override
  _CongeHistoriquePageState createState() => _CongeHistoriquePageState();
}

class _CongeHistoriquePageState extends State<CongeHistoriquePage> {
  CongeService congeService = CongeService();
  late Future<List<Conge>> congeList;
  int page = 1;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
//  scrollController.addListener(_scrolleListener);
    congeList = congeService.getLeaveList(page,false);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: congeList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Sort the list based on status
            List<Conge> sortedConges = snapshot.data!;
            sortedConges.sort((a, b) {
              if (a.status!.label == 'Valider' && b.status!.label == 'Refuser') {
                return -1; // a comes before b
              } else if (a.status!.label == 'Refuser' && b.status!.label == 'Valider') {
                return 1; // a comes after b
              } else {
                return 0; // no change in order
              }
            });

            return ListView.separated(
              itemCount: sortedConges.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return buildCard(sortedConges[index]);
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
      ),
    );
  }


  buildCard(Conge conge) {
    DateFormat formatter = DateFormat('yy-MM-dd');
    String contactStart = formatter.format(conge.employe!.contactStart);
    return Card(
      shadowColor: Colors.black38,
      elevation: 7,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: ListTile(
          leading: ProfilePicture(
            name: conge.employe!.firstName,
            radius: 20,
            fontsize: 15,
          ),
          title: Text('${conge.employe!.firstName} ${conge.employe!.lastName}'),
          subtitle: Expanded(
              flex: 1,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            conge.reason.toString(),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 13.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(contactStart),
                        ),
                      ),
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
                              child: (Text(conge.status!.label,
                                style: const TextStyle(
                                  color: Colors.white, // Set the text color
                                  fontSize: 10.0,
                                ),
                                textAlign: TextAlign.center, // Center the text horizontally),
                              )

                              ),
                            ),
                          ),
                        ),)
                    ],
                  ),

                ],
              )),
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
        return Colors.yellow.shade500;
    }

}

}
