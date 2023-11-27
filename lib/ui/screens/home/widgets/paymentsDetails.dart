import 'package:student/cubits/PaymentsDetailsCubit.dart';
import 'package:student/cubits/studentPaidDetailsCubit.dart';
import 'package:student/data/models/paymentsDetails.dart';
// import 'package:student/data/models/paymentsDetails.dart';
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
  final int? type;
  final int? id;
  final int? ispaid;
  const PaymentDetailsContainer(
      {Key? key, required this.id, required this.ispaid, required this.type})
      : super(key: key);

  @override
  State<PaymentDetailsContainer> createState() =>
      _PaymentDetailsContainerState();
}

class _PaymentDetailsContainerState extends State<PaymentDetailsContainer> {
  PaymentsDetails? paymentsDetails;
  // int? id;
  // bool? is_paid;

  @override
  void initState() {
    super.initState();
    fetchPaidDetails();
  }

  void fetchPaidDetails() {
    Future.delayed(Duration.zero, () async {
      paymentsDetails = await context
          .read<PaymentsDetailsCubit>()
          .getPaymentDetails(widget.type!, widget.id!, widget.ispaid!);
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
              // return Align(
              //   alignment: Alignment.topCenter,
              //   child: SingleChildScrollView(
              //     padding: EdgeInsets.only(
              //       bottom: UiUtils.getScrollViewBottomPadding(context),
              //       top: MediaQuery.of(context).size.height *
              //           (UiUtils.appBarSmallerHeightPercentage + 0.075),
              //     ),
              //     child: ListView.builder(
              //         itemCount: paidData!.length,
              //         itemBuilder: (context, index) {
              //           // Column(
              //           return ListTile(
              //             title: Text(
              //               'ID: ${paidData![index].id}\n'
              //               'Name: ${paidData![index].name}\n'
              //               'Amount: ${paidData![index].amount}\n'
              //               'Date: ${paidData![index].date}\n',
              //             ),
              //           );
              //           // return PayProfileDetailsContainer(
              //           //   nameKey: motherNameKey,
              //           //   // parent: state.mother,
              //           //   payProfile: claimPaymentData![index],
              //           // );
              //           // }
              //           // const SizedBox(
              //           //   height: 70.0,
              //           // ),
              //           // ParentProfileDetailsContainer(
              //           //   nameKey: fatherNameKey,
              //           //   parent: state.father,
              //           // ),
              //           // const SizedBox(
              //           //   height: 70.0,
              //           // ),
              //           // state.guardian.id == 0
              //           //     ? const SizedBox()
              //           //     : ParentProfileDetailsContainer(
              //           //         nameKey: guardianNameKey,
              //           //         parent: state.guardian,
              //           //       ),
              //           //   ],
              //           // ),
              //           // itemCount: ,
              //         }),
              //   ),
              // );
              return Align(
                alignment: Alignment.topCenter,
                child: (paymentsDetails != null)
                    // ?
                    // ListView.separated(
                    // padding: EdgeInsets.only(
                    //   bottom: UiUtils.getScrollViewBottomPadding(context),
                    //   top: MediaQuery.of(context).size.height *
                    //       (UiUtils.appBarSmallerHeightPercentage + 0.075),
                    // ),
                    // itemCount: paymentsDetails!.length,
                    // itemBuilder: (context, index) {
                    //   return

                    ? Card(
                        // child: Hero(
                        //     tag: 'paidData${paidData![index].id}',
                        child: Material(
                            color: Colors.blueAccent,
                            // Define the shape of the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            // Define how the card's content should be clipped
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // Define the child widget of the card
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Add padding around the row widget
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Add an image widget to display an image
                                      Image.asset(
                                        "assets/images/claims.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      // Add some spacing between the image and the text
                                      Container(width: 20),
                                      // Add an expanded widget to take up the remaining horizontal space
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Add some spacing between the top of the card and the title
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(
                                                    paymentsDetails!.card_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(
                                                    paymentsDetails!
                                                        .certf_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(paymentsDetails!.it_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(
                                                    paymentsDetails!
                                                        .later_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(paymentsDetails!.mor_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(
                                                    paymentsDetails!
                                                        .other_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(paymentsDetails!.reg_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 5),
                                            // Add a title widget
                                            Row(
                                              children: [
                                                const Text("Claim Name : ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 2),
                                                Text(
                                                    paymentsDetails!
                                                        .resignation_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            // Add some spacing between the title and the subtitle
                                            Container(height: 5),
                                            // Add a subtitle widget
                                            Row(
                                              children: [
                                                const Text("Claim Amount : ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        ),
                                                    maxLines: 2),
                                                Text(
                                                    paymentsDetails!
                                                        .statment_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            // Add some spacing between the subtitle and the text
                                            Container(height: 10),

                                            Row(
                                              children: [
                                                const Text("Accounter : ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        ),
                                                    maxLines: 2),
                                                Text(
                                                    paymentsDetails!
                                                        .study_fees!,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                            Container(height: 10),
                                            // Add a text widget to display some text
                                            Row(
                                              children: [
                                                const Text("Due : ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        ),
                                                    maxLines: 2),
                                                Text(paymentsDetails!.total!,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )
                    // return Card(
                    //   margin: const EdgeInsets.symmetric(
                    //       horizontal: 10, vertical: 10),
                    //   elevation: 0.2,
                    //   // child: Padding(
                    //   //   padding: const EdgeInsets.all(10.0),
                    //   // child: Padding(
                    //   //   padding: const EdgeInsets.symmetric(
                    //   //       horizontal: 100, vertical: 100),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     // crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           const Text("Paid Payments Name : ",
                    //               style: TextStyle(
                    //                 fontSize: 20,
                    //                 // fontWeight: FontWeight.bold
                    //               ),
                    //               maxLines: 2),
                    //           Text(paidData![index].name!,
                    //               style: const TextStyle(
                    //                 fontSize: 20,
                    //                 // fontWeight: FontWeight.bold
                    //               )),
                    //         ],
                    //       ),
                    //       // Spacer(),
                    //       const SizedBox(height: 8),
                    //       Row(
                    //         children: [
                    //           const Text("Paid Payments Amount : ",
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 // fontWeight: FontWeight.bold
                    //               )),
                    //           Text(paidData![index].amount!,
                    //               style: const TextStyle(fontSize: 16)),
                    //         ],
                    //       ),
                    //       const SizedBox(height: 8),
                    //       Row(
                    //         children: [
                    //           Text('Due : ${paidData![index].date!}'),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    //   // ),
                    // );
                    // return ListTile(
                    //   title: Text(
                    //     // 'ID: ${paidData![index].id}\n'
                    //     'Name: ${paidData![index].name}\n'
                    //     'Amount: ${paidData![index].amount}\n'
                    //     'Date: ${paidData![index].date}\n',
                    //   ),
                    // );
                    //   },
                    //   separatorBuilder: (BuildContext context, int index) {
                    //     return const Divider(
                    //       color: Colors.black,
                    //       height: 3.0,
                    //     );
                    //   },
                    // )
                    : const CircularProgressIndicator(), // Show a loading spinner if paidData is null
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

// import 'package:flutter/material.dart';

// class PaymentsPage extends StatefulWidget {
//   @override
//   _PaymentsPageState createState() => _PaymentsPageState();
// }

// class _PaymentsPageState extends State<PaymentsPage> {
//   // List<Assignment> assignments = [
//   //   Assignment(
//   //     subject: 'Maths (Practical)',
//   //     title: 'Drawing Of Nature',
//   //     dueDate: DateTime.parse('2024-03-22 01:29:00'),
//   //   ),
//   //   Assignment(
//   //     subject: 'Computer (Practical)',
//   //     title: 'Drawing (Practical)',
//   //     dueDate: DateTime.parse('2024-02-23 01:28:00'),
//   //   ),
//   //   Assignment(
//   //     subject: 'Account',
//   //     title: 'Assignment 1',
//   //     dueDate: DateTime.parse('2024-02-23 01:25:00'),
//   //   ),
//   //   Assignment(
//   //     subject: 'Maths (Practical)',
//   //     title: 'Decimal Number Sys...',
//   //     dueDate: DateTime.parse('2023-08-22 01:24:00'),
//   //   ),
//   //   Assignment(
//   //     subject: 'Account',
//   //     title: 'Poem Writing',
//   //     dueDate: DateTime.parse('2023-08-22 01:23:00'),
//   //   ),
//   // ];

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Assignments'),
//       ),
//       body: ListView.builder(
//         itemCount: assignments.length,
//         itemBuilder: (context, index) {
//           final assignment = assignments[index];
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Text(assignment.title,
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 8),
//                   Text(assignment.subject, style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 8),
//                   Text('Due: ${assignment.dueDate.toIso8601String()}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class Assignment {
//   final String subject;
//   final String title;
//   final DateTime dueDate;

//   Assignment(
//       {required this.subject, required this.title, required this.dueDate});
// }
