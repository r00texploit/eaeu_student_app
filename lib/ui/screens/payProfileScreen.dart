import 'package:student/cubits/paymentsCubit.dart';
import 'package:student/ui/widgets/customAppbar.dart';
import 'package:student/ui/widgets/payProfileDetailsContainer.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayProfileScreen extends StatelessWidget {
  const PayProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var claims = context.read<PaymentsCubit>().getClaimPayments();
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: UiUtils.getScrollViewTopPadding(
                  context: context,
                  appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.05),
                  ),
                  PayProfileDetailsContainer(
                    nameKey: nameKey,
                    payProfile: claims,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              title: UiUtils.getTranslatedLabel(context, profileKey),
            ),
          ),
        ],
      ),
    );
  }
}
