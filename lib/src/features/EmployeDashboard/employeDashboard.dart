import 'package:flutter/material.dart';
import 'package:gestionConge/Annimation/FadeAnimation.dart';
import 'package:gestionConge/Models/EmployeInformation.dart';
import 'package:gestionConge/Models/Statistique.dart';
import 'package:gestionConge/Service/SoldCongeService.dart';
import 'package:gestionConge/Service/conge_service.dart';
import 'package:gestionConge/Service/employe_service.dart';
import 'package:gestionConge/src/features/profile/profile.dart';
import 'package:get/get.dart';

class employeDashboardPage extends StatefulWidget {
  const employeDashboardPage({Key? key}) : super(key: key);

  @override
  _employeDashboardPageState createState() => _employeDashboardPageState();
}

class _employeDashboardPageState extends State<employeDashboardPage> {
  int congeNumber = 0;
  late Future<EmployeInformation> employe;
  EmployeService employeService = EmployeService();
  CongeService congeService = CongeService();
  SoldCongeService soldCongeService = SoldCongeService();

  List<Statistique> statistiques = [];
  List<CongeService> encours = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToTale();
    getCurrentSold();
  }

  // getCongeEncour() {
  //   congeService.getCongeEnCours().then((value) {
  //     setState(() {
  //       var currentNumber = value;
  //       CongeService service = CongeService('hello',currentNumber.toString());
  //       encours.add(service);
  //     });
  //   });
  // }



  getCurrentSold() {
    soldCongeService.getSoldByEmploye().then((value) {
      setState(() {
        var currentSold = value;
        Statistique service = Statistique("Solde", currentSold.toString());
        statistiques.add(service);
      });
    });
  }

  getToTale() {
    congeService.congeNumberByEmploye().then((value) {
      setState(() {
        congeNumber = value;
        Statistique service = Statistique("Conges", value.toString());
        statistiques.add(service);
      });
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
    ));
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
            color: Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(image,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              const SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 15),
              )
            ]),
      ),
    );
  }

  buildProfil(EmployeInformation employe) {
    return SingleChildScrollView(
        child: Column(children: [
      FadeAnimation(
          1,
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
          )),
      FadeAnimation(
          1.2,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 4),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            'https://images.pexels.com/photos/355164/pexels-photo-355164.jpeg?crop=faces&fit=crop&h=200&w=200&auto=compress&cs=tinysrgb',
                            width: 70,
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${employe.firstName} ${employe.lastName}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            employe.function.label,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Replace 'routeName' with the name of the route you want to navigate to
                      Get.to(() => const Profile());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: const Center(
                        child: Text(
                          'Mon Profile',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      const SizedBox(
        height: 20,
      ),
      FadeAnimation(
          1.3,
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
          )),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 300,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statistiques.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation(
                  (1.0 + index) / 4,
                  serviceContainer(statistiques[index].number,
                      statistiques[index].name, index));
            }),
      ),
    ]));
  }
}
