import 'package:equatable/equatable.dart';
import 'package:student/data/models/paidPayments.dart';
import 'package:student/data/repositories/paidRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StudentPaidDetailsState extends Equatable {}

class StudentPaidDetailsInitial extends StudentPaidDetailsState {
  @override
  List<Object?> get props => [];
}

class StudentPaidDetailsFetchInProgress extends StudentPaidDetailsState {
  @override
  List<Object?> get props => [];
}

class StudentPaidDetailsFetchSuccess extends StudentPaidDetailsState {
  final String? amount;
  final int? id;
  final String? name;
  final String? date;

  StudentPaidDetailsFetchSuccess({
    required this.amount,
    required this.date,
    required this.id,
    required this.name,
  });
  @override
  List<Object?> get props => [name, date, amount];
}

class StudentPaidDetailsFetchFailure extends StudentPaidDetailsState {
  final String errorMessage;

  StudentPaidDetailsFetchFailure(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class StudentPaidDetailsCubit extends Cubit<StudentPaidDetailsState> {
  final PaidRepository _studentRepository;

  StudentPaidDetailsCubit(this._studentRepository)
      : super(StudentPaidDetailsInitial());

  Future<List<PaidData>> getStudentPaidDetails() async {
    try {
      final result = await _studentRepository.fetchPaidPayments();

      emit(
        StudentPaidDetailsFetchSuccess(
            amount: result.first.amount!,
            name: result.first.name!,
            date: result.first.date!,
            id: result.first.id!),
      );
      return result;
    } catch (e) {
      emit(StudentPaidDetailsFetchFailure(e.toString()));
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
