import 'package:student/cubits/paymentsCubit.dart';
import 'package:student/ui/screens/home/cubits/paymentsTabSelectionCubit.dart';
import 'package:student/ui/widgets/customRefreshIndicator.dart';
import 'package:student/ui/widgets/customTabBarContainer.dart';
import 'package:student/ui/widgets/paymentFilterBottomsheetContainer.dart';
import 'package:student/ui/widgets/paymentListContainer.dart';
import 'package:student/ui/widgets/svgButton.dart';
import 'package:student/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:student/ui/widgets/tabBarBackgroundContainer.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PaymentFilters {
  assignedDateLatest,
  assignedDateOldest,
  dueDateLatest,
  dueDateOldest
}

class PaymentsContainer extends StatefulWidget {
  //Need this flag in order to show the assignments container
  //in background when bottm menu is open

  //If it is just for background showing purpose then it will not reactive or not making any api call
  final bool isForBottomMenuBackground;
  const PaymentsContainer({
    Key? key,
    required this.isForBottomMenuBackground,
  }) : super(key: key);

  @override
  State<PaymentsContainer> createState() => _AssignmentsContainerState();
}

class _AssignmentsContainerState extends State<PaymentsContainer> {
  late PaymentFilters selectedPaymentFilter = PaymentFilters.assignedDateLatest;

  late final ScrollController _scrollController = ScrollController()
    ..addListener(_PaymentsScrollListener);

  void _PaymentsScrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      // if (context.read<PaymentsCubit>().hasMore()) {
      //   context.read<PaymentsCubit>().fetchMorePayments(
      //         type: 1,
      //         // isSubmitted: 0,
      //         // useParentApi: context.read<AuthCubit>().isParent(),
      //       );
      //to scroll to last in order for users to see the progress
      Future.delayed(const Duration(milliseconds: 10), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      });
    }
    // }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!widget.isForBottomMenuBackground) {
        fetchPayments();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_PaymentsScrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void fetchPayments() {
    context.read<PaymentsCubit>().fetchPayments(
          type: 1,
          // isSubmitted: context
          //     .read<AssignmentsTabSelectionCubit>()
          //     .isAssignmentSubmitted(),
          // subjectId: context
          //     .read<AssignmentsTabSelectionCubit>()
          //     .state
          //     .assignmentFilterBySubjectId,
          // useParentApi: context.read<AuthCubit>().isParent(),
        );
  }

  void changePaymentFilter(PaymentFilters paymentFilter) {
    setState(() {
      selectedPaymentFilter = paymentFilter;
    });
  }

  void onTapFilterButton() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(UiUtils.bottomSheetTopRadius),
          topRight: Radius.circular(UiUtils.bottomSheetTopRadius),
        ),
      ),
      context: context,
      builder: (_) => PaymentFilterBottomsheetContainer(
        changePaymentFilter: changePaymentFilter,
        initialPaymentFilterValue: selectedPaymentFilter,
      ),
    );
  }

  // Widget _buildMyPaidListContainer() {
  //   return BlocBuilder<PaymentsCubit, PaymentsState>(
  //     builder: (context, state) {
  //       //
  //       List<ClaimsPaymentData> claimsPayments =
  //           context.read<PaymentsCubit>().getClaimPayments();

  //       return BlocBuilder<PaymentsTabSelectionCubit,
  //           PaymentsTabSelectionState>(
  //         bloc: context.read<PaymentsTabSelectionCubit>(),
  //         builder: (context, state) {
  //           return PaymentsDContainer(
  //             cubitAndState: 1,
  //             claimsPayments: claimsPayments,
  //             onTapClaimsPayments: (int subjectId) {
  //               context
  //                   .read<PaymentsTabSelectionCubit>()
  //                   .changePaymentFilterBySubjectId(
  //                     subjectId,
  //                   );
  //               fetchPayments();
  //             },
  //             selectedClaimsPaymentsId: state.paymentFilterById,
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _buildAppBarContainer() {
    return ScreenTopBackgroundContainer(
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return Stack(
            children: [
              BlocBuilder<PaymentsTabSelectionCubit, PaymentsTabSelectionState>(
                builder: (context, state) {
                  return state.paymentFilterTabTitle == submittedKey
                      ? const SizedBox()
                      : Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: UiUtils.screenContentHorizontalPadding,
                            ),
                            child: SvgButton(
                              onTap: () {
                                onTapFilterButton();
                              },
                              svgIconUrl:
                                  UiUtils.getImagePath("filter_icon.svg"),
                            ),
                          ),
                        );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  UiUtils.getTranslatedLabel(context, paidKey),
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: UiUtils.screenTitleFontSize,
                  ),
                ),
              ),
              BlocBuilder<PaymentsTabSelectionCubit, PaymentsTabSelectionState>(
                bloc: context.read<PaymentsTabSelectionCubit>(),
                builder: (context, state) {
                  return AnimatedAlign(
                    curve: UiUtils.tabBackgroundContainerAnimationCurve,
                    duration: UiUtils.tabBackgroundContainerAnimationDuration,
                    alignment: state.paymentFilterTabTitle == paidKey
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.centerEnd,
                    child: TabBarBackgroundContainer(
                      boxConstraints: boxConstraints,
                    ),
                  );
                },
              ),
              BlocBuilder<PaymentsTabSelectionCubit, PaymentsTabSelectionState>(
                bloc: context.read<PaymentsTabSelectionCubit>(),
                builder: (context, state) {
                  return CustomTabBarContainer(
                    boxConstraints: boxConstraints,
                    alignment: AlignmentDirectional.centerStart,
                    isSelected: state.paymentFilterTabTitle == paidKey,
                    onTap: () {
                      context
                          .read<PaymentsTabSelectionCubit>()
                          .changePaymentFilterTabTitle(paidKey);
                      fetchPayments();
                    },
                    titleKey: paidKey,
                  );
                },
              ),
              BlocBuilder<PaymentsTabSelectionCubit, PaymentsTabSelectionState>(
                bloc: context.read<PaymentsTabSelectionCubit>(),
                builder: (context, state) {
                  return CustomTabBarContainer(
                    boxConstraints: boxConstraints,
                    alignment: AlignmentDirectional.centerEnd,
                    isSelected: state.paymentFilterTabTitle == paidKey,
                    onTap: () {
                      context
                          .read<PaymentsTabSelectionCubit>()
                          .changePaymentFilterTabTitle(paidKey);
                      fetchPayments();
                    },
                    titleKey: paidKey,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomRefreshIndicator(
          displacment: UiUtils.getScrollViewTopPadding(
            context: context,
            appBarHeightPercentage: UiUtils.appBarBiggerHeightPercentage,
          ),
          onRefreshCallback: () {
            fetchPayments();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: UiUtils.getScrollViewTopPadding(
                context: context,
                appBarHeightPercentage: UiUtils.appBarBiggerHeightPercentage,
              ),
              bottom: UiUtils.getScrollViewBottomPadding(context),
            ),
            child: Column(
              children: [
                // _buildMyPaidListContainer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.035),
                ),
                BlocBuilder<PaymentsTabSelectionCubit,
                    PaymentsTabSelectionState>(
                  builder: (context, state) {
                    return PaymentListContainer(
                      animateItems: !widget
                          .isForBottomMenuBackground, //if it's just for background don't animate items
                      paymentTabTitle: state.paymentFilterTabTitle,
                      currentSelectedId: state.paymentFilterById,
                      // selectedPaymentFilter: selectedPaymentFilter,
                      // isAssignmentSubmitted: context
                      //     .read<AssignmentsTabSelectionCubit>()
                      //     .isAssignmentSubmitted(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _buildAppBarContainer(),
        )
      ],
    );
  }
}
