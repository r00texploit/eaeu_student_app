import 'package:student/ui/widgets/assignmentsContainer.dart';
import 'package:student/ui/widgets/paymentsContainer.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class PaymentFilterBottomsheetContainer extends StatefulWidget {
  final PaymentFilters initialPaymentFilterValue;
  final Function changePaymentFilter;
  const PaymentFilterBottomsheetContainer({
    Key? key,
    required this.initialPaymentFilterValue,
    required this.changePaymentFilter,
  }) : super(key: key);

  @override
  State<PaymentFilterBottomsheetContainer> createState() =>
      _PaymentFilterBottomsheetContainerState();
}

class _PaymentFilterBottomsheetContainerState
    extends State<PaymentFilterBottomsheetContainer> {
  late PaymentFilters _currentlySelectedPaymentFilterValue =
      widget.initialPaymentFilterValue;

  Widget _buildPaymentFilterTile({
    required String title,
    required PaymentFilters paymentFilter,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentlySelectedPaymentFilterValue = paymentFilter;
          });
          widget.changePaymentFilter(paymentFilter);
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.75,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentlySelectedPaymentFilterValue == paymentFilter
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * (0.075),
        vertical: MediaQuery.of(context).size.height * (0.05),
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(UiUtils.bottomSheetTopRadius),
          topRight: Radius.circular(UiUtils.bottomSheetTopRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            UiUtils.getTranslatedLabel(context, sortByKey),
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          _buildPaymentFilterTile(
            title: UiUtils.getTranslatedLabel(context, assignedDateLatestKey),
            paymentFilter: PaymentFilters.assignedDateLatest,
          ),
          _buildPaymentFilterTile(
            title: UiUtils.getTranslatedLabel(context, assignedDateOldestKey),
            paymentFilter: PaymentFilters.assignedDateOldest,
          ),
          _buildPaymentFilterTile(
            title: UiUtils.getTranslatedLabel(context, dueDateLatestKey),
            paymentFilter: PaymentFilters.dueDateLatest,
          ),
          _buildPaymentFilterTile(
            title: UiUtils.getTranslatedLabel(context, dueDateOldestKey),
            paymentFilter: PaymentFilters.dueDateOldest,
          ),
        ],
      ),
    );
  }
}
