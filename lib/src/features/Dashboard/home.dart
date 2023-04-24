import 'package:flutter/material.dart';
import 'package:gestionConge/Service/logincontroller.dart';
import 'package:gestionConge/src/features/conge/conge_historique.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../conge/addConge.dart';
import '../profile/profile.dart';
import 'dashboard.dart';
import 'my_drawer_header.dart';
import '../conge/conge_demande_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = '';
  var currentPage = DrawerSections.dashboard;
  LoginController loginController = Get.put(LoginController());

  _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = (prefs.getString('username') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    var container;
    _loadUserName();
    if (currentPage == DrawerSections.dashboard) {
      container = const Display();
    } else if (currentPage == DrawerSections.events) {
      container = addCongePage();
    } else if (currentPage == DrawerSections.congeDemandePage) {
      container = CongeDemandePage();
    } else if (currentPage == DrawerSections.congeHistorique) {
      container = CongeHistoriquePage();
    } else if (currentPage == DrawerSections.profile) {
      container = const Profile();
    } else if (currentPage == DrawerSections.logout) {
      loginController.logOut();
    }

    // String userName= prefs.getString('username').toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Gestion de conge"),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.person,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20, left: 3.0),
              child: GestureDetector(
                onTap: () {},
                child: Text('$_userName'),
              )),
        ],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Events", Icons.event,
              currentPage == DrawerSections.events ? true : false),
          menuItem(3, "Conge", Icons.notifications_outlined,
              currentPage == DrawerSections.congeDemandePage ? true : false),
         menuItem(4, "Conge Historique", Icons.notifications_outlined,
              currentPage == DrawerSections.congeHistorique ? true : false),
          menuItem(5, "Profile", Icons.person,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(6, "Log out", Icons.logout,
              currentPage == DrawerSections.congeDemandePage ? true : false),
          const Divider(),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.events;
            } else if (id == 3) {
              currentPage = DrawerSections.congeDemandePage;
            } else if (id == 4) {
              currentPage = DrawerSections.congeHistorique;
            } else if (id == 5) {
              currentPage = DrawerSections.profile;
            } else if (id == 6) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections { dashboard, events, profile, logout, congeDemandePage, congeHistorique }
