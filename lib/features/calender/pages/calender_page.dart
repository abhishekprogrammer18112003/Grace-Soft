// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:gracesoft/core/constants/app_colors.dart';
// import 'package:gracesoft/core/constants/app_data.dart';
// import 'package:gracesoft/core/constants/url_constant.dart';
// import 'package:table_sticky_headers/table_sticky_headers.dart';
// import 'package:http/http.dart' as http;

// class CalenderPage extends StatefulWidget {
//   const CalenderPage({super.key});

//   @override
//   State<CalenderPage> createState() => _CalenderPageState();
// }

// class _CalenderPageState extends State<CalenderPage> {
//   List<String> roomName = [
//     "Beach View Rooms",
//     "Cabin Unit",
//     "Country Inn Suite Type",
//     "Country Inn Suite Type 51"
//   ];
//   var weekday = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
//   dynamic calendarInitialData;

//   var date = DateTime.now();
//   //+++++++++++++++++++++API CALL+++++++++++++++++++++++++++

//   void getCalendarInitialData() async {
//     String accessToken = AppData.accessToken;
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken',
//     };

//     dynamic body = {
//       "PropertyId": AppData.propertyId,
//     };

//     http.Response response = await http.post(Uri.parse(INITIAL_DATA),
//         headers: headers, body: jsonEncode(body));

//     print('============Calendar Initial Data=========');
//     print(response.body);

//     if (response.statusCode == 200) {
//       calendarInitialData = jsonDecode(response.body.toString());
//       print(calendarInitialData);
//     } else {
//       print("ERROR");
//     }
//     ;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     getCalendarInitialData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Calendar"),
//         backgroundColor: AppColors.primary,
//         centerTitle: true,
//         leading: const Icon(Icons.calendar_month),
//       ),
//       body: Column(
//         children: [
//           _searchButton(context),
//           Container(
//             padding: const EdgeInsets.only(left: 30, right: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.lightGreen),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         date = date.subtract(Duration(days: 30));
//                       });
//                     },
//                     icon: const Icon(Icons.arrow_back_ios_new),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     var currdate = DateTime.now();
//                     getCalendarInitialData();
//                   },
//                   child: Container(
//                     child: Text(
//                       "${date.month}-${date.year}",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   decoration: const BoxDecoration(
//                       color: Colors.lightGreen, shape: BoxShape.circle),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         date = date.add(Duration(days: 30));
//                       });
//                     },
//                     icon: Icon(Icons.arrow_forward_ios_sharp),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _detailTable(),
//         ],
//       ),
//     );
//   }

//   Expanded _detailTable() {
//     final List<DateTime> next7Days = List.generate(
//       30,
//       (index) => date.add(Duration(days: index)),
//     );
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//         padding: const EdgeInsets.all(10),
//         height: MediaQuery.of(context).size.height * 0.8,
//         width: MediaQuery.of(context).size.height * 0.8,
//         child: Card(
//           elevation: 10,
//           child: StickyHeadersTable(
//             cellDimensions: const CellDimensions.fixed(
//                 contentCellWidth: 100,
//                 contentCellHeight: 50,
//                 stickyLegendWidth: 100,
//                 stickyLegendHeight: 40),
//             columnsLength: roomName.length,
//             rowsLength: roomName.length,
//             columnsTitleBuilder: (columnIndex) {
//               return Text(
//                   "${next7Days[columnIndex].day}-${weekday[next7Days[columnIndex].weekday - 1]}");
//             },
//             rowsTitleBuilder: (rowIndex) {
//               return Container(
//                 height: 49,
//                 width: 90,
//                 decoration: BoxDecoration(border: Border.all()),
//                 child: Center(
//                   child: Text(
//                     roomName[rowIndex],
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             },
//             contentCellBuilder: (columnIndex, rowIndex) {
//               return Container(
//                 height: 49,
//                 width: 97,
//                 decoration: BoxDecoration(border: Border.all()),
//                 child: Center(
//                   child: Text("1"),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Center _searchButton(BuildContext context) {
//     return Center(
//       child: Container(
//         margin: const EdgeInsets.all(20),
//         width: MediaQuery.of(context).size.width * 0.97,
//         decoration: BoxDecoration(
//             border: Border.all(), borderRadius: BorderRadius.circular(25)),
//         child: const TextField(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(borderSide: BorderSide.none),
//             contentPadding: EdgeInsets.zero,
//             hintText: 'Search Room',
//             prefixIcon: Icon(Icons.search),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
  List<dynamic> _calendarInitialData = [];
  List<dynamic> _calendarData = [];
  List<dynamic> _dropdownList = [];
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

    await getCalendarData();
    // filteredItems = _calendarData;

    setState(() {
      _isLoadingCalenderData = false;
    });
  }

  // List<dynamic> filteredItems = [];
  // void filterItems(String value) {
  //   print('filtered');
  //   // filteredItems.clear();
  //   filteredItems = value != ''
  //       ? _calendarData
  //           .where((item) => (item['RoomType'] as String)
  //               .trim()
  //               .toLowerCase()
  //               .contains(value.trim().toLowerCase()))
  //           .toList()
  //       : _calendarData;
  //   print(filteredItems);
  // }

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
                                    calendarInitialData: _calendarInitialData,
                                    dropdownList: _dropdownList,
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

  // _buildHeader() => Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           SizedBox(
  //             width: Get.width * 0.8,
  //             child: TextFormField(
  //               onChanged: (value) {
  //                 filterItems(value);
  //                 setState(() {
  //                   filteredItems.clear();
  //                 });
  //               },
  //               controller: _searchRoomController,
  //               keyboardType: TextInputType.text,
  //               decoration: InputDecoration(
  //                   suffixIcon: const Icon(Icons.search),
  //                   focusedBorder: OutlineInputBorder(
  //                       borderSide: const BorderSide(color: AppColors.primary),
  //                       borderRadius: BorderRadius.circular(20)),
  //                   focusColor: AppColors.primary,
  //                   hintText: "Search Room Type",
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(20))),
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () {
  //               showModalBottomSheet<dynamic>(
  //                   shape: const RoundedRectangleBorder(
  //                       borderRadius:
  //                           BorderRadius.vertical(top: Radius.circular(45))),
  //                   isScrollControlled: false,
  //                   context: context,
  //                   builder: (BuildContext bc) {
  //                     return const Padding(
  //                         padding:
  //                             EdgeInsets.symmetric(vertical: 25, horizontal: 5),
  //                         child: FilterSearchCalenderBottomsheet());
  //                   });
  //             },
  //             child: const CircleAvatar(
  //                 radius: 20,
  //                 backgroundColor: AppColors.primary,
  //                 child: Icon(Icons.filter_list_alt, color: Colors.white)),
  //           ),
  //         ],
  //       ),
  //     );

  // _buildCalenderShimmerPlaceholder() {
  //   return Shimmer.fromColors(
  //       baseColor: Colors.grey.shade300,
  //       highlightColor: Colors.grey.shade100,
  //       child: SizedBox(
  //         height: MediaQuery.of(context).size.height * 1,
  //         child: ListView.builder(
  //             itemCount: 5,
  //             itemBuilder: (context, index) {
  //               return Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Card(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: const Text(
  //                       '',
  //                       style: TextStyle(fontSize: 120),
  //                     )),
  //               );
  //             }),
  //       ));
  // }

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
    String accessToken = AppData.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    dynamic body = {
      "PropertyId": AppData.propertyId,
    };

    http.Response response = await http.post(Uri.parse(INITIAL_DATA),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      _calendarInitialData = jsonDecode(response.body.toString())['Rooms'];
      final groupedData =
          groupBy(_calendarInitialData, (data) => data['RoomType']);

      // Extract the first occurrence from each group to get unique values
      _dropdownList = groupedData.values.map((group) => group.first).toList();
      for (var data in _calendarInitialData) {
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
    String accessToken = AppData.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    dynamic body = {
      "Property": {"PropertyID": AppData.propertyId},
      "StartDate": fromDateController.text.toString(),
      "EndDate": toDateController.text.toString()
    };

    http.Response response = await http.post(Uri.parse(CALENDAR_DATA),
        headers: headers, body: jsonEncode(body));

    print('============Calendar Data=========');

    if (response.statusCode == 200) {
      _calendarData =
          jsonDecode(response.body.toString())['CalendarRoomsResponse'];
      // filteredItems = _calendarData;
      return _calendarData;
    } else {
      print("ERROR");
      return _calendarData;
    }
  }
}
