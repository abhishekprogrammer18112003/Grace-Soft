import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class RoomsTypePage extends StatefulWidget {
  List<dynamic> calendarInitialData;
  List<dynamic> dropdownList;

  RoomsTypePage(
      {super.key,
      required this.calendarInitialData,
      required this.dropdownList});

  @override
  State<RoomsTypePage> createState() => _RoomsTypePageState();
}

class _RoomsTypePageState extends State<RoomsTypePage> {
  int _selectedItemIndex = 0;
  String _selectedType = 'Condo';
  bool _isFiltering = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterRoomsList(_selectedType);
  }

  List<dynamic> _filterList = [];

  _filterRoomsList(String roomType) {
    setState(() {
      _isFiltering = true;
    });
    _filterList.clear();
    for (var data in widget.calendarInitialData) {
      if (data['RoomType'] == roomType) {
        _filterList.add(data);
      }
    }
    setState(() {
      _isFiltering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Type'),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              _buildDropdown(),
              !_isFiltering
                  ? _buildRoomsList()
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
            ]),
      ),
    );
  }

  _buildDropdown() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: widget.dropdownList[_selectedItemIndex],
              items: widget.dropdownList.map((dynamic item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${item['RoomType']} (Room Type)'),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedItemIndex = widget.dropdownList.indexOf(newValue!);
                  _selectedType = newValue['RoomType'];
                });
                _filterRoomsList(_selectedType);
              },
              style: TextStyle(color: Colors.black, fontSize: 13),
              underline: Container(
                height: 4,
                color: Colors.deepPurple, // Custom underline color
              ),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 28,
              iconEnabledColor: Colors.deepPurple, // Custom icon color
              dropdownColor: Colors.grey[200], // Custom background color
              isExpanded: true, // Allow the dropdown to take full width
              elevation: 8, // Elevation of the dropdown
              focusColor: Colors.deepPurple, // Custom focus color
            ),
          ),
        ),
      );

  _buildRoomsList() => Column(
        children: [
          ..._filterList.map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(199, 158, 158, 158).withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          // height: 30,
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                e['RoomName'],
                                textAlign: TextAlign.center,
                                style: AppTextStyles
                                    .textStyles_PTSans_16_400_Secondary
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                        fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        e['Description'] != ''
                            ? Text(
                                'Description : ',
                                style: AppTextStyles
                                    .textStyles_PlusJakartaSans_30_700_Primary
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                              )
                            : Container(),
                        e['Description'] != ''
                            ? Text(e['Description'])
                            : Container(),
                        e['Description'] != ''
                            ? const SizedBox(
                                child: Divider(
                                  thickness: 1.5,
                                ),
                              )
                            : Container(),
                        e['Amenities'] != ''
                            ? Text(
                                'Amenities : ',
                                style: AppTextStyles
                                    .textStyles_PlusJakartaSans_30_700_Primary
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                              )
                            : Container(),
                        e['Amenities'] != ''
                            ? Text(e['Amenities'])
                            : Container(),
                        const SizedBox(
                          child: Divider(
                            thickness: 1.5,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Regular Rate : ',
                              style: AppTextStyles
                                  .textStyles_PlusJakartaSans_30_700_Primary
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            Text(e['BaseAmount'].toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Week End Charges : ',
                              style: AppTextStyles
                                  .textStyles_PlusJakartaSans_30_700_Primary
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            Text(e['WeekEndCharge'].toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Extra Person Charge - Adult/Child : ',
                              style: AppTextStyles
                                  .textStyles_PlusJakartaSans_30_700_Primary
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            Text(
                                '${e['ExtraPersonChargeAdult'].toString()}/${e['ExtraPersonChargeChildren'].toString()}'),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      );
}
