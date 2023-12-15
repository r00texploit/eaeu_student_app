import 'package:student/utils/labelKeys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTabSelectionState {
  //Assigned or completed
  final String paymentFilterTabTitle;
  final int paymentFilterById;

  PaymentsTabSelectionState({
    required this.paymentFilterById,
    required this.paymentFilterTabTitle,
  });
}

class PaymentsTabSelectionCubit extends Cubit<PaymentsTabSelectionState> {
  PaymentsTabSelectionCubit()
      : super(
          PaymentsTabSelectionState(
            paymentFilterById: 0,
            paymentFilterTabTitle: paidKey,
          ),
        ); //Not-submitted/Assigned by default

  void changePaymentFilterTabTitle(String paymentFilterTabTitle) {
    emit(
      PaymentsTabSelectionState(
        paymentFilterById: state.paymentFilterById,
        paymentFilterTabTitle: paymentFilterTabTitle,
      ),
    );
  }

  void changePaymentFilterBySubjectId(int paymentFilterById) {
    emit(
      PaymentsTabSelectionState(
        paymentFilterById: paymentFilterById,
        paymentFilterTabTitle: state.paymentFilterTabTitle,
      ),
    );
  }

  // int isAmentSubmitted() {
  //   return state.paymentFilterTabTitle == "amount" ? 0 : 1;
  // }
}
