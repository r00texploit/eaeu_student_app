import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:student/data/models/certificate_response.dart';
import 'package:student/data/repositories/certificateRepository.dart';
import 'package:student/utils/api.dart';
import 'package:student/utils/uiUtils.dart';

class CertificateTestCubit extends Cubit<CertificateTestState> {
  CertificateRepository? certificateRepository;

  CertificateTestCubit(this.certificateRepository)
      : super(CertificateInitial());
  double? tot;
  // void updateFirstName(String fullName) {
  //   emit(state.copyWith(firstName: fullName));
  // }

  // void updateSecondName(String fullName) {
  //   emit(state.copyWith(secondName: fullName));
  // }

  // void updateThirdName(String fullName) {
  //   emit(state.copyWith(thirdName: fullName));
  // }

  // void updateFourthlName(String fullName) {
  //   emit(state.copyWith(fourthName: fullName));
  // }

  // void updatePhone(String phone) {
  //   emit(state.copyWith(phone: phone));
  // }
  updateTotal(double value) {
    emit(CertificateFetchSuccess(
      total: value,
      selectedCertificateType: [],
      success: 'Certificate order submitted successfully!',
      firstName: '',
      secondName: '',
      thirdName: '',
      fourthName: '',
      phone: '',
    ));
    tot = value;
  }

  Future<Map<String, dynamic>> submitData(
      List<int> multipleSelected,
      String first,
      String second,
      String third,
      String last,
      String phone,
      BuildContext context) async {
    var error;
    if (first.isEmpty) {
      emit(CertificateFetchSuccess(
        total: 0.0,
        phone: '',
        selectedCertificateType: [],
        error: 'Please enter your full name.',
        firstName: '',
        secondName: '',
        thirdName: '',
        fourthName: '',
      ));
      // print("2Certificate order submitted successfully!");
      UiUtils.showCustomSnackBar(
        context: context,
        errorMessage: "Please fill all fields!",
        backgroundColor: Colors.black,
      );
      return {"done": false, "message": "Please fill all fields!"};
    }
    var data = {
      'first_name_en': first,
      'second_name_en': second,
      'third_name_en': third,
      'fourth_name_en': last,
      'phone': phone,
      'ides': multipleSelected,
    };
    try {
      final response = await Api.post(
          url: Api.orderCertificate, body: data, useAuthToken: true);
      if (response["code"] == 200) {
        // print("1Certificate order submitted successfully!");
        emit(CertificateFetchSuccess(
          total: 0.0,
          selectedCertificateType: [],
          success: 'Certificate order submitted successfully!',
          firstName: '',
          secondName: '',
          thirdName: '',
          fourthName: '',
          phone: '',
        ));
        return {
          "done": true,
          "message": 'Certificate order submitted successfully!'
        };
        // UiUtils.showCustomSnackBar(
        //     context: context,
        //     errorMessage: "Certificate order submitted successfully!",
        //     backgroundColor: Colors.black);
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   Routes.home,
        //   (Route<dynamic> route) => false,
        // );
      } else if (response["code"] == 103) {
        error = response['message'];
        print("${error}");
        UiUtils.showCustomSnackBar(
            context: context,
            errorMessage: "${response['message']}",
            backgroundColor: Colors.black);
        emit(CertificateFetchFailure(
          errorMessage: 'An error occurred while submitting the data.',
        ));
      }
    } catch (error) {
      emit(CertificateFetchFailure(
        errorMessage: 'An error occurred while communicating with the API.',
      ));
    }
    return {"done": false, "message": "توجد فاتورة مصدرة و غير مسددة بعد"};
  }

  Future<CertificateResponse>? getCertificate() async {
    try {
      CertificateResponse? result =
          await certificateRepository!.fetchCertificates();
      return result;
    } catch (e) {
      print("certification error: ${e.toString()}");
      return CertificateResponse.fromJson({
        "code": 103,
        "message": "An error occurred while communicating with the API.",
        "data": []
      });
    }
  }
}

abstract class CertificateTestState extends Equatable {
  // CertificateState copyWith({required String phone}) {

  // }
}

class CertificateFetchInProgress extends CertificateTestState {
  @override
  List<Object?> get props => [];
}

class CertificateInitial extends CertificateTestState {
  @override
  List<Object?> get props => [];
}

class CertificateFetchSuccess extends CertificateTestState {
  final List<String>? selectedCertificateType;
  final String firstName, secondName, thirdName, fourthName, phone;
  final double total;
  final String? error;
  final String? success;

  CertificateFetchSuccess({
    required this.total,
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.fourthName,
    required this.phone,
    required this.selectedCertificateType,
    this.error,
    this.success,
  });

  @override
  List<String?> get props => [firstName, secondName, thirdName, fourthName];
}

class CertificateFetchFailure extends CertificateTestState {
  final String errorMessage;

  CertificateFetchFailure({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [];
}
