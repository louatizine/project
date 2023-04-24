class TypeConge {
  final int id;
  final String? label;

  TypeConge({ required this.id, required this.label});

  factory TypeConge.fromJson(Map<String, dynamic> json) {
    return TypeConge(
        id : json['id'],
        label :json['label']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}