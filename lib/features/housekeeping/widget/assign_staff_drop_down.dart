// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class AssignStaffDropDown extends StatefulWidget {
  String selectedIndex;
  List<dynamic> staff;
  
  
  // ignore: avoid_types_as_parameter_names
  Function(String) onTap;
  AssignStaffDropDown({super.key, required this.selectedIndex ,required this.staff , required this.onTap});

  @override
  State<AssignStaffDropDown> createState() => _AssignStaffDropDownState();
}

class _AssignStaffDropDownState extends State<AssignStaffDropDown> {
 
  String selectIndex = "Select"; // Initialize with "Select"

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex.isNotEmpty) {
      selectIndex = widget.selectedIndex;
    }
    // print(widget.staff);
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: Get.width * 0.41,
    //   padding: EdgeInsets.symmetric(horizontal: 8.0),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Colors.grey),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton<String>(
    //       value: selectIndex,
    //       onChanged: (newValue) {
    //         setState(() {
    //           selectIndex = newValue!;
    //         });
    //       },
    //       items: const [
           
    //         DropdownMenuItem(
    //           value: 'Dirty',
    //           child: Text('Dirty'),
    //         ),
    //         DropdownMenuItem(
    //           value: 'Clean',
    //           child: Text('Clean'),
    //         ),
    //         DropdownMenuItem(
    //           value: 'Vacant',
    //           child: Text('Vacant'),
    //         ),
    //         DropdownMenuItem(
    //           value: 'Invalid Card',
    //           child: Text('Invalid Card'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return GestureDetector(
      onTap: (){
        showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text("Select Staff"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.staff.map((item) {
              return ListTile(
                title: Text(item["WorkerName"]),
                onTap: () {
                  setState(() {
                    selectIndex = item["WorkerName"];
                  });
                    widget.onTap(selectIndex);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
      },
      child: Container(
        width : 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 171, 180, 190)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectIndex , style: AppTextStyles.textStyles_PTSans_16_400_Secondary.copyWith(fontSize: 14 ,),),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
