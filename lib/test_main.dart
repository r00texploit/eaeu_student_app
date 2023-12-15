// // import 'package:flutter/material.dart'

// import 'package:flutter/material.dart';
// import 'package:multi_selection_filter/multi_selection_filter.dart';

// void main() {
//   runApp(const MultiSelectionFilterScreen());
// }

// class MultiSelectionFilterScreen extends StatefulWidget {
//   const MultiSelectionFilterScreen({Key? key}) : super(key: key);

//   @override
//   _MultiSelectionFilterScreenState createState() =>
//       _MultiSelectionFilterScreenState();
// }

// class _MultiSelectionFilterScreenState
//     extends State<MultiSelectionFilterScreen> {
//   List<bool> selectedItems = [];
//   List<String> selectedValueItems = [];

//   var list = ["opt1", "opt2", "opt3"];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Multi Selection Filter'),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 16.0),
//           MultiSelectionFilter(
//             doneButtonTextColor: Colors.black,
//             doneButtonBG: Colors.white38,
//             checkboxTitleTextColor: Colors.amberAccent,
//             checkboxTitleBG: Colors.white,
//             checkboxCheckColor: Colors.black,
//             accentColor: Colors.blueAccent,
//             title: 'Select Options',
//             textListToShow: list,
//             selectedList: selectedItems,
//             onCheckboxTap: (value, selected, isSelected) {
//               if (isSelected) {
//                 setState(() {
//                   selectedValueItems.add(value);
//                 });
//               } else {
//                 setState(() {
//                   selectedValueItems.remove(value);
//                 });
//               }
//             },
//             child: Column(
//               children: [
//                 Text('Option 1'),
//                 Text('Option 2'),
//                 Text('Option 3'),
//               ],
//             ),
//             // onSelectionChanged: (selectedItems) {
//             //   setState(() {
//             //     this.selectedItems = selectedItems;
//             //   });
//             // },
//             // selectedItems: selectedItems,
//           ),
//           const SizedBox(height: 16.0),
//           Text('Selected Items: ${selectedItems.join(', ')}'),
//           const SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               // Perform action based on selected items
//               print('Selected Items: ${selectedItems.join(', ')}');
//             },
//             child: const Text('Submit'),
//           ),
//         ],
//       ),
//       //   ],
//       // ),
//     ));
//   }
// }
