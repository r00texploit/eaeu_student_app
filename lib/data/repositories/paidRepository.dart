// import 'package:dio/dio.dart';
// import 'package:student/data/models/assignment.dart';
import 'dart:convert';

import 'package:student/data/models/paidPayments.dart';
import 'package:student/utils/api.dart';

class PaidRepository {
  Future<List<PaidData>> fetchPaidPayments({
    int? page,
    int? type,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        "type": 2 ?? 0,
      };

      final result = await Api.get(
        url: Api.getPaidPayment,
        useAuthToken: true,
        queryParameters: queryParameters,
      );
      print("resp: ${result['data']}");
      return PaidData.parseJson(result);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<List<PaidData>> fetchPaymentsFromResponse(String response) async {
    try {
      final parsedResponse = jsonDecode(response);
      final data = parsedResponse['data'];

      return [
        PaidData(
          id: data['id'],
          name: data['name'],
          amount: data['amount'],
          date: data['date']!,
        ),
      ];
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<PaidData> getpaymentsHistory({
    required int type,
    // required List<String> filePaths,
    // required CancelToken cancelToken,
    // required Function updateUploadAssignmentPercentage,
  }) async {
    try {
      // List<MultipartFile> files = [];
      // for (var filePath in filePaths) {
      //   files.add(await MultipartFile.fromFile(filePath));
      // }
      final result = await Api.get(
          // body: {"type": type},
          url: Api.getPaidData,
          useAuthToken: true,
          queryParameters: {"type": type}
          // cancelToken: cancelToken,
          // onSendProgress: (count, total) {
          //   updateUploadAssignmentPercentage((count / total) * 100);
          // },
          );

      final paymentsHistory = (result['data'] ?? []) as List;

      return PaidData.fromJson(
        Map.from(
          paymentsHistory.isEmpty ? {} : paymentsHistory.first,
        ),
      );
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  // Future<void> deleteAssignment({
  //   required int assignmentSubmissionId,
  // }) async {
  //   try {
  //     await Api.post(
  //       body: {"assignment_submission_id": assignmentSubmissionId},
  //       url: Api.deleteAssignment,
  //       useAuthToken: true,
  //     );
  //   } catch (e) {
  //     throw ApiException(e.toString());
  //   }
  // }
}
