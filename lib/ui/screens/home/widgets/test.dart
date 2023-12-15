import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/cubits/certificateCubit.dart';
import 'package:student/cubits/test.dart';
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

  void fetchPaidDetails() async {
    // Future.delayed(Duration.zero, () async {
    certificateResponse =
        await context.read<CertificateTestCubit>().getCertificate();
    print("${certificateResponse!.data.length}");
    if (certificateResponse!.data.isNotEmpty) {
      for (var i = 0; i < certificateResponse!.data.length; i++) {
        select.add(certificateResponse!.data[i].name);
      }
    }
    // });
    setState(() {});
  }

  List select = [];
  List<int> selectOption = [];
  @override
  Widget build(BuildContext context) {
    TextEditingController? firstName, sec_name, third_name, lastName, phone;
    bool? selected;
    List<int> multipleSelected = [];

    firstName = TextEditingController();
    sec_name = TextEditingController();
    third_name = TextEditingController();
    lastName = TextEditingController();
    phone = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Certificate Selection'),
        ),
        body: BlocBuilder<CertificateTestCubit, CertificateTestState>(
          builder: (context, state) {
            return SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: UiUtils.getScrollViewBottomPadding(context),
                    top: 0),
                child: (certificateResponse!.data.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: firstName,
                              initialValue: '',
                              onChanged: (value) {
                                print("object: ${firstName!.text}");
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
                              initialValue: '',
                              onChanged: (value) {
                                print("object: ${sec_name!.text}");
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
                              initialValue: '',
                              onChanged: (value) {
                                print("object: ${third_name!.text}");
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
                              initialValue: '',
                              onChanged: (value) {
                                print("object: ${lastName!.text}");
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
                              initialValue: '',
                              onChanged: (value) {
                                print("object: ${phone!.text}");
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
                                int total = 0;
                                for (int i = 0;
                                    i <= multipleSelected.length;
                                    i++) {
                                  if (certificateResponse!.data[i].id ==
                                      multipleSelected[i]) {
                                    total += int.parse(
                                        certificateResponse!.data[i].minPrice);
                                  }
                                }
                                print("total : $total");
                              },
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<CertificateTestCubit>()
                                  .submitData(
                                      multipleSelected,
                                      firstName!.text,
                                      sec_name!.text,
                                      third_name!.text,
                                      lastName!.text,
                                      phone!.text,
                                      context),
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      )
                    : CircularProgressIndicator());
          },
        ));
  }
}
