import 'package:student/app/routes.dart';
import 'package:student/cubits/assignmentsCubit.dart';
import 'package:student/cubits/paymentsCubit.dart';
import 'package:student/data/models/claimsPayments.dart';
import 'package:student/data/models/payments.dart';
import 'package:student/ui/screens/home/cubits/paymentsTabSelectionCubit.dart';
import 'package:student/ui/widgets/customShimmerContainer.dart';
import 'package:student/ui/widgets/errorContainer.dart';
import 'package:student/ui/widgets/noDataContainer.dart';
import 'package:student/ui/widgets/shimmerLoadingContainer.dart';
import 'package:student/utils/animationConfiguration.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentListContainer extends StatelessWidget {
  final String paymentTabTitle;
  final int? childId;
  final int currentSelectedId;
  // final PaymentFilters selectedPaymentFilter;
  // final int isAssignmentSubmitted;
  final bool animateItems;
  const PaymentListContainer({
    Key? key,
    required this.paymentTabTitle,
    required this.currentSelectedId,
    this.childId,
    // required this.selectedPaymentFilter,
    // required this.isAssignmentSubmitted,
    this.animateItems = true,
  }) : super(key: key);

  Widget _buildShimmerLoadingAssignmentContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        bottom: 20,
        left: MediaQuery.of(context).size.width * (0.075),
        right: MediaQuery.of(context).size.width * (0.075),
      ),
      height: 90,
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return ShimmerLoadingContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmerContainer(
                  borderRadius: 10,
                  height: boxConstraints.maxHeight,
                  width: boxConstraints.maxWidth * (0.26),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: boxConstraints.maxHeight * (0.075),
                    ),
                    CustomShimmerContainer(
                      borderRadius: 10,
                      width: boxConstraints.maxWidth * (0.6),
                    ),
                    SizedBox(
                      height: boxConstraints.maxHeight * (0.075),
                    ),
                    CustomShimmerContainer(
                      height: 8,
                      borderRadius: 10,
                      width: boxConstraints.maxWidth * (0.45),
                    ),
                    const Spacer(),
                    CustomShimmerContainer(
                      height: 8,
                      borderRadius: 10,
                      width: boxConstraints.maxWidth * (0.3),
                    ),
                    SizedBox(
                      height: boxConstraints.maxHeight * (0.075),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // List<Assignment> _getPaymentsByFilters(
  //   List<ClaimsPayments> claimsPayment,
  // ) {
  //   List<ClaimsPayments> sortedPayments = claimsPayment;
  //   if (selectedPaymentFilter == PaymentFilters.dueDateLatest) {
  //     sortedPayments
  //         .sort((first, second) => second.dueDate.compareTo(first.dueDate));
  //   } else if (selectedAssignmentFilter == AssignmentFilters.dueDateOldest) {
  //     sortedAssignments
  //         .sort((first, second) => first.dueDate.compareTo(second.dueDate));
  //   } else if (selectedAssignmentFilter ==
  //       AssignmentFilters.assignedDateLatest) {
  //     sortedAssignments
  //         .sort((first, second) => second.createdAt.compareTo(first.createdAt));
  //   } else if (selectedAssignmentFilter ==
  //       AssignmentFilters.assignedDateOldest) {
  //     sortedAssignments
  //         .sort((first, second) => first.createdAt.compareTo(second.createdAt));
  //   }

  //   return sortedAssignments;
  // }

  Widget _buildPaymentContainer({
    required ClaimsPaymentData claimsPayments,
    required BuildContext context,
    required int index,
    // required int totalPayments,
    // required bool hasMorePayments,
    // required bool hasMoreAssignmentsInProgress,
    // required bool fetchMoreAssignmentsFailure,
  }) {
    // final bool assginmentSubmitted = claimsPayments.assignmentSubmission.id != 0;

    return Column(
      children: [
        Animate(
          effects:
              animateItems ? listItemAppearanceEffects(itemIndex: index) : null,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed<ClaimsPayments>(Routes.assignment,
                  arguments: claimsPayments);
              //     .then((assignment) {
              //   if (assignment != null) {
              //     context
              //         .read<PaymentsCubit>()
              //         .updateAssignments(assignment);
              //   }
              // });
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(
                bottom: 20.0,
                start: MediaQuery.of(context).size.width * (0.15),
                end: MediaQuery.of(context).size.width * (0.075),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  // final assignmentSubmittedStatusKey =
                  //     UiUtils.getAssignmentSubmissionStatusKey(
                  //   claimsPayments.PaymentSubmission.status,
                  // );
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // PositionedDirectional(
                      //   top: boxConstraints.maxHeight * (0.5) -
                      //       boxConstraints.maxWidth * (0.118),
                      //   start: boxConstraints.maxWidth * (-0.125),
                      //   child: SubjectImageContainer(
                      //     showShadow: true,
                      //     animate: animateItems,
                      //     height: boxConstraints.maxWidth * (0.235),
                      //     radius: 10,
                      //     subject: claimsPayments.name,
                      //     width: boxConstraints.maxWidth * (0.26),
                      //   ),
                      // ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: boxConstraints.maxWidth * (0.175),
                            top: boxConstraints.maxHeight * (0.125),
                            bottom: boxConstraints.maxHeight * (0.075),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: boxConstraints.maxWidth * 0.52,
                                    child: Text(
                                      claimsPayments.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  // !assginmentSubmitted
                                  //     ?
                                  Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    width: boxConstraints.maxWidth * (0.25),
                                    child: Text(
                                      claimsPayments.date!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.5,
                                      ),
                                    ),
                                  ),
                                  // :
                                  //  claimsPayments.amount.isEmpty
                                  //     ? const SizedBox()
                                  //     : Container(
                                  //         alignment: Alignment.center,
                                  //         width: boxConstraints.maxWidth *
                                  //             (0.27),
                                  //         decoration: BoxDecoration(
                                  //           color: assignmentSubmittedStatusKey ==
                                  //                   acceptedKey
                                  //               ? Theme.of(context)
                                  //                   .colorScheme
                                  //                   .onPrimary
                                  //               : assignmentSubmittedStatusKey ==
                                  //                           inReviewKey ||
                                  //                       assignmentSubmittedStatusKey ==
                                  //                           resubmittedKey
                                  //                   ? Theme.of(context)
                                  //                       .colorScheme
                                  //                       .primary
                                  //                   : Theme.of(context)
                                  //                       .colorScheme
                                  //                       .error,
                                  //           borderRadius:
                                  //               BorderRadius.circular(2.5),
                                  //         ),
                                  //         padding:
                                  //             const EdgeInsets.symmetric(
                                  //           vertical: 2,
                                  //         ),
                                  //         child: Text(
                                  //           UiUtils.getTranslatedLabel(
                                  //             context,
                                  //             assignmentSubmittedStatusKey,
                                  //           ), //
                                  //           maxLines: 1,
                                  //           overflow: TextOverflow.ellipsis,
                                  //           style: TextStyle(
                                  //             fontSize: 10.75,
                                  //             color: Theme.of(context)
                                  //                 .scaffoldBackgroundColor,
                                  //           ),
                                  //         ),
                                  //       ),
                                ],
                              ),
                              SizedBox(
                                height: boxConstraints.maxHeight *
                                    (claimsPayments.amount!.isEmpty ? 0 : 0.05),
                              ),
                              claimsPayments.name!.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      claimsPayments.name!,
                                      //if assignment subject is selected then maxLines should be 2 else it is 1,
                                      maxLines:
                                          claimsPayments.name!.length >= 20
                                              ? 2
                                              : 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 1.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0,
                                      ),
                                    ),
                              SizedBox(
                                height: boxConstraints.maxHeight * (0.075),
                              ),
                              claimsPayments.amount!.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      claimsPayments.amount!,
                                      // ? assignment
                                      //     .subject.subjectNameWithType
                                      // : assignment.subject.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 1.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.0,
                                      ),
                                    ),
                              const Spacer(),
                              Text(
                                // UiUtils.formatAssignmentDueDate(
                                claimsPayments.date!,
                                // context,
                                // ),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.5,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        //show assignment loading container after last assinment container
        // if (index == (totalPayments - 1) && hasMorePayments)
        //   _buildShimmerLoadingAssignmentContainer(context),

        // if (index == (totalPayments - 1) && hasMorePayments
        //     // &&
        //     // fetchMoreAssignmentsFailure
        //     )
        // Center(
        //   child: CupertinoButton(
        //     child: Text(UiUtils.getTranslatedLabel(context, retryKey)),
        //     onPressed: () {
        //       context.read<PaymentsCubit>().fetchMorePayments(
        //             type: childId ?? 1,
        //             // isSubmitted: isAssignmentSubmitted,
        //             // useParentApi: context.read<AuthCubit>().isParent(),
        //           );
        //     },
        //   ),
        // )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsTabSelectionCubit, PaymentsTabSelectionState>(
      builder: (context, state) {
        if (state is PaymentsFetchSuccess) {
          //fetch assignments based on assignment selected assignment tab type
          ClaimsPaymentData? claimsPayments = //= paymentTabTitle == paidKey
              context.read<PaymentsCubit>().getClaimPayments();
          // : context.read<AssignmentsCubit>().getSubmittedAssignments();

          //fetch assginemnt based on applied filters
          //filters applied only for assgined tab
          // if (paymentTabTitle == assignedKey) {
          //   assignments = _getAssignmentsByAssignmentFilters(assignments);
          // }

          return claimsPayments.amount! == "0"
              ? NoDataContainer(
                  titleKey: paymentTabTitle == assignedKey
                      ? noAssignmentsToSubmitKey
                      : notSubmittedAnyAssignmentKey,
                  animate: animateItems,
                )
              : Column(
                  children: List.generate(3, (index) => index)
                      .map(
                        (index) => _buildPaymentContainer(
                          context: context,
                          // hasMorePayments:
                          //     state.fetchMorePayments,
                          claimsPayments: claimsPayments,
                          // totalPayments: claimsPayments.,
                          index: index,
                          // hasMorePayments:
                          //     context.read<PaymentsCubit>().hasMore(),
                          // fetchMoreAssignmentsFailure:
                          //     context.read<PaymentsCubit>().hasMore(),
                          // claimsPayments: claim,
                        ),
                      )
                      .toList(),
                );
        }
        if (state is AssignmentsFetchFailure) {
          return Center(
            child: ErrorContainer(
              onTapRetry: () {
                context.read<PaymentsCubit>().fetchPayments(
                      // page: state.page,
                      // subjectId: state.subjectId,
                      type: childId ?? 1,
                      // isSubmitted: isAssignmentSubmitted,
                      // useParentApi: context.read<AuthCubit>().isParent(),
                    );
              },
              animate: animateItems,
              errorMessageCode: "error",
            ),
          );
        }

        return Column(
          children: List.generate(
            UiUtils.defaultShimmerLoadingContentCount,
            (index) => _buildShimmerLoadingAssignmentContainer(context),
          ),
        );
      },
    );
  }
}
