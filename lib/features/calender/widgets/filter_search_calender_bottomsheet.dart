import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/route/custom_navigator.dart';

import 'package:intl/intl.dart' as intl;

class FilterSearchCalenderBottomsheet extends StatefulWidget {
  const FilterSearchCalenderBottomsheet({super.key});

  @override
  State<FilterSearchCalenderBottomsheet> createState() =>
      _FilterSearchCalenderBottomsheetState();
}

class _FilterSearchCalenderBottomsheetState
    extends State<FilterSearchCalenderBottomsheet> {
  String? searchBySelectedItem = 'Reservation#';
  TextEditingController searchController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          _buildWidget(),
        ],
      ),
    );
  }

  _buildWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            _buildHeading(),
            const SizedBox(height: 20, child: Divider(thickness: 2)),
            const SizedBox(height: 10),
            _buildSearchFilter(),
            const SizedBox(height: 20),
            _buildFromToDate(),
            const SizedBox(height: 20),
            _buildFindButton(),
          ],
        ),
      );
  _buildHeading() => Text('Filter Calender',
      style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
          color: AppColors.primary, fontSize: 25, fontWeight: FontWeight.w500));
  _buildSearchFilter() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search By',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: searchBySelectedItem,
                    onChanged: (newValue) {
                      setState(() {
                        searchBySelectedItem = newValue!;
                      });
                    },
                    items: AppData.searchByItems.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width * 0.46,
                height: 50,
                child: Center(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              )
            ],
          )
        ],
      );

  _buildFromToDate() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'From Date',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width * 0.4,
                height: 50,
                child: TextFormField(
                  controller:
                      fromDateController, //editing controller of this TextField
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "From Date", //label text of field
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          intl.DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        fromDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Review Date is not selected");
                    }
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To Date',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width * 0.4,
                height: 50,
                child: TextFormField(
                  controller:
                      toDateController, //editing controller of this TextField
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "To Date", //label text of field
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          intl.DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        toDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Review Date is not selected");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      );

  _buildFindButton() => GestureDetector(
        onTap: () {
          CustomNavigator.pop(context);
        },
        child: Container(
            height: Get.height * 0.05,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.primary,
            ),
            child: Center(
              child: Text("Find",
                  style: AppTextStyles.textStyles_PlusJakartaSans_30_700_Primary
                      .copyWith(color: Colors.white, fontSize: 18)),
            )),
      );
}
