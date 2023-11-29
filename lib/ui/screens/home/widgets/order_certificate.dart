import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/cubits/certificateCubit.dart';
import 'package:student/data/models/certificate_response.dart';

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

  @override
  Widget build(BuildContext context) {
    TextEditingController? firstName, sec_name, third_name, lastName;
    List selected = [];
    List<int> multipleSelected = [];
    var cert = context.read<CertificateCubit>().getCertificate();
    firstName = TextEditingController();
    sec_name = TextEditingController();
    third_name = TextEditingController();
    lastName = TextEditingController();
    // return BlocBuilder<CertificateCubit, CertificateState>(
    //   builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate Selection'),
      ),
      body: BlocBuilder<CertificateCubit, CertificateState>(
        builder: (context, state) {
          // return BlocConsumer( listener: (context, state) {}, builder: (context, state) {
          if (state.success != null) {
            return Center(
              child: Text(
                state.success!,
                style: const TextStyle(color: Colors.green),
              ),
            );
          } else if (state.error != null) {
            return Center(
              child: Text(
                state.error!,
                style: const TextStyle(color: Colors.red),
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
                    initialValue: state.firstName,
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
                    initialValue: state.secondName,
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
                    initialValue: state.firstName,
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
                    initialValue: state.firstName,
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
                  const SizedBox(height: 16.0),
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
                  ListView.builder(
                    itemCount: certificateResponse!.data.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(
                            'Certificate Type ${certificateResponse!.data[index].name}'),
                        subtitle: Text(
                            'Certificate Price ${certificateResponse!.data[index].minPrice}'),
                        value: selected
                            .contains(certificateResponse!.data[index].name),
                        onChanged: (value) {
                          setState(() {
                            multipleSelected
                                .add(certificateResponse!.data[index].id);
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CertificateCubit>().submitData(multipleSelected),
                    child: const Text('Submit'),
                  ),
                ],
              ),
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
