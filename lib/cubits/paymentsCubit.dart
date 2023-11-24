// import 'package:student/data/models/assignment.dart';
import 'package:student/data/models/claimsPayments.dart';
// import 'package:student/data/repositories/assignmentRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/data/repositories/paymentRepository.dart';

abstract class PaymentsState {}

class PaymentsInitial extends PaymentsState {}

class PaymentsFetchInProgress extends PaymentsState {}

class PaymentsFetchSuccess extends PaymentsState {
  final List<ClaimsPaymentData> claimsPayment;
  // final int totalPage; //total page of assignments
  // final int currentPage; //current assignments page
  // final bool moreAssignmentsFetchError;
  // //if subjectId is null then fetch all assignments else fetch assignments based on subjectId
  // final int? subjectId;
  final bool fetchMorePaymentsInProgress;

  PaymentsFetchSuccess({
    required this.claimsPayment,
    // this.subjectId,
    required this.fetchMorePaymentsInProgress,
    // required this.moreAssignmentsFetchError,
    // required this.currentPage,
    // required this.totalPage,
  });

  PaymentsFetchSuccess copyWith({
    List<ClaimsPaymentData>? newClaimsPayments,
    bool? newFetchMorePaymentsInProgress,
    bool? newMorePaymentsFetchError,
    int? newCurrentPage,
    int? newTotalPage,
  }) {
    return PaymentsFetchSuccess(
      // subjectId: subjectId,
      claimsPayment: newClaimsPayments ?? claimsPayment,
      fetchMorePaymentsInProgress:
          newFetchMorePaymentsInProgress ?? fetchMorePaymentsInProgress,
      // moreAssignmentsFetchError:
      //     newMoreAssignmentsFetchError ?? moreAssignmentsFetchError,
      // currentPage: newCurrentPage ?? currentPage,
      // totalPage: newTotalPage ?? totalPage,
    );
  }
}

class PaymentsFetchFailure extends PaymentsState {
  final String errorMessage;
  // final int? page;
  // final int? id;

  PaymentsFetchFailure({
    required this.errorMessage,
    // required this.page,
    // required this.id,
  });
}

class PaymentsCubit extends Cubit<PaymentsState> {
  final PaymentRepository _paymentRepository;

  PaymentsCubit(this._paymentRepository) : super(PaymentsInitial());

  void fetchPayments({
    int? type,
    int? page,
    // int? assignmentId,
    // int? subjectId,
    // required int isSubmitted,
    // required int childId,
    // required bool useParentApi,
  }) {
    emit(PaymentsFetchInProgress());
    _paymentRepository
        .fetchPayments(
          type: type,
          // useParentApi: useParentApi,
          // assignmentId: assignmentId,
          page: page,
          // subjectId: subjectId,
          // isSubmitted: isSubmitted,
        )
        .then(
          (value) => emit(
            PaymentsFetchSuccess(
              fetchMorePaymentsInProgress: false,
              claimsPayment: value,
              // subjectId: subjectId,
              // moreAssignmentsFetchError: false,
              // assignments: value['assignments'],
              // currentPage: value['currentPage'],
              // totalPage: value['totalPage'],
            ),
          ),
        )
        .catchError(
          (e) => emit(
            PaymentsFetchFailure(
              errorMessage: e.toString(),
              // id: e
              // page: page,
              // subjectId: subjectId,
            ),
          ),
        );
  }

  List<ClaimsPaymentData> getClaimPayments() {
    if (state is PaymentsFetchSuccess) {
      return (state as PaymentsFetchSuccess)
          .claimsPayment
          .where((element) => element.id! > 0)
          .toList();
    }
    return [];
  }

  // List<PaymentsHistory> getPaymentsHistory() {
  //   if (state is PaymentsFetchSuccess) {
  //     return (state as PaymentsFetchSuccess)
  //         .assignments
  //         .where((element) => element.assignmentSubmission.id != 0)
  //         .toList();
  //   }
  //   return [];
  // }

  // bool hasMore() {
  //   if (state is PaymentsFetchSuccess) {
  //     return (state as PaymentsFetchSuccess).currentPage <
  //         (state as PaymentsFetchSuccess).totalPage;
  //   }
  //   return false;
  // }

  // Future<void> fetchMorePayments({
  //   required int type,
  //   // required bool useParentApi,
  //   // required int isSubmitted,
  // }) async {
  //   if (state is PaymentsFetchSuccess) {
  //     if ((state as PaymentsFetchSuccess).fetchMorePaymentsInProgress) {
  //       return;
  //     }
  //     try {
  //       emit(
  //         (state as PaymentsFetchSuccess)
  //             .copyWith(newFetchMorePaymentsInProgress: true),
  //       );
  //       //fetch more assignemnts
  //       //more assignment result
  //       final morePaymentsResult = await _paymentRepository.fetchPayments(
  //         // childId: childId,
  //         // useParentApi: useParentApi,
  //         // isSubmitted: isSubmitted,
  //         page: (state as PaymentsFetchSuccess).currentPage + 1,
  //         type: type,
  //       );

  //       final currentState = state as PaymentsFetchSuccess;
  //       // ignore: prefer_final_locals
  //       List<ClaimsPayments> claimPayment = currentState.claimsPayment;

  //       //add more assignments into original assignments list
  //       claimPayment.addAll(morePaymentsResult['data'] as Iterable<ClaimsPayments>);

  //       emit(
  //         PaymentsFetchSuccess(
  //           fetchMorePaymentsInProgress: false,
  //           // subjectId: currentState.subjectId,
  //           claimsPayment: claimPayment,
  //           // moreAssignmentsFetchError: false,
  //           currentPage: morePaymentsResult['currentPage'],
  //           totalPage: morePaymentsResult['totalPage'],
  //         ),
  //       );
  //     } catch (e) {
  //       emit(
  //         (state as PaymentsFetchSuccess).copyWith(
  //           newFetchMorePaymentsInProgress: false,
  //           newMorePaymentsFetchError: true,
  //         ),
  //       );
  //     }
  //   }
  // }

  // void updateAssignments(Assignment assignment) {
  //   if (state is AssignmentsFetchSuccess) {
  //     List<Assignment> updatedAssignments =
  //         (state as AssignmentsFetchSuccess).assignments;
  //     final assignmentIndex = updatedAssignments
  //         .indexWhere((element) => element.id == assignment.id);
  //     if (assignmentIndex != -1) {
  //       updatedAssignments[assignmentIndex] = assignment;
  //       emit(
  //         (state as AssignmentsFetchSuccess)
  //             .copyWith(newAssignments: updatedAssignments),
  //       );
  //     }
  //   }
  // }

  /* Assignment? getSubmittedAssignmentFromReport(int assignmentId) {
    if (state is AssignmentsFetchSuccess) {
      return (state as AssignmentsFetchSuccess).assignments.firstWhere(
          (element) =>
              element.assignmentSubmission.id != 0 &&
              element.id == assignmentId);
    }
    return null;
  } */
}
