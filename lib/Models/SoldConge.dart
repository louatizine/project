class SoldConge {
  int? id;
  int? employe_id;
  double currentBalance;
  double balanceUse;

  SoldConge({this.id,
    required this.employe_id,
    required this.currentBalance,
    required this.balanceUse,
  });

  factory SoldConge.fromJson(Map<String, dynamic> json) {
    return SoldConge(
      id : json['id'],
      employe_id : json['user_id'],
      currentBalance : json['currentBalance'],
      balanceUse : json['balanceUse'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.employe_id;
    data['currentBalance'] = this.currentBalance;
    data['balanceUse'] = this.balanceUse;

    return data;
  }
}