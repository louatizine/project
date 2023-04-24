class FunctionEmploye {
  int? id;
  String label;

  FunctionEmploye({this.id, required this.label});

  factory FunctionEmploye.fromJson(Map<String, dynamic> json) {
    return FunctionEmploye(
    id : json['id'],
    label : json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}