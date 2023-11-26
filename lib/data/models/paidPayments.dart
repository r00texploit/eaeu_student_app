import 'dart:convert';

class PaidData {
  int? id;
  String? name;
  String? amount;
  String? date;

  PaidData({this.id, this.name, this.amount, this.date});

  factory PaidData.fromJson(Map<String, dynamic> json) {
    return PaidData(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
    );
  }
  static List<PaidData> parseJson(Map<String, dynamic> jsonData) {
    print("object: ${jsonData['data'].runtimeType}");
    // final data = json.decode(jsonData['data']) as List<dynamic>;
    var data = jsonData['data'] as List<dynamic>;
    // print("object1: ${data.runtimeType}");
    // return //data.map((item) =>
    //  PaidData.fromJson(jsonData['data']);//).toList();
    return data.map((item) => PaidData.fromJson(item)).toList();
  }
}
