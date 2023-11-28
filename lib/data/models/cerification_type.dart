import 'package:json_serializable/json_serializable.dart';

part 'certificate_response.g.dart';

@JsonSerializable()
class CertificateResponse {
  bool error;
  String message;
  List<Certificate> data;
  int code;

  CertificateResponse({
    required this.error,
    required this.message,
    required this.data,
    required this.code,
  });

  factory CertificateResponse.fromJson(Map<String, dynamic> json) =>
      _$CertificateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateResponseToJson(this);
}

@JsonSerializable()
class Certificate {
  int id;
  String name;
  String minPrice;

  Certificate({
    required this.id,
    required this.name,
    required this.minPrice,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateToJson(this);
}
