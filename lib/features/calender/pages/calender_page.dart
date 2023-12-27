
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:gracesoft/features/calender/pages/rooms_type_page.dart';
import 'package:gracesoft/features/calender/widgets/calender_details_card_widget.dart';
import 'package:gracesoft/features/calender/widgets/filter_search_calender_bottomsheet.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:collection/collection.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  List<dynamic> _calendarData = [];
  List<dynamic> _roomsData = [];
  TextEditingController _searchRoomController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  bool _isLoadingCalenderData = false;

  @override
  void initState() {
    super.initState();
    String formattedDate = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    fromDateController.text = formattedDate;
    toDateController.text = formattedDate;
    initialize();
  }

  initialize() async {
    setState(() {
      _isLoadingCalenderData = true;
    });
    await getCalendarInitialData();

    // await getCalendarInitialData();

    await getCalendarData();
    // filteredItems = _calendarData;

    setState(() {
      _isLoadingCalenderData = false;
    });
  }



  dynamic getRoomNameFromId(int roomId) {
    dynamic room = _roomsData.firstWhere((room) => room['RoomID'] == roomId,
        orElse: () => null);

    return room;
  }

  Color getColor(String status) {
    print(status);
    if (status == 'Booked') {
      return const Color.fromARGB(255, 252, 17, 0);
    }
    if (status == 'Confirmed') {
      return Colors.green;
    }
    if (status == 'Checked-In') {
      return Colors.deepPurple;
    }
    if (status == 'Checked-Out') {
      return Colors.purple;
    }
    if (status == '') {
      return Colors.grey;
    }
    if (status == 'FullyPaid') {
      return Colors.yellow;
    }
    if (status == 'NonPaid') {
      return Colors.orange;
    }
    if (status == 'Group') {
      return Colors.blue;
    }
    if (status == 'Shared') {
      return Colors.lightGreen;
    }
    if (status == 'Vacant') {
      return Colors.blueGrey;
    }
    if (status == 'Dirty') {
      return Colors.black54;
    }
    if (status == 'Clean') {
      return Colors.limeAccent;
    } else {
      return Colors.deepOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calendar"),
          backgroundColor: AppColors.primary,
          // centerTitle: true,
          // leading: const Icon(Icons.calendar_month),
          actions: [
            !_roomsData.isEmpty
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomsTypePage(
                                    calendarInitialData: AppData.calendarInitialData,
                                    dropdownList: AppData.dropdownList,
                                  )));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(Icons.meeting_room),
                    ))
                : Container(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              // _buildHeader(),
              _buildFromToDate(),
              const SizedBox(height: 10),
              _buildCalenderDataList()
            ],
          ),
        ),
      ),
    );
  }

  _buildFromToDate() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.45,
                child: TextFormField(
                  controller: fromDateController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                    ),
                    labelText: 'from',
                    labelStyle: const TextStyle(color: AppColors.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          intl.DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        fromDateController.text = formattedDate;
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
              SizedBox(
                width: Get.width * 0.45,
                child: TextFormField(
                  controller: toDateController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    labelText: 'to',
                    labelStyle: TextStyle(color: AppColors.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          intl.DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        toDateController.text = formattedDate;
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

  

  _buildCalenderDataList() => SizedBox(
      child: !_isLoadingCalenderData
          ? FutureBuilder(
              future: getCalendarData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ..._calendarData.map((e) {
                      dynamic data = getRoomNameFromId(e['RoomId']);
                      Color color = getColor(e['Status']);

                      return CalenderDetailsCardWidget(
                        calenderData: e,
                        roomsData: data,
                        color: color,
                      );
                    })
                  ],
                );
              })
          : const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ));

  //==========================Calender Initial Data====================================
  Future<void> getCalendarInitialData() async {
    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    dynamic body = {
      "PropertyId": propertyID,
    };

    http.Response response = await http.post(Uri.parse(INITIAL_DATA),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      AppData.calendarInitialData = jsonDecode(response.body.toString())['Rooms'];
      final groupedData =
          groupBy(AppData.calendarInitialData, (data) => data['RoomType']);

      // Extract the first occurrence from each group to get unique values
      AppData.dropdownList = groupedData.values.map((group) => group.first).toList();
      for (var data in AppData.calendarInitialData) {
        dynamic roomData = {
          "RoomName": data['RoomName'],
          "RoomType": data['RoomType'],
          "RoomID": data['RoomID']
        };
        _roomsData.add(roomData);
      }
    } else {
      print("ERROR");
    }
  }

  //======================================Calender Data=====================
  Future<List<dynamic>> getCalendarData() async {


 String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    dynamic body = {
      "Property": {"PropertyID": propertyID},
      "StartDate": fromDateController.text.toString(),
      "EndDate": toDateController.text.toString()
    };

    http.Response response = await http.post(Uri.parse(CALENDAR_DATA),
        headers: headers, body: jsonEncode(body));

    print('============Calendar Data=========');

    if (response.statusCode == 200) {
      _calendarData =
          jsonDecode(response.body.toString())['CalendarRoomsResponse'];
  
      return _calendarData;
    } else {
      print("ERROR");
      return _calendarData;
    }
  }
}
