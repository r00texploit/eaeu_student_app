import 'package:flutter/material.dart';
import 'package:student/data/models/certificate_response.dart';
// import 'package:multi_select_flutter_app/multi_select_flutter.dart';
// import 'checkbox_widget.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Multi Select Checkbox'),
//         ),
//         body: MultiSelectCheckbox(
//           options: ["opt1", "opt2", "opt3", "opt4"],
//           selectedOptions: [],
//           onSelectionChanged: (List<dynamic> selectedOptions) {
//             print(selectedOptions);
//           },
//         ),
//       ),
//     );
//   }
// }
class MultiSelectCheckbox extends StatefulWidget {
  final List<Certificate> options;
  final List<int> selectedOptions;
  final Function(List<int>) onSelectionChanged;
  MultiSelectCheckbox({
   required this.options,
   required this.selectedOptions,
   required this.onSelectionChanged,
  });
  @override
  _MultiSelectCheckboxState createState() => _MultiSelectCheckboxState();
}
class _MultiSelectCheckboxState extends State<MultiSelectCheckbox> {
  List<int> _selectedOptions = [];
  @override
  void initState() {
   super.initState();
   _selectedOptions = widget.selectedOptions;
  }
  void _onCheckboxSelected(int option) {
   if (_selectedOptions.contains(option)) {
   _selectedOptions.remove(option);
   } else {
   _selectedOptions.add(option);
   }
   widget.onSelectionChanged(_selectedOptions);
   setState(() {});
  }
  @override
  Widget build(BuildContext context) {
   return Column(
   children: widget.options
   .map((option) => CheckboxListTile(
   title: Text(option.name),
   value: _selectedOptions.contains(option.id),
   onChanged: (bool? value) {
   _onCheckboxSelected(option.id);
   },
   ))
   .toList(),
   );
  }
}
class CheckboxWidget extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;
  CheckboxWidget({
   required this.title,
   required this.value,
   required this.onChanged,
  });
  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}
class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _value = false;
  @override
  void initState() {
   super.initState();
   _value = widget.value;
  }
  @override
  Widget build(BuildContext context) {
   return CheckboxListTile(
   title: Text(widget.title),
   value: _value,
   onChanged: (value) {
   setState(() {
   _value = value!;
   widget.onChanged(value);
   });
   },
   );
  }
}