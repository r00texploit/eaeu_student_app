class ClaimsPayments {
  ClaimsPayments({
    required this.id,
    required this.amount,
    required this.date,
    required this.name,
  });

  int? id;
  String? amount;
  String? date;
  String? name;

  ClaimsPayments.fromJson(Map<String, dynamic> json) {
    id = json['id']; // ?? 0;
    date = json['date']; // ?? "";
    amount = json['amount']; // ?? "";
    name = json['name']; //?? "";
  }
}

class PaymentsHistory {
  PaymentsHistory(
      {required this.id,
      required this.amount,
      required this.date,
      required this.name,
      required this.accounter_name});

  late final int id;
  late final String amount;
  late final String date;
  late final String name;
  late final String accounter_name;

  PaymentsHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    date = json['date'] ?? "";
    amount = json['amount'] ?? "";
    name = json['name'] ?? "";
    accounter_name = json['accounter'] ?? "";
  }
}
