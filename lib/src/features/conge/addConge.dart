import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class addCongePage extends StatefulWidget {
  const addCongePage({Key? key}) : super(key: key);

  @override
  State<addCongePage> createState() => _addCongePageState();
}

class _addCongePageState extends State<addCongePage> {
  final _formKey = GlobalKey<FormState>();
  var reason = TextEditingController();

  insert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.post(
        Uri.parse('http://localhost:8090/api/conge/add'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: {"reason": reason.text}
    );
    print('Response body: ${response.body}');
    return response;
  }


  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // Form is valid, do something with input data
  //     String inputData = _inputController.text;
  //     print('Input data: $inputData');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: reason,
                decoration: const InputDecoration(
                  labelText: 'Input field label',
                  hintText: 'Input field hint',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some input';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed:() {
                        insert();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:gestionConge/Models/Conge.dart';
// import 'package:gestionConge/Service/conge_service.dart';
// import 'package:flutter_fast_forms/flutter_fast_forms.dart';
// import 'package:intl/intl.dart';
//
// class addCongePage extends StatefulWidget {
//   const addCongePage({Key? key}) : super(key: key);
//
//   @override
//   State<addCongePage> createState() => _addCongePageState();
// }
//
// class _addCongePageState extends State<addCongePage> {
//
//   TextEditingController reasonController = TextEditingController();
//   TextEditingController startDate = TextEditingController();
//   TextEditingController endDate = TextEditingController();
//
//   // TextEditingController startTime = TextEditingController();
//   // TextEditingController endTime = TextEditingController();
//
//   CongeService congeService = CongeService();
//   final _formKey = GlobalKey<FormState>();
//   Conge conge = Conge();
//   late Future<Conge> congeajouter;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   getDate(value) {
//     print(value);
//
//     DateTime startDate = DateTime.parse(value.startDate);
//     DateTime endDate = DateTime.parse(value.endDate);
//     conge.startDate =startDate;
//     conge.endDate = endDate;
//
//   }
//
// //   void addConge() {
// //     print(startDate.text);
// // /*    Conge conge = Conge(id: 1000,
// //         requestDate: requestDate,
// //         startDate: startDate.text,
// //         endDate: endDate.text,
// //         reason: reasonController.text,
// //         employe: employe,
// //         status: status)*/
// //   }
//   void addConge() {
//     if (_formKey.currentState!.validate()) {
//       conge.reason = reasonController.text;
//       conge.startDate = DateTime.parse(startDate.text);
//       conge.endDate = DateTime.parse(endDate.text);
//
//       print('Reason: ${conge.reason}');
//       print('Start date: ${conge.startDate}');
//       print('End date: ${conge.endDate}');
//     }
//   }
// /*
//   late DateTime _selectedDate = DateTime.now();
//   String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
//   String _endTime = DateFormat('hh:mm a')
//       .format(DateTime.now().add(const Duration(minutes: 15)))
//       .toString();
// */
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Ajouter une demande de congé"),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               FastForm(
//                 formKey: _formKey,
//                 children: _buildForm(context),
//                 onChanged: (value) {
//                   // ignore: avoid_print
//                 //  print('Form changed: ${value.toString()}');
//                 },
//               ),
//               ElevatedButton(
//                 child: const Text('Ajouter'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     addConge();
//                   }
//                 },
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildForm(BuildContext context) {
//     DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
//
//     return [
//       FastFormSection(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//         children: [
//           FastTextField(
//             onChanged: (value) => conge.reason=value,
//             name: 'Raison',
//             labelText: 'Raison',
//             placeholder: 'Votre raison pour le congé',
//             validator: Validators.compose([
//               Validators.required((value) => 'Le raison est obligatoire'),
//               Validators.minLength(
//                   7,
//                       (value, minLength) => 'Field must contain at least $minLength characters')
//             ]),
//           ),
//
//
//           FastDateRangePicker(
//             onChanged: (value) => {
//               getDate(value)
//             },
//             name: 'Date de congé',
//             labelText: 'Date début - Date fin',
//             firstDate: DateTime.now(),
//             lastDate: DateTime.now().add(const Duration(days: 365)),
//             validator:Validators.required((value) => 'Les dates sont obligatoire'),
//           ),
//           FastTimePicker(
//             // onChanged: (value) => {
//             //   conge.startDate!= formatter.format(value!.start),
//             //   conge.endDate!= formatter.format(value!.),
//             // },
//             name: 'Heure de début',
//             labelText: 'Heure de début',
//             validator: Validators.compose([
//               Validators.required((value) => 'Heure de début'),
//             ]),
//           ),
//           FastTimePicker(
//             // onChanged: (value) => {
//             //   conge.startDate!= formatter.format(value!.start),
//             //   conge.endDate!= formatter.format(value!.),
//             // },
//             name: 'Heure de fin',
//             labelText: 'Heure de fin',
//             validator: Validators.compose([
//               Validators.required((value) => 'Heure de fin'),
//             ]),
//           ),
//           FastDropdown<String>(
//             onChanged: (value) => conge.typeConge,
//             name: 'Type de congé',
//             labelText: 'Type de congé',
//             items: ['Authorization', 'Congé'],
//             validator: Validators.compose([
//               Validators.required((value) => 'Type de congé obligatoire'),
//             ]),
//           ),
//         ],
//       ),
//     ];
//   }
// }