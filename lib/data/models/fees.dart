class ChildFees {
  List<FeesData> compulsoryFeesData;
  List<FeesData> optionalFeesData;
  List<FeesData> installmentData;
  double compulsoryFeesTotal;
  double optionalFeesTotal;
  bool isAnotherFeeTransactionPending;
  DateTime? compulsoryFeesDueDate;
  double? compulsoryFeesDueCharges;

  ChildFees({
    required this.compulsoryFeesData,
    required this.optionalFeesData,
    required this.installmentData,
    required this.compulsoryFeesTotal,
    required this.optionalFeesTotal,
    this.compulsoryFeesDueDate,
    this.compulsoryFeesDueCharges,
    required this.isAnotherFeeTransactionPending,
  });

  factory ChildFees.fromJson(Map<String, dynamic> json) {
    return ChildFees(
      compulsoryFeesData: json['compulsory_fees_data']
          .map<FeesData>((e) => FeesData.fromJson(e))
          .toList(),
      optionalFeesData: json['optional_fees_data']
          .map<FeesData>((e) => FeesData.fromJson(e))
          .toList(),
      installmentData: json['installment_data']
          .map<FeesData>((e) => FeesData.fromJson(e))
          .toList(),
      compulsoryFeesTotal:
          double.tryParse(json['compulsory_fees_total'].toString()) ?? 0,
      optionalFeesTotal:
          double.tryParse(json['optional_fees_total'].toString()) ?? 0,
      compulsoryFeesDueDate:
          DateTime.tryParse(json['compulsory_due_date'].toString()),
      compulsoryFeesDueCharges:
          double.tryParse(json['compulsory_due_charges'].toString()),
      isAnotherFeeTransactionPending: json['is_fee_pending'].toString() == '1',
    );
  }
}

class FeesData {
  int id;
  String name;
  bool isPaid;
  bool isDue;
  double? dueChargesAmount;
  double? amount;
  DateTime? dueDate;
  DateTime? paidDate;
  double? dueChargesInPercentage;
  double? dueChargesPaid;

  FeesData({
    required this.id,
    required this.name,
    this.isPaid = false,
    this.isDue = false,
    this.dueChargesAmount,
    this.paidDate,
    this.dueDate,
    this.dueChargesInPercentage,
    this.dueChargesPaid,
    this.amount,
  });

  factory FeesData.fromJson(Map<String, dynamic> json) {
    final today = DateTime.now();
    final dueDate = json.containsKey('due_date')
        ? DateTime.tryParse(json['due_date'])
        : null;
    final isPaid = json['is_paid'].toString() == "1";
    return FeesData(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? "",
      // ignore: avoid_bool_literals_in_conditional_expressions
      isDue: dueDate == null ? false : today.isAfter(dueDate),
      dueChargesPaid:
          isPaid ? double.tryParse(json['paid_due_charges'].toString()) : null,
      isPaid: isPaid,
      paidDate: isPaid
          ? DateTime.tryParse(json['paid_date'].toString()) ??
              DateTime.tryParse(json['paid_on'].toString())
          : null,
      amount: json.containsKey('amount')
          ? double.tryParse(json['amount'].toString())
          : null,
      dueDate: dueDate,
      dueChargesInPercentage: json.containsKey('due_charges')
          ? double.tryParse(json['due_charges'].toString())
          : null,
    );
  }
}

// class Fees {
//   int? id;
//   String? name;
//   String? description;
//   late bool isOptional;
//   double? amount;
//   double? dueCharges;
//   bool? isDueData;
//   Fees(
//       {this.id,
//       this.name,
//       this.description,
//       this.isOptional = false,
//       this.dueCharges,
//       this.isDueData = false,
//       this.amount});

//   Fees.fromFeesJson(Map<String, dynamic> json, {bool dueData = false}) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     isOptional = ((json['choiceable'] == 0 || dueData == true) ? false : true);
//     amount = (json['amount'] != null)
//         ? double.parse(json['amount'].toString())
//         : 0.0;
//     isDueData = dueData;
//     dueCharges = dueData ? double.parse(json['due_charges'].toString()) : 0.0;
//   }
// }

// class feesDue {
//   late final String dueDate;
//   double? dueCharges;

//   feesDue(this.dueDate, this.dueCharges);
//   feesDue.fromJson(Map<String, dynamic> json) {
//     dueCharges = double.parse(json['due_charges'].toString());
//     dueDate = json['due_date'].toString();
//   }
// }
