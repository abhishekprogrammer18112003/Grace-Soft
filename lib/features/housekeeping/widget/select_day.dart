import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class select_day extends StatefulWidget {
  const select_day({super.key});

  @override
  State<select_day> createState() => _select_dayState();
}

class _select_dayState extends State<select_day> {
  String selectedIndex = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton(
        elevation: 0,
        dropdownColor: Colors.white,
        value: selectedIndex,
        items: <String>[
          'YesterDay',
          'Today',
          'Tomorow',
          // 'Option 4',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedIndex = value.toString();
          });
        },
      ),
    );
  }
}
