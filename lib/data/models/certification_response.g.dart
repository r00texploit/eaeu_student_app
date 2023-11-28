// GENERATED CODE - DO NOT MODIFY

part of 'certificate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

@Serializable()
class CertificateResponse with _$CertificateResponseSerializerMixin {
  bool error;
  String message;
  List<Certificate> data;
  int code;

  Map<String, dynamic> toJson() => _$CertificateResponseToJson(this);

  @override
  String toString() => jsonEncode(this);
}

@Serializable()
class Certificate with _$CertificateSerializerMixin {
  int id;
  String name;
  String minPrice;

  Map<String, dynamic> toJson() => _$CertificateToJson(this);

  @override
  String toString() => jsonEncode(this);
}
