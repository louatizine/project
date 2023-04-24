import 'package:flutter/material.dart';
import 'package:gestionConge/Models/departement.dart';
import 'package:gestionConge/Models/function.dart';
import 'package:gestionConge/Models/role.dart';
import 'package:gestionConge/Models/typeContract.dart';

class EmployeInformation {
  final int id;
  final String matricule;
  final String firstName;
  final String lastName;
  final String adress;
  final String email;
  final String tel;
  DateTime contactStart;
  final  DateTime contactEnd;
  late final FunctionEmploye function;
  final Departement departement;
  final TypeContract typeContract;
  final Roles roles;

  EmployeInformation(
      {required this.id,
      required this.matricule,
      required this.firstName,
      required this.lastName,
      required this.adress,
      required this.email,
      required this.tel,
       required  this.contactStart,
       required  this.contactEnd,
      required this.function,
      required this.departement,
      required this.typeContract,
      required this.roles});

  factory EmployeInformation.fromJson(Map<String, dynamic> json) {
    return EmployeInformation(
        id: json['id'],
        matricule: json['matricule'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        adress: json['adress'],
        email: json['email'],
        tel: json['tel'],
        contactStart: DateTime(json['contactStart'][0], json['contactStart'][1], json['contactStart'][2]),
        contactEnd: DateTime(json['contactEnd'][0], json['contactEnd'][1], json['contactEnd'][2]),
        function: FunctionEmploye.fromJson(json['function']),
        departement: Departement.fromJson(json['departement']),
        typeContract: TypeContract.fromJson(json['typeContract']),
        roles: Roles.fromJson(json['roles']));
  }
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data : new Map<String, dynamic>();
    data['id'] : this.id;
    data['matricule'] : this.matricule;
    data['firstName'] : this.firstName;
    data['lastName'] : this.lastName;
    data['adress'] : this.adress;
    data['email'] : this.email;
    data['tel'] : this.tel;
    data['contactStart'] : this.contactStart;
    data['contactEnd'] : this.contactEnd;
    if (this.function !: null) {
      data['function'] : this.function!.toJson();
    }
    if (this.departement !: null) {
      data['departement'] : this.departement!.toJson();
    }
    if (this.typeContract !: null) {
      data['typeContract'] : this.typeContract!.toJson();
    }
    if (this.roles !: null) {
      data['roles'] : this.roles!.toJson();
    }
    return data;
  }*/
}
