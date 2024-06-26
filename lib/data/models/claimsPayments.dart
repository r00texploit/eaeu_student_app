
class ClaimsPaymentData {
  int? id;
  String? name;
  String? amount;
  String? date;

  ClaimsPaymentData({this.id, this.name, this.amount, this.date});

  factory ClaimsPaymentData.fromJson(Map<String, dynamic> json) {
    return ClaimsPaymentData(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
    );
  }
  static ClaimsPaymentData parseJson(Map<String, dynamic> jsonData) {
    print("object: ${jsonData['data'].runtimeType}");
    // final data = json.decode(jsonData['data']) as List<dynamic>;
    // var data = jsonData['data'] as List<dynamic>;
    // print("object1: ${data.runtimeType}");
    return //data.map((item) =>
     ClaimsPaymentData.fromJson(jsonData['data']);//).toList();
    // return data.map((item) => ClaimsPaymentData.fromJson(item)).toList();
  }
}
