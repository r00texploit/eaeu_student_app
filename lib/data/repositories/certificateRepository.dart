import 'package:student/data/models/certificate_response.dart';
import 'package:student/utils/api.dart';

class CertificateRepository {
  Future<CertificateResponse> fetchCertificates() async {
    try {
      Map<String, dynamic> queryParameters = {
        // "type": 2 ?? 0,
      };
      // Additional logic specific to certificate fetching can be added here
      final result = await Api.get(
        url: Api.getCertificateType,
        useAuthToken: true,
        queryParameters: queryParameters,
      );
      print("getCertificateType: ${result['data']}");
      return CertificateResponse.fromJson(result);
    } catch (e) {
      // Handle any errors that occur during the fetching process
      throw Exception('Failed to fetch certificates: $e');
    }
  }
}
