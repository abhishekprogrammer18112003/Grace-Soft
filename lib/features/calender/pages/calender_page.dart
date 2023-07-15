import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:http/http.dart' as http;

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  List<String> roomName = [
    "Beach View Rooms",
    "Cabin Unit",
    "Country Inn Suite Type",
    "Country Inn Suite Type 51"
  ];
  var weekday = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
  dynamic calendarInitialData;

  var date = DateTime.now();
  //+++++++++++++++++++++API CALL+++++++++++++++++++++++++++

  void getCalendarInitialData() async {
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

    print('============Calendar Initial Data=========');
    print(response.body);

    if (response.statusCode == 200) {
      calendarInitialData = jsonDecode(response.body.toString());
      print(calendarInitialData);
    } else {
      print("ERROR");
    }
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    getCalendarInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: const Icon(Icons.calendar_month),
      ),
      body: Column(
        children: [
          _searchButton(context),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.lightGreen),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        date = date.subtract(Duration(days: 30));
                      });
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var currdate = DateTime.now();
                    getCalendarInitialData();
                  },
                  child: Container(
                    child: Text(
                      "${date.month}-${date.year}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.lightGreen, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        date = date.add(Duration(days: 30));
                      });
                    },
                    icon: Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ),
              ],
            ),
          ),
          _detailTable(),
        ],
      ),
    );
  }

  Expanded _detailTable() {
    final List<DateTime> next7Days = List.generate(
      30,
      (index) => date.add(Duration(days: index)),
    );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.height * 0.8,
        child: Card(
          elevation: 10,
          child: StickyHeadersTable(
            cellDimensions: const CellDimensions.fixed(
                contentCellWidth: 100,
                contentCellHeight: 50,
                stickyLegendWidth: 100,
                stickyLegendHeight: 40),
            columnsLength: roomName.length,
            rowsLength: roomName.length,
            columnsTitleBuilder: (columnIndex) {
              return Text(
                  "${next7Days[columnIndex].day}-${weekday[next7Days[columnIndex].weekday - 1]}");
            },
            rowsTitleBuilder: (rowIndex) {
              return Container(
                height: 49,
                width: 90,
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                  child: Text(
                    roomName[rowIndex],
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            contentCellBuilder: (columnIndex, rowIndex) {
              return Container(
                height: 49,
                width: 97,
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                  child: Text("1"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Center _searchButton(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.97,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(25)),
        child: const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.zero,
            hintText: 'Search Room',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
