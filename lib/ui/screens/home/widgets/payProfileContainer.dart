import 'package:student/cubits/studentParentDetailsCubit.dart';
import 'package:student/cubits/studentPayDetailsCubit.dart';
import 'package:student/data/models/claimsPayments.dart';
import 'package:student/ui/styles/colors.dart';
import 'package:student/ui/widgets/customShimmerContainer.dart';
import 'package:student/ui/widgets/errorContainer.dart';
import 'package:student/ui/widgets/parentProfileDetailsContainer.dart';
import 'package:student/ui/widgets/payProfileDetailsContainer.dart';
import 'package:student/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:student/ui/widgets/shimmerLoadingContainer.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayProfileContainer extends StatefulWidget {
  const PayProfileContainer({Key? key}) : super(key: key);

  @override
  State<PayProfileContainer> createState() => _PayProfileContainerState();
}

class _PayProfileContainerState extends State<PayProfileContainer> {
  List<ClaimsPaymentData>? claimPaymentData;

  @override
  void initState() {
    super.initState();
    fetchParentDetails();
  }

  void fetchParentDetails() {
    Future.delayed(Duration.zero, () async {
      claimPaymentData =
          await context.read<StudentPayDetailsCubit>().getStudentPayDetails();
    });
  }

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
              UiUtils.getTranslatedLabel(context, payProfileKey),
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
        BlocBuilder<StudentPayDetailsCubit, StudentPayDetailsState>(
          builder: (context, state) {
            if (state is StudentPayDetailsFetchSuccess) {
              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: UiUtils.getScrollViewBottomPadding(context),
                    top: MediaQuery.of(context).size.height *
                        (UiUtils.appBarSmallerHeightPercentage + 0.075),
                  ),
                  child: ListView.builder(
                      itemCount: claimPaymentData!.length,
                      itemBuilder: (context, index) {
                        // Column(
                        return ListTile(
                          title: Text(
                            'ID: ${claimPaymentData![index].id}\n'
                            'Name: ${claimPaymentData![index].name}\n'
                            'Amount: ${claimPaymentData![index].amount}\n'
                            'Date: ${claimPaymentData![index].date}\n',
                          ),
                        );
                        // return PayProfileDetailsContainer(
                        //   nameKey: motherNameKey,
                        //   // parent: state.mother,
                        //   payProfile: claimPaymentData![index],
                        // );
                      }
                      // const SizedBox(
                      //   height: 70.0,
                      // ),
                      // ParentProfileDetailsContainer(
                      //   nameKey: fatherNameKey,
                      //   parent: state.father,
                      // ),
                      // const SizedBox(
                      //   height: 70.0,
                      // ),
                      // state.guardian.id == 0
                      //     ? const SizedBox()
                      //     : ParentProfileDetailsContainer(
                      //         nameKey: guardianNameKey,
                      //         parent: state.guardian,
                      //       ),
                      //   ],
                      // ),
                      // itemCount: ,
                      ),
                ),
              );
            }
            if (state is StudentParentDetailsFetchFailure) {
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