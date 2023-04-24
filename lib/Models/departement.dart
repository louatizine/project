class Departement {
 final int? id;
  final String label;

  Departement({this.id,  required this.label});

 factory Departement.fromJson(Map<String, dynamic> json) {
      return Departement(
          id: json['id'],
          label :json['label'],
      );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}