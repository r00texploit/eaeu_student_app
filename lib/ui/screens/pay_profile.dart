//// '''' Test one

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // import 'package:your_app_name/your_cubit.dart';

// class PaymentPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//       ),
//       body: BlocBuilder<YourCubit, YourState>(

//         builder: (context, state) {
//           return ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'First Name',
//                 ),
//                 onChanged: (value) {
//                   // Update first name in cubit
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Last Name',
//                 ),
//                 onChanged: (value) {
//                   // Update last name in cubit
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 onChanged: (value) {
//                   // Update email in cubit
//                 },
//               ),
//               // Add more text fields for additional user info
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


//// '''' Test Two


// // import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class YourState {}

// class YourInitialState extends YourState {}

// class YourCubit extends Cubit<YourState> {
//   YourCubit() : super(YourInitialState());

//   // Add your cubit functionality here
// }

// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter/material.dart';

// Define the payment state
// // enum PaymentState {
// //   initial,
// //   loading,
// //   success,
// //   error,
// // }
// Define the payment cubit
// // class PaymentCubit extends Cubit<PaymentState> {
// //   PaymentCubit() : super(PaymentState.initial);

// //   // Function to initiate the payment process
// //   Future<void> initiatePayment(String cardNumber, String expiryDate, String cvv) async {
// //     emit(PaymentState.loading);
// //     // Simulate payment processing
// //     await Future.delayed(const Duration(seconds: 2));
// //     // Generate random payment result
// //     final bool isPaymentSuccessful = Random().nextBool();

// //     if (isPaymentSuccessful) {
// //       emit(PaymentState.success);
// //     } else {
// //       emit(PaymentState.error);
// //     }
// //   }
// // }
// //     emit(PaymentState.loading);
// //     // Simulate payment processing
// //     await Future.delayed(const Duration(seconds: 2));
// //     // Generate random payment result
// //     final bool isPaymentSuccessful = Random().nextBool();

// //     if (isPaymentSuccessful) {
// //       emit(PaymentState.success);
// //     } else {
// //       emit(PaymentState.error);
// //     }
// //   }
// // }

// Create the payment page widget
// // class PaymentPage extends StatelessWidget {
// //   const PaymentPage({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => PaymentCubit(),
// //       child: BlocBuilder<PaymentCubit, PaymentState>(
// //         builder: (context, state) {
// //           return Scaffold(
// //             appBar: AppBar(
// //               title: const Text('Payment'),
// //             ),
// //             body: state.when(
// //               initial: () => const Padding(
// //                 padding: EdgeInsets.all(16.0),
// //                 child: Text('Enter your payment details'),
// //               ),
// //               loading: () => const Center(
// //                 child: CircularProgressIndicator(),
// //               ),
// //               success: () => const Center(
// //                 child: Text('Payment successful!'),
// //               ),
// //               error: () => const Center(
// //                 child: Text('Payment failed. Please try again.'),
// //               ),
// //             ),
// //             floatingActionButton: state.when(
// //               initial: () => FloatingActionButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                 },
// //                 child: const Icon(Icons.cancel),
// //               ),
// //               loading: () => const SizedBox.shrink(),
// //               success: () => FloatingActionButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                 },
// //                 child: const Icon(Icons.check),
// //               ),
// //               error: () => FloatingActionButton(
// //                 onPressed: () {
// //                   // Reset the cubit state to initial
// //                   context.read<PaymentCubit>().emit(PaymentState.initial);
// //                 },
// //                 child: const Icon(Icons.refresh),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

//// '''' Test three
// import 'dart:math';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Define the payment state
// enum PaymentState {
//   initial,
//   loading,
//   success,
//   error,
//   // when,
// }

// // Define the payment cubit
// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(PaymentState.initial);

//   // Function to initiate the payment process
//   void initiatePayment(
//     String cardNumber,
//     String expiryDate,
//     String cvv,
//     String cardHolderName,
//     String billingAddress,
//   ) async {
//     emit(PaymentState.loading);
//     // Simulate payment processing
//     await Future.delayed(const Duration(seconds: 2));
//     // Generate random payment result
//     final bool isPaymentSuccessful = Random().nextBool();

//     if (isPaymentSuccessful) {
//       emit(PaymentState.success);
//     } else {
//       emit(PaymentState.error);
//     }
//   }
//   // @override
//   void when(initial,loading,success,error){

//   }

// }

// // Create the payment page widget
// class PaymentPage extends StatelessWidget {
//   const PaymentPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PaymentCubit(),
//       child: BlocBuilder<PaymentCubit, PaymentState>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Payment'),
//             ),
//             body: state.when(
//               initial: () => _buildPaymentForm(context),
//               loading: () => const Center(
//                 child: CircularProgressIndicator(),
//               ),
//               success: () => const Center(
//                 child: Text('Payment successful!'),
//               ),
//               error: () => const Center(
//                 child: Text('Payment failed. Please try again.'),
//               ),
//             ),
//             floatingActionButton: state.when(
//               initial: () => FloatingActionButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Icon(Icons.cancel),
//               ),
//               loading: () => const SizedBox.shrink(),
//               success: () => FloatingActionButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Icon(Icons.check),
//               ),
//               error: () => FloatingActionButton(
//                 onPressed: () {
//                   // Reset the cubit state to initial
//                   context.read<PaymentCubit>().emit(PaymentState.initial);
//                 },
//                 child: const Icon(Icons.refresh),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPaymentForm(BuildContext context) {
//     final cardNumberController = TextEditingController();
//     final expiryDateController = TextEditingController();
//     final cvvController = TextEditingController();
//     final cardHolderNameController = TextEditingController();
//     final billingAddressController = TextEditingController();

//     return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const Text('Card Number'),
//           TextField(
//             controller: cardNumberController,
//             decoration: const InputDecoration(
//               hintText: 'Enter your card number',
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           const Text('Expiry Date'),
//           TextField(
//             controller: expiryDateController,
//             decoration: const InputDecoration(
//               hintText: 'Enter expiry date (MM/YY)',
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           const Text('CVV'),
//           TextField(
//             controller: cvvController,
//             decoration: const InputDecoration(
//               hintText: 'Enter CVV',
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           const Text('Card Holder Name'),
//           TextField(
//             controller: cardHolderNameController,
//             decoration: const InputDecoration(
//               hintText: 'Enter card holder name',
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           const Text('Billing Address'),
//           TextField(
//             controller: billingAddressController,
//             decoration: const InputDecoration(
//               hintText: 'Enter billing address',
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               // Retrieve the input values from the text fields
//               final cardNumber = cardNumberController.text;
//               final expiryDate = expiryDateController.text;
//               final cvv = cvvController.text;
//               final cardHolderName = cardHolderNameController.text;
//               final billingAddress = billingAddressController.text;

//               // Initiate the payment process using the PaymentCubit
//               context.read<PaymentCubit>().initiatePayment(
//                     cardNumber,
//                     expiryDate,
//                     cvv,
//                     cardHolderName,
//                     billingAddress,
//                   );
//             },
//             child: Icon(Icons.payment),
//           )
//         ]));
//   }
// }
