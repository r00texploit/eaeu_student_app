import 'package:student/data/models/claimsPayments.dart';
import 'package:student/data/models/payments.dart';
import 'package:student/ui/widgets/customUserProfileImageWidget.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class PayProfileDetailsContainer extends StatelessWidget {
  final String nameKey; //motherName,fatherName,guardianName and name
  final ClaimsPaymentData? payProfile;
  const PayProfileDetailsContainer({
    Key? key,
    required this.nameKey,
    required this.payProfile,
  }) : super(key: key);

  Widget _buildPayDetailsTitleAndValue({
    required String title,
    required String value,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
              fontSize: 13.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (0.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // PositionedDirectional(
          //   top: -40,
          //   start: MediaQuery.of(context).size.width * (0.4) - 42.5,
          //   child: Container(
          //     width: 85.0,
          //     height: 85.0,
          //     padding: const EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //     ),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Theme.of(context).colorScheme.primary,
          //       ),
          //       child: CustomUserProfileImageWidget(profileUrl: parent.image),
          //     ),
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 60,
              ),
              Divider(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75),
                height: 1.25,
              ),
              const SizedBox(
                height: 20,
              ),
              _buildPayDetailsTitleAndValue(
                title: UiUtils.getTranslatedLabel(context, nameKey),
                context: context,
                value: UiUtils.formatEmptyValue(
                  "${payProfile!.name}", // ${payProfile!.lastName}",
                ),
              ),
              _buildPayDetailsTitleAndValue(
                context: context,
                title: UiUtils.getTranslatedLabel(context, nameKey),
                value:
                    // UiUtils.formatEmptyValue(
                    //     DateTime.tryParse(parent.dob) == null
                    //         ? parent.dob
                    // :
                    //UiUtils.formatDate(DateTime.tryParse(parent.dob)!)),
                    UiUtils.formatEmptyValue(
                  "${payProfile!.date}",
                ),
              ),
              _buildPayDetailsTitleAndValue(
                context: context,
                title: UiUtils.getTranslatedLabel(context, nameKey),
                value: UiUtils.formatEmptyValue(payProfile!.amount!),
              ),
              // _buildParentDetailsTitleAndValue(
              //   context: context,
              //   title: UiUtils.getTranslatedLabel(context, occupationKey),
              //   value: UiUtils.formatEmptyValue(parent.occupation),
              // ),
              // _buildParentDetailsTitleAndValue(
              //   context: context,
              //   title: UiUtils.getTranslatedLabel(context, phoneNumberKey),
              //   value: UiUtils.formatEmptyValue(parent.mobile),
              // ),
              // _buildParentDetailsTitleAndValue(
              //   context: context,
              //   title: UiUtils.getTranslatedLabel(context, addressKey),
              //   value: UiUtils.formatEmptyValue(parent.currentAddress),
              // ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
