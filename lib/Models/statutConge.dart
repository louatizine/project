class LeaveStatus {
   int id;
  final String label;

  LeaveStatus({required this.id,
    required this.label});

  factory LeaveStatus.fromJson(Map<String, dynamic> json) {
    return LeaveStatus(
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