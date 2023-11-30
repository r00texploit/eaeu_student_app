import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/cubits/certificateCubit.dart';
import 'package:student/data/models/certificate_response.dart';
import 'package:student/ui/widgets/multiSelection.dart';
import 'package:student/utils/uiUtils.dart';

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

  void fetchPaidDetails() {
    Future.delayed(Duration.zero, () async {
      certificateResponse =
          await context.read<CertificateCubit>().getCertificate();
    });
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
    phone = TextEditingController();
    // return BlocBuilder<CertificateCubit, CertificateState>(
    //   builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate Selection'),
      ),
      body: BlocBuilder<CertificateCubit, CertificateState>(
        builder: (context, state) {
          // return BlocConsumer( listener: (context, state) {}, builder: (context, state) {
          if (state is CertificateFetchSuccess) {
            return const Center(
              child: Text(
                "state.success",
                style: TextStyle(color: Colors.green),
              ),
            );
          } else if (state is CertificateFetchFailure) {
            return const Center(
              child: Text(
                "state.error",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: firstName,
                    initialValue: context.read<CertificateCubit>().firstName,
                    onChanged: (value) {
                      context
                          .read<CertificateCubit>()
                          .updateFirstName(firstName!.text);
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
                    initialValue: context.read<CertificateCubit>().secondName,
                    onChanged: (value) {
                      context
                          .read<CertificateCubit>()
                          .updateSecondName(sec_name!.text);
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
                    initialValue: context.read<CertificateCubit>().thirdName,
                    onChanged: (value) {
                      context
                          .read<CertificateCubit>()
                          .updateThirdName(third_name!.text);
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
                    initialValue: context.read<CertificateCubit>().fourthName,
                    onChanged: (value) {
                      context
                          .read<CertificateCubit>()
                          .updateFourthlName(lastName!.text);
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
                    initialValue: context.read<CertificateCubit>().phone,
                    onChanged: (value) {
                      context.read<CertificateCubit>().updatePhone(phone!.text);
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
                    selectedOptions: [],
                    onSelectionChanged: (p0) {
                      multipleSelected = p0;
                      print("first name: ${firstName!.text}");
                      print("second name: ${sec_name!.text}");
                      print("third name: ${third_name!.text}");
                      print("last name: ${lastName!.text}");
                      print("phone: ${phone!.text}");

                      print("object: ${multipleSelected}");
                    },
                  ),
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
                    onPressed: () => context
                        .read<CertificateCubit>()
                        .submitData(
                            multipleSelected,
                            firstName!.text,
                            sec_name!.text,
                            third_name!.text,
                            lastName!.text,
                            phone!.text),
                    child: const Text('Submit'),
                  ),
                ],
              ),
              // )
            );
          }
          // }
          // );
        },
      ),
    );
    //   },
    // );
  }
}
