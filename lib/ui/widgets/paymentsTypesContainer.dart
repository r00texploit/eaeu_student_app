import 'package:student/cubits/assignmentsCubit.dart';
import 'package:student/cubits/examsOnlineCubit.dart';
import 'package:student/cubits/resultsCubit.dart';
import 'package:student/data/models/payments.dart';
// import 'package:student/data/models/subject.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//It must be child of AssignmentsCibit
class PaymentsTypeContainer extends StatefulWidget {
  final List<ClaimsPayments> claimPayment;
  final Function(int) onTapSubject;
  final int selectedSubjectId;
  final String cubitAndState;

  const PaymentsTypeContainer({
    Key? key,
    required this.claimPayment,
    required this.onTapSubject,
    required this.selectedSubjectId,
    required this.cubitAndState,
  }) : super(key: key);

  @override
  State<PaymentsTypeContainer> createState() => _PaymentsTypeContainerState();
}

class _PaymentsTypeContainerState extends State<PaymentsTypeContainer> {
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
              // if (widget.cubitAndState == "onlineExam") {
              //   if (context.read<ExamsOnlineCubit>().state
              //       is ExamsOnlineFetchInProgress) {
              //     return;
              //   }
              // } else if (widget.cubitAndState == "onlineResult") {
              //   //change cubit later - according to Online Result
              //   if (context.read<ResultsCubit>().state
              //       is ResultsFetchInProgress) {
              //     return;
              //   }
              // } else {
              //   if (context.read<AssignmentsCubit>().state
              //       is AssignmentsFetchInProgress) {
              //     return;
              //   }
              // }

              if (widget.claimPayment[index].id == widget.selectedSubjectId) {
                return;
              }

              final subjectIdIndex = widget.claimPayment.indexWhere(
                (element) => widget.claimPayment[index].id == element.id,
              );

              final selectedSubjectIdIndex = widget.claimPayment.indexWhere(
                (element) => widget.selectedSubjectId == element.id,
              );

              _scrollController.animateTo(
                _scrollController.offset +
                    (subjectIdIndex > selectedSubjectIdIndex ? 1 : -1) *
                        MediaQuery.of(context).size.width *
                        (0.2),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );

              widget.onTapSubject(widget.claimPayment[index].id!);
            },
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 20.0),
              decoration: BoxDecoration(
                color: widget.selectedSubjectId == widget.claimPayment[index].id
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Text(
                widget.claimPayment[index].id! >= 0
                    ? UiUtils.getTranslatedLabel(context, allSubjectsKey)
                    // : widget.claimPayment[index].
                    //     ? widget.claimPayment[index].subjectNameWithType
                    : widget.claimPayment[index].name!,
                style: TextStyle(
                  color:
                      widget.selectedSubjectId == widget.claimPayment[index].id
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          );
        },
        itemCount: widget.claimPayment.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (0.1),
        ),
      ),
    );
  }
}
