import 'package:student/data/models/claimsPayments.dart';
import 'package:flutter/material.dart';

//It must be child of AssignmentsCibit
class PaymentsDContainer extends StatefulWidget {
  final List<ClaimsPaymentData> claimsPayments;
  final Function(int) onTapClaimsPayments;
  final int selectedClaimsPaymentsId;
  final int cubitAndState;

  const PaymentsDContainer({
    Key? key,
    required this.claimsPayments,
    required this.onTapClaimsPayments,
    required this.selectedClaimsPaymentsId,
    required this.cubitAndState,
  }) : super(key: key);

  @override
  State<PaymentsDContainer> createState() =>
      _AssignmentsSubjectContainerState();
}

class _AssignmentsSubjectContainerState extends State<PaymentsDContainer> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // if (widget.cubitAndState == 1) {
              //   if (context.read<PaymentsCubit>().state
              //       is PaymentsFetchInProgress) {
              //     return;
              //   }
              //   // } else if (widget.cubitAndState == 2) {
              //   //   //change cubit later - according to Online Result
              //   //   if (context.read<ResultsCubit>().state
              //   //       is ResultsFetchInProgress) {
              //   //     return;
              //   //   }
              //   // } else {
              //   //   if (context.read<AssignmentsCubit>().state
              //   //       is AssignmentsFetchInProgress) {
              //   //     return;
              //   //   }
              // }

              if (widget.claimsPayments[index].id ==
                  widget.selectedClaimsPaymentsId) {
                return;
              }

              final claimsPaymentsIdIndex = widget.claimsPayments.indexWhere(
                (element) => widget.claimsPayments[index].id == element.id,
              );

              final selectedClaimsPaymentsIdIndex =
                  widget.claimsPayments.indexWhere(
                (element) => widget.selectedClaimsPaymentsId == element.id,
              );

              _scrollController.animateTo(
                _scrollController.offset +
                    (claimsPaymentsIdIndex > selectedClaimsPaymentsIdIndex
                            ? 1
                            : 0) *
                        MediaQuery.of(context).size.width *
                        (0.2),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );

              widget.onTapClaimsPayments(widget.claimsPayments[index].id!);
            },
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 20.0),
              decoration: BoxDecoration(
                color: widget.selectedClaimsPaymentsId ==
                        widget.claimsPayments[index].id
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Text(
                // int.parse(widget.claimsPayments[index].amount!) >= 0
                //     ? UiUtils.getTranslatedLabel(context, allClaimsPaymentsKey)
                //     :
                     widget.claimsPayments[index].name!,
                // ? widget.subjects[index].subjectNameWithType
                // : widget.subjects[index].name,
                style: TextStyle(
                  color: widget.selectedClaimsPaymentsId ==
                          widget.claimsPayments[index].id
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          );
        },
        itemCount: widget.claimsPayments.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (0.1),
        ),
      ),
    );
  }
}
