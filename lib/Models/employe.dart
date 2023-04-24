class Employe {
  final int id;
  final String matricule;
  final String firstName;
  final String lastName;
  final String adress;
  final String email;
  final String tel;
 // final DateTime contactStart;
 // final DateTime contactEnd;
  final String role;
  final String function;
  final String departement;
  final String typeContract;
  final int compte;

  Employe({
    required this.id,
    required this.matricule,
    required this.firstName,
    required  this.lastName,
    required  this.adress,
    required  this.email,
    required  this.tel,
  //  required  this.contactStart,
   // required   this.contactEnd,
    required    this.role,
    required    this.function,
    required    this.departement,
    required   this.typeContract,
    required   this.compte}
      );

  factory Employe.fromJson(Map<String, dynamic> json) {
    return Employe(
        id: json['id'],
        matricule: json['matricule'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        adress: json['adress'],
        email: json['email'],
        tel: json['tel'],
       // contactStart: json['contactStart'],
       // contactEnd: json['contactEnd'],
        role: json['role'],
        function: json['function'],
        departement: json['departement'],
        typeContract: json['typeContract'],
        compte: json['compte']

    );
  }

}
