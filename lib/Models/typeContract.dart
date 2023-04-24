class TypeContract {
  int? id;
  String? label;

  TypeContract({this.id, this.label});

  factory TypeContract.fromJson(Map<String, dynamic> json) {
    return TypeContract(
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