// import 'package:student/cubits/authCubit.dart';
// import 'package:student/cubits/undoPaymentsSubmissionCubit.dart';
// import 'package:student/cubits/uploadPaymentsCubit.dart';
// import 'package:student/data/models/Payments.dart';
import 'package:student/data/models/payments.dart';
import 'package:student/data/models/studyMaterial.dart';
import 'package:student/data/repositories/paymentRepository.dart';
// import 'package:student/ui/screens/Payments/widgets/undoPaymentsBottomsheetContainer.dart';
// import 'package:student/ui/screens/Payments/widgets/uploadPaymentsFilesBottomsheetContainer.dart';
import 'package:student/ui/widgets/customAppbar.dart';
import 'package:student/ui/widgets/studyMaterialWithDownloadButtonContainer.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PaymentsScreen extends StatefulWidget {
  final ClaimsPayments Payments;
  const PaymentsScreen({Key? key, required this.Payments}) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();

  static Route<ClaimsPayments> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
      builder: (_) => PaymentsScreen(
        Payments: routeSettings.arguments as ClaimsPayments,
      ),
    );
  }
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  late bool PaymentsSubmitted = submittedPayments.id != 0;
  late ClaimsPayments submittedPayments = widget.Payments;

  // void uploadPayments() {
  //   UiUtils.showBottomSheet(
  //     child: BlocProvider<UploadPaymentsCubit>(
  //       create: (_) => UploadPaymentsCubit(PaymentsRepository()),
  //       child: UploadPaymentsFilesBottomsheetContainer(
  //         Payments: submittedPayments,
  //       ),
  //     ),
  //     context: context,
  //     enableDrag: false,
  //   ).then((value) {
  //     if (value != null) {
  //       if (value['error']) {
  //         UiUtils.showCustomSnackBar(
  //           context: context,
  //           errorMessage: UiUtils.getErrorMessageFromErrorCode(
  //             context,
  //             value['message'],
  //           ),
  //           backgroundColor: Theme.of(context).colorScheme.error,
  //         );
  //       } else {
  //         submittedPayments = submittedPayments
  //             .updatePaymentsSubmission(value['PaymentsSubmission']);
  //         PaymentsSubmitted = true;
  //         setState(() {});
  //       }
  //     }
  //   });
  // }

  // void undoPayments() {
  //   UiUtils.showBottomSheet(
  //     child: BlocProvider<UndoPaymentsSubmissionCubit>(
  //       create: (_) => UndoPaymentsSubmissionCubit(PaymentsRepository()),
  //       child: UndoPaymentsBottomsheetContainer(
  //         PaymentsSubmissionId: submittedPayments.PaymentsSubmission.id,
  //       ),
  //     ),
  //     context: context,
  //     enableDrag: false,
  //   ).then((value) {
  //     if (value != null) {
  //       if (value['error']) {
  //         UiUtils.showCustomSnackBar(
  //           context: context,
  //           errorMessage: UiUtils.getErrorMessageFromErrorCode(
  //             context,
  //             value['message'].toString(),
  //           ),
  //           backgroundColor: Theme.of(context).colorScheme.error,
  //         );
  //       } else {
  //         submittedPayments = submittedPayments
  //             .updatePaymentsSubmission(PaymentsSubmission.fromJson({}));
  //         PaymentsSubmitted = false;
  //         setState(() {});
  //         uploadPayments();
  //       }
  //     }
  //   });
  // }

  TextStyle _getPaymentsDetailsLabelValueTextStyle() {
    return TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle _getPaymentsDetailsLabelTextStyle() {
    return TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
  }

  // bool _showUploadPaymentsButton() {
  //   if (context.read<AuthCubit>().isParent()) {
  //     return false;
  //   }
  //   String PaymentsStatusKey = UiUtils.getPaymentsSubmissionStatusKey(
  //     submittedPayments.PaymentsSubmission.status,
  //   );
  //   //if Payments submission accepted
  //   //then hide upload submit button

  //   if (PaymentsStatusKey == acceptedKey ||
  //       PaymentsStatusKey == inReviewKey ||
  //       PaymentsStatusKey == resubmittedKey) {
  //     return false;
  //   }

  //   DateTime currentDayDateTime = DateTime.now();

  //   if (UiUtils.getPaymentsSubmissionStatusKey(
  //         submittedPayments.PaymentsSubmission.status,
  //       ) ==
  //       rejectedKey) {
  //     //if Payments submission rejected and resubmission is not allow
  //     //then hide upload submit button
  //     if (UiUtils.getPaymentsSubmissionStatusKey(
  //           submittedPayments.PaymentsSubmission.status,
  //         ) ==
  //         rejectedKey) {
  //       //if Payments resubmission is not allow then
  //       //then hide upload submit button
  //       if (submittedPayments.resubmission == 0) {
  //         return false;
  //       }
  //       //if extra days for resubmission has passed then
  //       //hide upload Payments button
  //       if (currentDayDateTime.compareTo(
  //             submittedPayments.dueDate.add(
  //               Duration(
  //                 days: submittedPayments.extraDaysForResubmission,
  //               ),
  //             ),
  //           ) ==
  //           1) {
  //         return false;
  //       }
  //       return true;
  //     }
  //   }

  //   //if Payments submission due date has passed
  //   //then hide upload submit button
  //   if (currentDayDateTime.compareTo(submittedPayments.dueDate) == 1) {
  //     return false;
  //   }
  //   return true;
  // }

  // Widget _uploadPaymentsButton() {
  //   return Align(
  //     alignment: AlignmentDirectional.bottomEnd,
  //     child: Padding(
  //       padding: const EdgeInsetsDirectional.only(end: 25.0, bottom: 25.0),
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(30),
  //         onTap: () {
  //           uploadPayments();
  //         },
  //         child: Container(
  //           width: 60,
  //           height: 60,
  //           padding: const EdgeInsets.all(15),
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 blurRadius: 10,
  //                 offset: const Offset(0, 5),
  //                 color:
  //                     Theme.of(context).colorScheme.primary.withOpacity(0.275),
  //               )
  //             ],
  //             color: Theme.of(context).colorScheme.primary,
  //             shape: BoxShape.circle,
  //           ),
  //           child:
  //               SvgPicture.asset(UiUtils.getImagePath("file_upload_icon.svg")),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPaymentsDetailBackgroundContainer(Widget child) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        width: MediaQuery.of(context).size.width * (0.85),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: child,
      ),
    );
  }

  Widget _buildPaymentsNameContainer() {
    return _buildPaymentsDetailBackgroundContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UiUtils.getTranslatedLabel(context, paymentKey),
            style: _getPaymentsDetailsLabelTextStyle(),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            submittedPayments.name!,
            style: _getPaymentsDetailsLabelValueTextStyle(),
          ),
        ],
      ),
    );
  }

  // Widget _buildPaymentsSubjectNameContainer() {
  //   return _buildPaymentsDetailBackgroundContainer(
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           UiUtils.getTranslatedLabel(context, subjectNameKey),
  //           style: _getPaymentsDetailsLabelTextStyle(),
  //         ),
  //         const SizedBox(
  //           height: 5.0,
  //         ),
  //         Text(
  //           submittedPayments.subject.showType
  //               ? submittedPayments.subject.subjectNameWithType
  //               : submittedPayments.subject.name,
  //           style: _getPaymentsDetailsLabelValueTextStyle(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPaymentsPointsContainer() {
  //   if (submittedPayments.points == 0) {
  //     return const SizedBox();
  //   }

  //   return _buildPaymentsDetailBackgroundContainer(
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           UiUtils.getTranslatedLabel(
  //             context,
  //             PaymentsSubmitted ? pointsKey : possiblePointsKey,
  //           ),
  //           style: _getPaymentsDetailsLabelTextStyle(),
  //         ),
  //         const SizedBox(
  //           height: 5.0,
  //         ),
  //         Text(
  //           PaymentsSubmitted
  //               ? "${submittedPayments.PaymentsSubmission.points}/${submittedPayments.points}"
  //               : submittedPayments.points.toString(),
  //           style: _getPaymentsDetailsLabelValueTextStyle(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPaymentsDueDateContainer() {
  //   DateTime dueDate = submittedPayments.dueDate;
  //   String PaymentsStatusKey = UiUtils.getPaymentsSubmissionStatusKey(
  //     submittedPayments.PaymentsSubmission.status,
  //   );

  //   //If Payments status is rejected then
  //   //and resubmission is allowed or Payments status is resubmitted
  //   //dueDate will be (currentDueDate + extra days for resubmission)

  //   if ((PaymentsStatusKey == rejectedKey &&
  //           submittedPayments.resubmission == 1) ||
  //       PaymentsStatusKey == resubmittedKey) {
  //     dueDate = submittedPayments.dueDate
  //         .add(Duration(days: submittedPayments.extraDaysForResubmission));
  //   }

  //   return _buildPaymentsDetailBackgroundContainer(
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           UiUtils.getTranslatedLabel(context, dueDateKey),
  //           style: _getPaymentsDetailsLabelTextStyle(),
  //         ),
  //         const SizedBox(
  //           height: 5.0,
  //         ),
  //         Text(
  //           UiUtils.formatPaymentsDueDate(dueDate, context),
  //           style: _getPaymentsDetailsLabelValueTextStyle(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPaymentsInstructionsContainer() {
  //   return submittedPayments.instructions.isEmpty
  //       ? const SizedBox()
  //       : _buildPaymentsDetailBackgroundContainer(
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 UiUtils.getTranslatedLabel(context, instructionsKey),
  //                 style: _getPaymentsDetailsLabelTextStyle(),
  //               ),
  //               const SizedBox(
  //                 height: 5.0,
  //               ),
  //               Text(
  //                 submittedPayments.instructions,
  //                 style: _getPaymentsDetailsLabelValueTextStyle(),
  //               ),
  //             ],
  //           ),
  //         );
  // }

  // Widget _buildPaymentsRemarksContainer() {
  //   if (!PaymentsSubmitted) {
  //     return const SizedBox();
  //   }
  //   if (submittedPayments.PaymentsSubmission.feedback.isEmpty) {
  //     return const SizedBox();
  //   }
  //   return _buildPaymentsDetailBackgroundContainer(
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           UiUtils.getTranslatedLabel(context, remarksKey),
  //           style: _getPaymentsDetailsLabelTextStyle(),
  //         ),
  //         const SizedBox(
  //           height: 5.0,
  //         ),
  //         Text(
  //           submittedPayments.PaymentsSubmission.feedback,
  //           style: _getPaymentsDetailsLabelValueTextStyle(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPaymentsReferenceMaterialContainer({
  //   required BoxConstraints boxConstraints,
  //   required StudyMaterial studyMaterial,
  // }) {
  //   return StudyMaterialWithDownloadButtonContainer(
  //     boxConstraints: boxConstraints,
  //     studyMaterial: studyMaterial,
  //   );
  // }

  // Widget _buildUploadedPaymentssContainer() {
  //   if (!PaymentsSubmitted) {
  //     return const SizedBox();
  //   }

  //   return _buildPaymentsDetailBackgroundContainer(
  //     LayoutBuilder(
  //       builder: (context, boxConstraints) {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               UiUtils.getTranslatedLabel(context, myWorkKey),
  //               style: _getPaymentsDetailsLabelTextStyle(),
  //             ),
  //             const SizedBox(
  //               height: 5.0,
  //             ),
  //             ...submittedPayments.PaymentsSubmission.submittedFiles
  //                 .map(
  //                   (studyMaterial) =>
  //                       _buildPaymentsReferenceMaterialContainer(
  //                     boxConstraints: boxConstraints,
  //                     studyMaterial: studyMaterial,
  //                   ),
  //                 )
  //                 .toList(),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildPaymentsReferenceMaterialsContainer() {
    if (submittedPayments.amount!.isEmpty) {
      return const SizedBox();
    }

    return _buildPaymentsDetailBackgroundContainer(
      LayoutBuilder(
        builder: (context, boxConstraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                UiUtils.getTranslatedLabel(context, referenceMaterialsKey),
                style: _getPaymentsDetailsLabelTextStyle(),
              ),
              const SizedBox(
                height: 5.0,
              ),
              // ...submittedPayments.
              //     .map(
              //       (studyMaterial) =>
              //     _buildPaymentsReferenceMaterialContainer(
              //   boxConstraints: boxConstraints,
              //   studyMaterial: submittedPayments.amount,
              // ),
              // )
              // .toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPaymentsDetailsContainer() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: UiUtils.getScrollViewBottomPadding(context),
        top: UiUtils.getScrollViewTopPadding(
          context: context,
          appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPaymentsNameContainer(),
          // _buildPaymentsSubjectNameContainer(),
          // _buildPaymentsDueDateContainer(),
          // _buildPaymentsInstructionsContainer(),
          _buildPaymentsReferenceMaterialsContainer(),
          // _buildUploadedPaymentssContainer(),
          // _buildPaymentsPointsContainer(),
          // _buildPaymentsRemarksContainer(),
        ],
      ),
    );
  }

  String getPaymentsSubmissionStatus() {
    if (UiUtils.getPaymentsSubmissionStatusKey(
      submittedPayments.id!,
    ).isNotEmpty) {
      return UiUtils.getTranslatedLabel(
        context,
        UiUtils.getPaymentsSubmissionStatusKey(
          submittedPayments.id!,
        ),
      );
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(submittedPayments);
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildPaymentsDetailsContainer(),
            CustomAppBar(
              subTitle:
                  PaymentsSubmitted ? getPaymentsSubmissionStatus() : null,
              title: UiUtils.getTranslatedLabel(context, paymentsKey),
              onPressBackButton: () {
                Navigator.of(context).pop(submittedPayments);
              },
            ),
            // _showUploadPaymentsButton()
            //     ? _uploadPaymentsButton()
            //     : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
