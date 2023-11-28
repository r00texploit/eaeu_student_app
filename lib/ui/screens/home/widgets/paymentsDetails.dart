import 'package:student/cubits/PaymentsDetailsCubit.dart';
import 'package:student/cubits/studentPaidDetailsCubit.dart';
import 'package:student/data/models/paidPayments.dart';
import 'package:student/data/models/paymentsDetails.dart';
import 'package:student/ui/screens/home/widgets/paymentsDetails.dart';
import 'package:student/ui/styles/colors.dart';
import 'package:student/ui/widgets/customShimmerContainer.dart';
import 'package:student/ui/widgets/errorContainer.dart';
import 'package:student/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:student/ui/widgets/shimmerLoadingContainer.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsContainer extends StatefulWidget {
  final int? type, id, ispaid;

  const PaymentDetailsContainer(
      {Key? key, required this.type, required this.id, required this.ispaid})
      : super(key: key);

  @override
  State<PaymentDetailsContainer> createState() => _PayProfileContainerState();
}

class _PayProfileContainerState extends State<PaymentDetailsContainer> {
  PaymentsDetails? paymentDetails;

  @override
  void initState() {
    super.initState();
    fetchPaidDetails();
  }

  void fetchPaidDetails() {
    Future.delayed(Duration.zero, () async {
      paymentDetails = await context
          .read<PaymentsDetailsCubit>()
          .getPaymentDetails(widget.type!, widget.id!, widget.ispaid!);
    });
  }

  List<String> items = ['Registertion', '67', 'Study fees'];

  Widget _buildParentDetailsValueShimmerLoading(BoxConstraints boxConstraints) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        ShimmerLoadingContainer(
          child: CustomShimmerContainer(
            margin: EdgeInsetsDirectional.only(
              end: boxConstraints.maxWidth * (0.7),
            ),
            height: 8,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ShimmerLoadingContainer(
          child: CustomShimmerContainer(
            margin: EdgeInsetsDirectional.only(
              end: boxConstraints.maxWidth * (0.5),
            ),
            height: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildParentDetailsShimmerLoading() {
    return Container(
      width: MediaQuery.of(context).size.width * (0.8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              PositionedDirectional(
                top: -40,
                start: MediaQuery.of(context).size.width * (0.4) - 42.5,
                child: ShimmerLoadingContainer(
                  child: Container(
                    width: 85.0,
                    height: 85.0,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: shimmerContentColor,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  ShimmerLoadingContainer(
                    child: Divider(
                      color: shimmerContentColor,
                      height: 2,
                    ),
                  ),
                  _buildParentDetailsValueShimmerLoading(boxConstraints),
                  _buildParentDetailsValueShimmerLoading(boxConstraints),
                  _buildParentDetailsValueShimmerLoading(boxConstraints),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return ScreenTopBackgroundContainer(
      padding: EdgeInsets.zero,
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
      child: Stack(
        children: [
          Align(
            child: Text(
              UiUtils.getTranslatedLabel(context, paidProfileKey),
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: UiUtils.screenTitleFontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PaymentsDetailsCubit, PaymentsDetailsState>(
          builder: (context, state) {
            if (state is PaymentsDetailsFetchSuccess) {
              return Align(
                alignment: Alignment.topCenter,
                child: (paymentDetails != null)
                    ? Card(
                        child: Material(
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/claims.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(height: 5),
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 2),
                                                Text(paymentDetails!.card_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            Container(height: 5),
                                            Row(
                                              children: [
                                                const Text("Claim Amount : ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    maxLines: 2),
                                                Text(
                                                    paymentDetails!.certf_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            Container(height: 10),
                                            Row(
                                              children: [
                                                const Text("Accounter : ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    maxLines: 2),
                                                Text(paymentDetails!.it_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            Container(height: 10),
                                            Row(
                                              children: [
                                                const Text("Due : ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    maxLines: 2),
                                                Text(
                                                    paymentDetails!.later_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )))
                    : const CircularProgressIndicator(),
              );
            }
            if (state is StudentPaidDetailsFetchFailure) {
              return const ErrorContainer(errorMessageCode: "errorMessage");
            }

            return Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: UiUtils.getScrollViewBottomPadding(context),
                  top: MediaQuery.of(context).size.height *
                      (UiUtils.appBarSmallerHeightPercentage + 0.075),
                ),
                child: Column(
                  children: [
                    _buildParentDetailsShimmerLoading(),
                    _buildParentDetailsShimmerLoading(),
                    _buildParentDetailsShimmerLoading()
                  ],
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _buildAppBar(),
        ),
      ],
    );
  }
}
/**
 * 
 * {
    "error": false,
    "message": "Data Fetched Successfully",
    "data": {
        [
        {
        "id": 1452,
        "name": "News",
        "amount": "500.00",
        "date": "2023-11-04"
        },
        {
        "id": 1452,
        "name": "News",
        "amount": "500.00",
        "date": "2023-11-04"
        }
        ]
    },
    "code": 200
}
 */