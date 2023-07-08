import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class assignButton extends StatefulWidget {
  assignButton({super.key});

  @override
  State<assignButton> createState() => _select_dayState();
}

class _select_dayState extends State<assignButton> {
  String selectedIndex = 'T';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton(
        hint: Text("Select"),
        value: selectedIndex,
        items: <String>[
          'Y',
          'T',
          'To',
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
