import 'dart:core';

class EditRequest {
  final int? id;

  final String? firstName;

  final String? lastName;

  final String? adress;

  final String? email;

  final String? tel;

  final DateTime? contactStart;

  final DateTime? contactEnd;

  final int? natureContact_id;

  final String? username;

  final String? password;

  final String? oldPassword;

  final String? role;
  EditRequest({
    this.firstName,
    this.lastName,
    this.adress,
    this.email,
    this.tel,
    this.contactStart,
    this.contactEnd,
    this.natureContact_id,
    this.username,
    this.password,
    this.oldPassword,
    this.role,
    this.id,
  });

  factory EditRequest.fromJson(Map<String, dynamic> json) {
    return EditRequest(
      id: json['id'],
      natureContact_id: json['natureContact_id'],
      firstName: json['firstName'],
      username: json['username'],
      password: json['password'],
      oldPassword: json['oldPassword'],
      role: json['role'],
      lastName: json['lastName'],
      adress: json['adress'],
      email: json['email'],
      tel: json['tel'],
      contactStart: DateTime(json['contactStart'][0], json['contactStart'][1],
          json['contactStart'][2]),
      contactEnd: DateTime(
          json['contactEnd'][0], json['contactEnd'][1], json['contactEnd'][2]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'adress': adress,
      'email': email,
      'tel': tel,
      'contactStart': contactStart != null ? [contactStart!.year, contactStart!.month, contactStart!.day] : null,
      'contactEnd': contactEnd != null ? [contactEnd!.year, contactEnd!.month, contactEnd!.day] : null,
      'natureContact_id': natureContact_id,
      'username': username,
      'password': password,
      'oldPassword': oldPassword,
      'role': role,
    };
  }
}
