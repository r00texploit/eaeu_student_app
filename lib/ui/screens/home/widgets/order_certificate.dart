import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/app/routes.dart';
import 'package:student/cubits/test.dart';
import 'package:student/data/models/certificate_response.dart';
import 'package:student/ui/widgets/multiSelection.dart';
import 'package:student/utils/uiUtils.dart';
// import 'package:student/utils/uiUtils.dart';

class CertificateSelectionScreen extends StatefulWidget {
  const CertificateSelectionScreen({Key? key}) : super(key: key);
  @override
  State<CertificateSelectionScreen> createState() =>
      _CertificateSelectionScreenState();
}

class _CertificateSelectionScreenState
    extends State<CertificateSelectionScreen> {
  CertificateResponse? certificateResponse;
  @override
  void initState() {
    super.initState();
    fetchPaidDetails();
  }

  void fetchPaidDetails() async {
    certificateResponse =
        await context.read<CertificateTestCubit>().getCertificate();
    print("${certificateResponse!.data.length}");
    if (certificateResponse!.data.isNotEmpty) {
      for (var i = 0; i < certificateResponse!.data.length; i++) {
        select.add(certificateResponse!.data[i].name);
      }
    }
    setState(() {});
  }

  List select = [];
  List<int> selectOption = [];
  @override
  Widget build(BuildContext context) {
    TextEditingController? firstName, sec_name, third_name, lastName, phone;
    bool? selected;
    List<int> multipleSelected = [];
    // var cert = context.read<CertificateCubit>().getCertificate();
    firstName = TextEditingController();
    sec_name = TextEditingController();
    third_name = TextEditingController();
    lastName = TextEditingController();
    double? total = 0.0;

    phone = TextEditingController();
    // return BlocBuilder<CertificateCubit, CertificateState>(
    //   builder: (context, state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Certificate Selection'),
        ),
        body: BlocBuilder<CertificateTestCubit, CertificateTestState>(
          builder: (context, state) {
            // return BlocConsumer( listener: (context, state) {}, builder: (context, state) {
            // if (state is CertificateFetchSuccess) {
            // if (certificateResponse!.data.isNotEmpty) {
            //  Padding(
            return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                    bottom: UiUtils.getScrollViewBottomPadding(context), top: 0
                    // MediaQuery.of(context).size.height *
                    //     (UiUtils.appBarSmallerHeightPercentage + 0.050),
                    ),
                child: certificateResponse?.data.isNotEmpty != null
                    ? Padding(
                        // padding: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              subtitle: Text("Enter your Full Name in English"),
                            ),
                            TextFormField(
                              controller: firstName,
                              // initialValue: firstName!.text.isNotEmpty
                              //     ? firstName.text
                              //     : null,
                              // context.read<CertificateTestCubit>(),
                              onChanged: (value) {
                                print("object: ${firstName!.text}");
                                // context
                                //     .read<CertificateCubit>()
                                //     .updateFirstName(firstName!.text);
                              },
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your First name.';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: sec_name,
                              // initialValue: sec_name!.text.isNotEmpty
                              //     ? sec_name.text
                              //     : null,
                              // context.read<CertificateCubit>().secondName,
                              onChanged: (value) {
                                print("object: ${sec_name!.text}");

                                // context
                                //     .read<CertificateCubit>()
                                //     .updateSecondName(sec_name!.text);
                              },
                              decoration: const InputDecoration(
                                labelText: 'Second Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Second name.';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: third_name,
                              // initialValue: third_name!.text.isNotEmpty
                              //     ? third_name.text
                              //     : null,
                              // context.read<CertificateCubit>().thirdName,
                              onChanged: (value) {
                                print("object: ${third_name!.text}");
                                // context
                                //     .read<CertificateCubit>()
                                //     .updateThirdName(third_name!.text);
                              },
                              decoration: const InputDecoration(
                                labelText: 'Third Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Third name.';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: lastName,
                              // initialValue: lastName!.text.isNotEmpty
                              //     ? lastName.text
                              //     : null,
                              // context.read<CertificateCubit>().fourthName,
                              onChanged: (value) {
                                print("object: ${lastName!.text}");
                                // context
                                //     .read<CertificateCubit>()
                                //     .updateFourthlName(lastName!.text);
                              },
                              decoration: const InputDecoration(
                                labelText: 'Fourth Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Fourth name.';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: phone,
                              // initialValue:
                              //     phone!.text.isNotEmpty ? phone.text : null,
                              // context.read<CertificateCubit>().phone,
                              onChanged: (value) {
                                print("object: ${phone!.text}");
                                // context
                                //     .read<CertificateCubit>()
                                //     .updatePhone(phone!.text);
                              },
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Phone Number.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            MultiSelectCheckbox(
                              options: certificateResponse!.data,
                              selectedOptions: selectOption,
                              onSelectionChanged: (p0) {
                                multipleSelected = p0;
                                print("first name: ${firstName!.text}");
                                print("second name: ${sec_name!.text}");
                                print("third name: ${third_name!.text}");
                                print("last name: ${lastName!.text}");
                                print("phone: ${phone!.text}");
                                print(
                                    "length: ${certificateResponse!.data.length}");

                                print("object: ${multipleSelected}");
                                // int i = 0;
                                certificateResponse!.data.forEach((data) {
                                  if (multipleSelected.contains(data.id)) {
                                    // setState(() {
                                    total =
                                        total! + double.parse(data.minPrice);
                                    // });
                                  }
                                  context
                                      .read<CertificateTestCubit>()
                                      .updateTotal(total!);
                                });
                                // for (var data in certificateResponse!.data) {
                                //   if (data.id == multipleSelected[i]) {
                                //     total += double.parse(
                                //         certificateResponse!.data[i].minPrice);
                                //     // certificateResponse!.data[i].minPrice);
                                //   }
                                //   i++;
                                // }
                                print("total : $total");
                              },
                            ),
                            Text(
                                "Total price : ${context.read<CertificateTestCubit>().tot ?? 0.0}"),
                            // CheckboxListTile(
                            //   title: const Text('Certificate Type A'),
                            //   value: certificateResponse.,
                            //   onChanged: (value) => context
                            //       .read<CertificateCubit>()
                            //       .toggleSelectedCertificateType(),
                            // ),
                            // CheckboxListTile(
                            //   title: const Text('Certificate Type B'),
                            //   value: cert,
                            //   onChanged: (value) => context
                            //       .read<CertificateCubit>()
                            //       .toggleSelectedCertificateType(),
                            // ),

                            // ListView.builder(
                            //   // padding: EdgeInsets.only(
                            //   //   bottom: UiUtils.getScrollViewBottomPadding(context),
                            //   //   top: MediaQuery.of(context).size.height *
                            //   //       (UiUtils.appBarSmallerHeightPercentage + 0.075),
                            //   // ),
                            //   shrinkWrap: true,
                            //   itemCount: certificateResponse!.data.length,
                            //   itemBuilder: (context, index) {
                            //     // Column(
                            //     // children:
                            //     return CheckboxListTile(
                            //       title: Text(
                            //           'Certificate Type ${certificateResponse!.data[index].name}'),
                            //       subtitle: Text(
                            //           'Certificate Price ${certificateResponse!.data[index].minPrice}'),
                            //       value: multipleSelected
                            //           .contains(certificateResponse!.data[index].id),
                            //       onChanged: (value) {
                            //         // selected = value!;
                            //         if (multipleSelected
                            //             .contains(certificateResponse!.data[index].id)) {
                            //           selectOption
                            //               .remove(certificateResponse!.data[index].id);
                            //           // selected = !selected!;
                            //         } else {
                            //           // selected = !selected!;
                            //           selectOption
                            //               .add(certificateResponse!.data[index].id);
                            //         }
                            //         multipleSelected.addAll(selectOption);
                            //         print("selection : ${selectOption}");
                            //         setState(() {});
                            //       },
                            //     );
                            //   },
                            // ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () async {
                                var res = await context
                                    .read<CertificateTestCubit>()
                                    .submitData(
                                        multipleSelected,
                                        firstName!.text,
                                        sec_name!.text,
                                        third_name!.text,
                                        lastName!.text,
                                        phone!.text,
                                        context);
                                print(
                                    "done: ${res["done"]} \n message: ${res["message"]}");
                                if (res["done"]) {
                                  UiUtils.showCustomSnackBar(
                                      // delayDuration: Duration(),
                                      context: context,
                                      errorMessage: res["message"],
                                      backgroundColor: Colors.black);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.home,
                                    (Route<dynamic> route) => false,
                                  );
                                } else {
                                  UiUtils.showCustomSnackBar(
                                      context: context,
                                      errorMessage: res["message"],
                                      backgroundColor: Colors.black);
                                  // Navigator.of(context).pushNamedAndRemoveUntil(
                                  //   Routes.home,
                                  //   (Route<dynamic> route) => false,
                                  // );
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                        ],
                      )
                // )
                );
            // } else if (state is CertificateFetchFailure) {
            // return const Center(
            //   child: Text(
            //     "state.error",
            //     style: TextStyle(color: Colors.red),
            //   ),
            // );
            // }
          },
        ));
    //  Center(
    //     child: CircularProgressIndicator(),
    //   ));
  }
}

// }
// );
//         },
//       ),
//     );
//     //   },
//     // );
//   }
// }
