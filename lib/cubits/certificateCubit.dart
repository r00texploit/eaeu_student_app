import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/data/models/certificate_response.dart';
import 'package:student/data/repositories/certificateRepository.dart';

class CertificateCubit extends Cubit<CertificateState> {
  // CertificateCubit()
  //     : super(const CertificateState(
  //           selectedCertificateType: [],
  //           firstName: '',
  //           secondName: '',
  //           thirdName: '',
  //           fourthName: '',
  //           phone: ''));
  CertificateRepository? certificateRepository;

  CertificateCubit(this.certificateRepository)
      : super(const CertificateState(
            selectedCertificateType: [],
            firstName: '',
            secondName: '',
            thirdName: '',
            fourthName: '',
            phone: ''));
  void updateFirstName(String fullName) {
    emit(state.copyWith(firstName: fullName));
  }

  void updateSecondName(String fullName) {
    emit(state.copyWith(secondName: fullName));
  }

  void updateThirdName(String fullName) {
    emit(state.copyWith(thirdName: fullName));
  }

  void updateFourthlName(String fullName) {
    emit(state.copyWith(fourthName: fullName));
  }

  void toggleSelectedCertificateType() {
    emit(
        state.copyWith(selectedCertificateType: state.selectedCertificateType));
  }

  Future<void> submitData(List<int> multipleSelected) async {
    if (state.firstName!.isEmpty) {
      emit(const CertificateState(
        phone: '',
        selectedCertificateType: [],
        error: 'Please enter your full name.',
        firstName: '',
        secondName: '',
        thirdName: '',
        fourthName: '',
      ));
      return;
    }

    final dio = Dio();
    try {
      final response = await dio.post('/api/certificates', data: {
        'first_name_en': state.firstName,
        'second_name_en': state.secondName,
        'third_name_en': state.thirdName,
        'fourth_name_en': state.fourthName,
        'phone': state.phone,
        'ids': multipleSelected,
        // 'certificate_type': state.selectedCertificateType,
      });

      if (response.statusCode == 200) {
        emit(const CertificateState(
          // fullName: '',
          selectedCertificateType: [],
          success: 'Certificate order submitted successfully!',
          firstName: '',
          secondName: '',
          thirdName: '',
          fourthName: '',
          phone: '',
        ));
      } else {
        emit(const CertificateState(
          firstName: '',
          secondName: '',
          thirdName: '',
          fourthName: '',
          phone: '',
          selectedCertificateType: [],
          error: 'An error occurred while submitting the data.',
        ));
      }
    } catch (error) {
      emit(const CertificateState(
        firstName: '',
        secondName: '',
        thirdName: '',
        fourthName: '',
        phone: '',
        selectedCertificateType: [],
        error: 'An error occurred while communicating with the API.',
      ));
    }
  }

  Future<CertificateResponse> getCertificate() async {
    // try {
    CertificateResponse result =
        await certificateRepository!.fetchCertificates();
    return result;
    // } catch (e) {
    //   print("certification error: ${e.toString()}");
    //   // return CertificateResponse();
    // }
  }
}

class CertificateState {
  // final String? fullName;
  final List<String>? selectedCertificateType;
  final String? firstName, secondName, thirdName, fourthName, phone;
  final String? error;
  final String? success;

  const CertificateState({
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.fourthName,
    required this.phone,
    required this.selectedCertificateType,
    this.error,
    this.success,
  });

  CertificateState copyWith({
    String? firstName,
    secondName,
    thirdName,
    fourthName,
    phone,
    List<String>? selectedCertificateType,
    String? error,
    String? success,
  }) {
    return CertificateState(
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      thirdName: thirdName ?? this.thirdName,
      fourthName: fourthName ?? this.fourthName,
      phone: phone ?? this.phone,
      selectedCertificateType:
          selectedCertificateType ?? this.selectedCertificateType,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }
}
