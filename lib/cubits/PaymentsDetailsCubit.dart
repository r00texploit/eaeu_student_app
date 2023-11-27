import 'package:equatable/equatable.dart';
import 'package:student/data/models/paymentsDetails.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/data/repositories/paymentDetailsRepository.dart';

abstract class PaymentsDetailsState extends Equatable {}

class PaymentsDetailsInitial extends PaymentsDetailsState {
  @override
  List<Object?> get props => [];
}

class PaymentsDetailsFetchInProgress extends PaymentsDetailsState {
  @override
  List<Object?> get props => [];
}

class PaymentsDetailsFetchSuccess extends PaymentsDetailsState {
  final String? reg_fees;
  final String? card_fees;
  final String? study_fees;
  final String? mor_fees;
  final String? later_fees;
  final String? it_fees;
  final String? other_fees;
  final String? certf_fees;
  final String? statment_fees;
  final String? resignation_fees;
  final String? total;

  PaymentsDetailsFetchSuccess(
      {this.card_fees,
      this.certf_fees,
      this.it_fees,
      this.later_fees,
      this.mor_fees,
      this.other_fees,
      this.reg_fees,
      this.resignation_fees,
      this.statment_fees,
      this.study_fees,
      this.total});
  @override
  List<Object?> get props => [
        card_fees,
        it_fees,
        certf_fees,
        later_fees,
        mor_fees,
        other_fees,
        reg_fees,
        resignation_fees,
        statment_fees,
        statment_fees,
        total
      ];
}

class PaymentsDetailsFetchFailure extends PaymentsDetailsState {
  final String errorMessage;

  PaymentsDetailsFetchFailure(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class PaymentsDetailsCubit extends Cubit<PaymentsDetailsState> {
  final PaymentDetailsRepository _studentRepository;

  PaymentsDetailsCubit(this._studentRepository)
      : super(PaymentsDetailsInitial());

  getPaymentDetails(int type, int id, bool isPaid) async {
    try {
      final result =
          await _studentRepository.fetchPaymentsDetails(type: type, id: id,is_paid: isPaid);

      emit(
        PaymentsDetailsFetchSuccess(
          reg_fees: result.reg_fees ?? "",
          card_fees: result.card_fees ?? "",
          study_fees: result.study_fees ?? "",
          mor_fees: result.mor_fees ?? "",
          later_fees: result.later_fees ?? "",
          it_fees: result.it_fees ?? "",
          other_fees: result.other_fees ?? "",
          certf_fees: result.certf_fees ?? "",
          statment_fees: result.statment_fees ?? "",
          resignation_fees: result.resignation_fees ?? "",
          total: result.total ?? "",
        ),
      );
      return result;
    } catch (e) {
      emit(PaymentsDetailsFetchFailure(e.toString()));
      return PaymentsDetails();
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
