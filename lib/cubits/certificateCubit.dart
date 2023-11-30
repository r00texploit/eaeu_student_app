import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/data/models/certificate_response.dart';
import 'package:student/data/repositories/certificateRepository.dart';
import 'package:student/utils/api.dart';

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

  CertificateCubit(this.certificateRepository) : super(CertificateInitial());
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

  // void toggleSelectedCertificateType() {
  //   emit(
  //       state.copyWith(selectedCertificateType: state.selectedCertificateType));
  // }

  // Future<void> submitData(List<int> multipleSelected) async {
  //   if (state.firstName!.isEmpty) {
  //     emit(const CertificateFetchSuccess(
  //       phone: '',
  //       selectedCertificateType: [],
  //       error: 'Please enter your full name.',
  //       firstName: '',
  //       secondName: '',
  //       thirdName: '',
  //       fourthName: '',
  //     ));
  //     return;
  //   }

  //   final dio = Dio();
  //   try {
  //     final response = await dio.post('/api/certificates', data: {
  //       'first_name_en': state.firstName,
  //       'second_name_en': state.secondName,
  //       'third_name_en': state.thirdName,
  //       'fourth_name_en': state.fourthName,
  //       'phone': state.phone,
  //       'ids': multipleSelected,
  //       // 'certificate_type': state.selectedCertificateType,
  //     });

  //     if (response.statusCode == 200) {
  //       emit(const CertificateFetchSuccess(
  //         // fullName: '',
  //         selectedCertificateType: [],
  //         success: 'Certificate order submitted successfully!',
  //         firstName: '',
  //         secondName: '',
  //         thirdName: '',
  //         fourthName: '',
  //         phone: '',
  //       ));
  //     } else {
  //       emit(const CertificateState(
  //         firstName: '',
  //         secondName: '',
  //         thirdName: '',
  //         fourthName: '',
  //         phone: '',
  //         selectedCertificateType: [],
  //         error: 'An error occurred while submitting the data.',
  //       ));
  //     }
  //   } catch (error) {
  //     emit( CertificateFetchFailure(
  //       // firstName: '',
  //       // secondName: '',
  //       // thirdName: '',
  //       // fourthName: '',
  //       // phone: '',
  //       // selectedCertificateType: [],
  //       errorMessage: 'An error occurred while communicating with the API.',
  //     ));
  //   }
  // }

  Future<CertificateResponse>? getCertificate() async {
    // try {
    CertificateResponse? result =
        await certificateRepository!.fetchCertificates();
    return result;
    // } catch (e) {
    //   print("certification error: ${e.toString()}");
    //   // return CertificateResponse();
    // }
  }

  List<String>? selectedCertificateType;
  String? firstName, secondName, thirdName, fourthName, phone;
  String? error;
  String? success;
  Future<void> submitData(List<int> multipleSelected, String first,
      String second, String third, String last,String phone) async {
    if (first.isEmpty) {
      CertificateFetchSuccess(
        phone: '',
        selectedCertificateType: [],
        error: 'Please enter your full name.',
        firstName: '',
        secondName: '',
        thirdName: '',
        fourthName: '',
      );
      print("2Certificate order submitted successfully!");

      return;
    }
    var data = {
      'first_name_en': first,
      'second_name_en': second,
      'third_name_en': third,
      'fourth_name_en': last,
      'phone': phone,
      'ids': multipleSelected,
      // 'certificate_type': state.selectedCertificateType,
    };
    // final dio = Dio();
    try {
      final response = await Api.post(
        url: Api.orderCertificate,
        body: data,
        useAuthToken: true,
      );
      /**
       * Api.orderCertificate, data: {
        'first_name_en': first,
        'second_name_en': second,
        'third_name_en': third,
        'fourth_name_en': last,
        'phone': phone,
        'ids': multipleSelected,
        // 'certificate_type': state.selectedCertificateType,
      },
      options: Options(headers: {})
       */

      if (response["code"] == 200) {
        print("1Certificate order submitted successfully!");
        CertificateFetchSuccess(
          // fullName: '',
          selectedCertificateType: [],
          success: 'Certificate order submitted successfully!',
          firstName: '',
          secondName: '',
          thirdName: '',
          fourthName: '',
          phone: '',
        );
      } else {
        print("3Certificate order submitted successfully!");

        CertificateFetchFailure(
          errorMessage: 'An error occurred while submitting the data.',
        );
      }
    } catch (error) {
      CertificateFetchFailure(
        // firstName: '',
        // secondName: '',
        // thirdName: '',
        // fourthName: '',
        // phone: '',
        // selectedCertificateType: [],
        errorMessage: 'An error occurred while communicating with the API.',
      );
    }
  }

  void updateFirstName(String fullName) {
    copyWith(firstName: fullName);
  }

  void updatePhone(String fullName) {
    copyWith(phone: fullName);
  }

  void updateSecondName(String fullName) {
    copyWith(secondName: fullName);
  }

  void updateThirdName(String fullName) {
    copyWith(thirdName: fullName);
  }

  void updateFourthlName(String fullName) {
    copyWith(fourthName: fullName);
  }

  CertificateFetchSuccess copyWith({
    String? firstName,
    String? secondName,
    String? thirdName,
    String? fourthName,
    String? phone,
    List<String>? selectedCertificateType,
    String? error,
    String? success,
  }) {
    return CertificateFetchSuccess(
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

abstract class CertificateState extends Equatable {}

class CertificateFetchInProgress extends CertificateState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CertificateInitial extends CertificateState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CertificateFetchSuccess extends CertificateState {
  // final String? fullName;
  final List<String>? selectedCertificateType;
  final String? firstName, secondName, thirdName, fourthName, phone;
  final String? error;
  final String? success;

  CertificateFetchSuccess({
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
  // TODO: implement props
  List<String?> get props => [firstName, secondName, thirdName, fourthName];
}

class CertificateFetchFailure extends CertificateState {
  final String errorMessage;
  // final int? page;
  // final int? id;

  CertificateFetchFailure({
    required this.errorMessage,
    // required this.page,
    // required this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
