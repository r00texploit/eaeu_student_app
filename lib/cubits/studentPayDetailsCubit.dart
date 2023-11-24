import 'package:equatable/equatable.dart';
import 'package:student/cubits/paymentsCubit.dart';
import 'package:student/data/models/claimsPayments.dart';
import 'package:student/data/repositories/paymentRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StudentPayDetailsState extends Equatable {}

class StudentParentDetailsInitial extends StudentPayDetailsState {
  @override
  List<Object?> get props => [];
}

class StudentPayDetailsFetchInProgress extends StudentPayDetailsState {
  @override
  List<Object?> get props => [];
}

class StudentPayDetailsFetchSuccess extends StudentPayDetailsState {
  final String amount;
  final int id;
  final String name;
  final String date;

  StudentPayDetailsFetchSuccess({
    required this.amount,
    required this.date,
    required this.id,
    required this.name,
  });
  @override
  List<Object?> get props => [name, date, amount];
}

class StudentPayDetailsFetchFailure extends StudentPayDetailsState {
  final String errorMessage;

  StudentPayDetailsFetchFailure(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class StudentPayDetailsCubit extends Cubit<StudentPayDetailsState> {
  final PaymentRepository _studentRepository;

  StudentPayDetailsCubit(this._studentRepository)
      : super(StudentParentDetailsInitial());

  Future<List<ClaimsPaymentData>> getStudentPayDetails() async {
    try {
      final result = await _studentRepository.fetchPayments();

      emit(
        StudentPayDetailsFetchSuccess(
            amount: result.first.amount!,
            name: result.first.name!,
            date: result.first.date!,
            id: result.first.id!),
      );
      return result;
    } catch (e) {
      emit(StudentPayDetailsFetchFailure(e.toString()));
      return [];
    }
  }
  // data() async {
  //   final result = await _studentRepository.fetchPayments();
  //   for (var element in result) {

  //   emit(
  //       StudentPayDetailsFetchSuccess(
  //           amount: element.amount!,
  //           name: element.name!,
  //           date: element.date!,
  //           id: element.id!),
  //     );
  //   }
  //   // return (state as StudentPayDetailsFetchSuccess)
  //   //       .claimsPayment
  //   //       .where((element) => element.id! > 0)
  //   //       .toList();
  // }
}
