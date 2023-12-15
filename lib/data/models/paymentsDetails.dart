
class PaymentsDetails {
  // int? id;
  String? reg_fees;
  String? card_fees;
  String? study_fees;
  String? mor_fees;
  String? later_fees;
  String? it_fees;
  String? other_fees;
  String? certf_fees;
  String? statment_fees;
  String? resignation_fees;
  String? total;

  PaymentsDetails(
      {this.card_fees,//
      this.certf_fees,//
      this.it_fees,//
      this.later_fees,//
      this.mor_fees,//
      this.other_fees,
      this.reg_fees,
      this.resignation_fees,
      this.statment_fees,
      this.study_fees,
      this.total});

  factory PaymentsDetails.fromJson(Map<String, dynamic> json) {
    return PaymentsDetails(
      // id: json['id'],
      reg_fees: json['reg_fees'],
      card_fees: json['card_fees'],
      study_fees: json['study_fees'] ?? "",
      mor_fees: json['mor_fees'],
      later_fees: json['later_fees'],
      it_fees: json['it_fees'],
      other_fees: json['other_fees'],
      certf_fees: json['certf_fees'],
      statment_fees: json['statment_fees'],
      resignation_fees: json['resignation_fees'],
      total: json['total'],
    );
  }
  static List<PaymentsDetails> parseJson(Map<String, dynamic> jsonData) {
    print("object: ${jsonData['data']}");
    var data = jsonData['data'] as List<dynamic>;
    return data.map((item) => PaymentsDetails.fromJson(item)).toList();
  }
}
/**
 * 
 *      "reg_fees": "500.00",
        "card_fees": "0.00",
        "study_fees": "0.00",
        "mor_fees": "0.00",
        "later_fees": "0.00",
        "it_fees": "0.00",
        "other_fees": "0.00",
        "certf_fees": "0.00",
        "statment_fees": "0.00",
        "resignation_fees": "0.00",
        "total": "500.00"
 */
