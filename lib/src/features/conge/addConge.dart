// void _submitForm() {
//   if (_formKey.currentState!.validate()) {
//     // Form is valid, do something with input data
//     String inputData = _inputController.text;
//     print('Input data: $inputData');
//   }
// }

import 'package:flutter/material.dart';
import 'package:gestionConge/Models/Conge.dart';
import 'package:gestionConge/Models/CongeRequest.dart';
import 'package:gestionConge/Service/conge_service.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:intl/intl.dart';

class addCongePage extends StatefulWidget {
  const addCongePage({Key? key}) : super(key: key);

  @override
  State<addCongePage> createState() => _addCongePageState();
}

class _addCongePageState extends State<addCongePage> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  // TextEditingController startTime = TextEditingController();
  // TextEditingController endTime = TextEditingController();

  CongeService congeService = CongeService();
  final _formKey = GlobalKey<FormState>();
  CongeRequest conge = CongeRequest();
  late Future<Conge> congeajouter;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getDate(value) {
    conge.startDate = value.start;
    conge.endDate = value.end;
  }

  getType(value) {
    if (value == "Congé") {
      conge.typeConge_id = 2;
    } else {
      conge.typeConge_id=1;
    }
  }

  void addCongeForm() {
    if (_formKey.currentState!.validate()) {
      conge.status_id=1;
      congeService.addConge(conge);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FastForm(
                formKey: _formKey,
                children: _buildForm(context),
              ),
              ElevatedButton(
                child: const Text('Ajouter'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addCongeForm();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildForm(BuildContext context) {
    DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');

    return [
      FastFormSection(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        children: [
          FastTextField(
            onChanged: (value) => conge.reason = value,
            name: 'Raison',
            labelText: 'Raison',
            placeholder: 'Votre raison pour le congé',
            validator: Validators.compose([
              Validators.required((value) => 'Le raison est obligatoire'),
              Validators.minLength(
                  7,
                  (value, minLength) =>
                      'Field must contain at least $minLength characters')
            ]),
          ),
          FastDateRangePicker(
            name: 'Date de congé',
            labelText: 'Date début - Date fin',
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            validator:
                Validators.required((value) => 'Les dates sont obligatoire'),
            onChanged: (value) => {getDate(value)},
          ),
          FastTimePicker(
            name: 'Heure de début',
            labelText: 'Heure de début',
            validator: Validators.compose([
              Validators.required((value) => 'Heure de début'),
            ]),
            onChanged: (value) => {getDate(value)},
          ),
          FastTimePicker(
            name: 'Heure de fin',
            labelText: 'Heure de fin',
            validator: Validators.compose([
              Validators.required((value) => 'Heure de fin'),
            ]),
          ),
          FastDropdown<String>(
            onChanged: (value) => {getType(value)},
            name: 'Type de congé',
            labelText: 'Type de congé',
            items: ['Authorization', 'Congé'],
            validator: Validators.compose([
              Validators.required((value) => 'Type de congé obligatoire'),
            ]),
          ),
        ],
      ),
    ];
  }
}
