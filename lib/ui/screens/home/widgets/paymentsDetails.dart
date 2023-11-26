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
