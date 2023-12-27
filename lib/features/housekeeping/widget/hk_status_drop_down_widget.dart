// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class HKStatusDropDown extends StatefulWidget {
  String selectedIndex;
Function(int) ontap;
  HKStatusDropDown({super.key, required this.selectedIndex , required this.ontap});

  @override
  State<HKStatusDropDown> createState() => _HKStatusDropDownState();
}

class _HKStatusDropDownState extends State<HKStatusDropDown> {
  List<String> status = ["Select","Dirty", "Clean", "Vacant", "Invalid Card"];
  String selectIndex = "Select"; // Initialize with "Select"

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex.isNotEmpty) {
      if(widget.selectedIndex == "Dirty & UnAssigned"){
        selectIndex = 'Dirty';
      }
      else{

          selectIndex = widget.selectedIndex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: (){
        showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: status.map((item) {
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    selectIndex = item;
                    if(selectIndex == "Vacant"){
              widget.ontap(1);
            }
            if(selectIndex == "Dirty & UnAssigned"){
              widget.ontap(2);
            }
            if(selectIndex == "Clean"){
              widget.ontap(3);
            }
            if(selectIndex == "Invalid Card"){
              widget.ontap(4);
            }
            if(selectIndex == "Dirty"){
              widget.ontap(2);
              
            }

                  });
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
        width: 130,
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
