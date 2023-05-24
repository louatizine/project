
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../../../Models/Conge.dart';
import '../../../Service/conge_service.dart';

class Calandar extends StatefulWidget {
  const Calandar({Key? key}) : super(key: key);

  @override
  State<Calandar> createState() => _CalandarState();
}

class _CalandarState extends State<Calandar> {
  CongeService congeService = CongeService();
  late Future<List<Conge>> congeList;
  int page = 1;
  int encours = 0;
  DateTime selectedDate = DateTime.now();

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
      body: Column(
        children: [
          _addDateBar(), // Call _addDateBar() here
          Expanded(
            child: FutureBuilder(
              future: congeList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length != 0) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 15.0),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
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
          ),
        ],
      ),
    );
  }


  buildCard(Conge conge) {
    final monthName = DateFormat.MMMM().format(conge.startDate!);
    return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            decoration: BoxDecoration(
                color: Color(0xFFF2F8FF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start at , ${conge.startDate!.day.toString()} , to ${conge
                    .endDate!.day.toString()}'),
                SizedBox(height: 5,),
                Text(monthName.toString()),
              ],
            ),
          )
        ],
      );
  }


  _addDateBar() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        selectedTextColor: Colors.white,
        selectionColor: Colors.blueAccent,
        onDateChange: (newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
        initialSelectedDate: selectedDate,
      ),
    );
  }

}