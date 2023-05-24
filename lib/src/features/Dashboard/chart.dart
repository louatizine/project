import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:gestionConge/Models/EmployeInformation.dart';
import 'package:gestionConge/Models/Statistique.dart';
import 'package:gestionConge/Service/SoldCongeService.dart';
import 'package:gestionConge/Service/conge_service.dart';
import 'package:gestionConge/Service/employe_service.dart';
import 'package:gestionConge/src/features/Dashboard/dashboard.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../Models/employe.dart';


class Pie extends StatefulWidget {
  const Pie({Key? key}) : super(key: key);

  @override
  _PieState createState() => _PieState();
}

class _PieState extends State<Pie> {
  double congeNumber = 0;
  late Future<EmployeInformation> employe;
  EmployeService employeService = EmployeService();
  CongeService congeService = CongeService();
  late int encours;
  late double Refuser;
  late double Valider;
  late Future<List<Employe>> employeesList;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEncour();
    getValider();
    getRefuser();
    employeesList = employeService.getListUser(page);
  }

  getEncour() {
    congeService.getCongeByEmployee().then((conges) {
      final congesEnCours =
      conges.where((conge) => conge.status!.label == 'En cours').toList();
      setState(() {
        encours = congesEnCours.length;
      });
    }).catchError((error) {
      print('Error occurred while fetching congé en cours: $error');
    });
  }

  getValider() {
    congeService.getCongeByEmployee().then((conges) {
      final congesEnCours =
      conges.where((conge) => conge.status!.label == 'Valider').toList();
      setState(() {
        Valider = congesEnCours.length.toDouble();
      });
    }).catchError((error) {
      print('Error occurred while fetching congé en cours: $error');
    });
  }

  getRefuser() {
    congeService.getCongeByEmployee().then((conges) {
      final congesEnCours =
      conges.where((conge) => conge.status!.label == 'Refuser').toList();
      setState(() {
        Refuser = congesEnCours.length.toDouble();
      });
    }).catchError((error) {
      print('Error occurred while fetching congé en cours: $error');
    });
  }


  _loadUser() async {
    employe = employeService.getEmploye();
  }

  @override
  Widget build(BuildContext context) {
    _loadUser();
    return Scaffold(
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
        )
    );
  }

  buildProfil(EmployeInformation employe) {
    return SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),


            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Bienvenu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 215,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildpie(),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Statistiques',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View all',
                    ))
              ],
            ),
          ),
          buildCard(),
          SizedBox(height:10),
          buildCardValider(),
          SizedBox(height:10),
          buildCardRefuser()

        ]
        )

    );
  }

  buildCard() {
    getEncour();
    return Card(
      shadowColor: Colors.black38,
      elevation: 5,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: ListTile(
            title: Text('$encours', style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
                textAlign: TextAlign.center
            ),
            subtitle: const Text(
              'Congés En Cours', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.black
            ),),
          ),
        ),
      ),
    );
  }
/////////////////////
  buildpie() {
    getValider();
    getRefuser();
    Map<String, double> dataMap = {
      "Refusé": Refuser,
      "Validé": Valider,
    };
    return Container(
      width: 240,
      child: Center(
        child: PieChart(
          dataMap: dataMap,
          legendOptions: const LegendOptions(
            legendPosition: LegendPosition.left,
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
        ),
      ),
    );
  }
////////////////////
  buildCardValider() {
    getValider();
    return Card(
      shadowColor: Colors.black38,
      elevation: 5,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: ListTile(
            title: Text('$Valider', style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
                textAlign: TextAlign.center
            ),
            subtitle: const Text(
              'Congés Validé', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.black
            ),),
          ),
        ),
      ),
    );
  }
////////////////////
buildCardRefuser(){
  getEncour();
  return Card(
    shadowColor: Colors.black38,
    elevation: 5,
    margin: const EdgeInsets.only(left: 16, right: 16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: ListTile(
          title: Text('$Refuser', style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.orange),
              textAlign: TextAlign.center
          ),
          subtitle: const Text(
            'Congés Refusé', textAlign: TextAlign.center, style: TextStyle(
              color: Colors.black
          ),),
        ),
      ),
    ),
  );
}
}








