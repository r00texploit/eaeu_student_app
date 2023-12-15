// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class CertificateSelectionScreen extends StatefulWidget {
//   const CertificateSelectionScreen({Key? key}) : super(key: key);

//   @override
//   State<CertificateSelectionScreen> createState() =>
//       _CertificateSelectionScreenState();
// }

// class _CertificateSelectionScreenState extends State<CertificateSelectionScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _fullNameController = TextEditingController();
//   bool _selectedCertificateType = false;

//   Future<void> _submitData() async {
//     if (_formKey.currentState!.validate()) {
//       final fullName = _fullNameController.text;
//       final certificateType = _selectedCertificateType ? 'Type A' : 'Type B';

//       final dio = Dio();
//       try {
//         final response = await dio.post('/api/certificates', data: {
//           'full_name': fullName,
//           'certificate_type': certificateType,
//         });

//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Certificate order submitted successfully!'),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('An error occurred while submitting the data.'),
//             ),
//           );
//         }
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('An error occurred while communicating with the API.'),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Certificate Selection'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _fullNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Full Name',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your full name.';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               CheckboxListTile(
//                 title: const Text('Certificate Type A'),
//                 value: _selectedCertificateType,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedCertificateType = value!;
//                   });
//                 },
//               ),
//               CheckboxListTile(
//                 title: const Text('Certificate Type B'),
//                 value: !_selectedCertificateType,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedCertificateType = !value!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _submitData,
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
