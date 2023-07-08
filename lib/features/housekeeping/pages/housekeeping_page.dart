import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/housekeeping/widget/select_day.dart';
import 'package:gracesoft/features/housekeeping/widget/status.dart';

import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:flutter/material.dart';

class HouseKeepingPage extends StatefulWidget {
  const HouseKeepingPage({super.key});

  @override
  State<HouseKeepingPage> createState() => _HouseKeepingPageState();
}

class _HouseKeepingPageState extends State<HouseKeepingPage> {
  List<int> list = [1, 6, 4, 21, 43, 13, 43, 123];
  DateTime date = DateTime.now();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: const Icon(
          Icons.house_outlined,
          size: 30,
        ),
        centerTitle: true,
        title: Text(
          "HouseKeeping",
          style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "HouseKeeping:${date.day}-${date.month}-${date.year}",
                      style: AppTextStyles.defaultTextStyle
                          .copyWith(fontSize: 16, color: Colors.black),
                    ),
                    select_day(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: _status(),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _statusDetail(),
          ],
        ),
      ),
    );
  }

  _statusDetail() => Expanded(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(7),
            child: LandingPage(),
          ),
        ),
      );

  _status() => Wrap(
        children: [
          status_container(stat: 0, stat_name: "Clean", stat_col: Colors.green),
          status_container(stat: 1, stat_name: "Dirty", stat_col: Colors.brown),
          status_container(
              stat: 0, stat_name: "Inspected", stat_col: Colors.yellow),
          status_container(stat: 2, stat_name: "Owner", stat_col: Colors.blue),
          status_container(
              stat: 0, stat_name: "Dirty& ", stat_col: Colors.pink),
        ],
      );
}

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
// titleColumn - List<String> (title column)
// titleColumn - List<String> (title row)
// titleColumn - List<List<String>> (data)
  List<String> titleColumn = [
    'Arrival',
    'Departure',
    'Room Notes',
    'Reservation status',
    'HouseKeeping status',
    'Assign Staff',
    'Housekeeping Notes'
  ];
  List<String> titleRow = [
    'Bungalow 3',
    'Bungalow 5',
    'Cabin Room 1',
    'Cabin Room 2'
  ];
  List<List<Widget>> data = [
    [
      Text("Arr Date"),
      Text("Dept Date"),
      Icon(Icons.note_alt_sharp),
      Text("vacant"),
      Text("hello"),
      Text("select"),
      Icon(Icons.note_alt_sharp),
    ],
    [
      Text("Arr Date"),
      Text("Dept Date"),
      Icon(Icons.note_alt_sharp),
      Text("vacant"),
      Text("hello"),
      Text("hello"),
      Icon(Icons.note_alt_sharp),
    ],
    [
      Text("Arr Date"),
      Text("Dept Date"),
      Icon(Icons.note_alt_sharp),
      Text("vacant"),
      Text("hello"),
      Text("hello"),
      Icon(Icons.note_alt_sharp),
    ],
    [
      Text("Arr Date"),
      Text("Dept Date"),
      Icon(Icons.note_alt_sharp),
      Text("vacant"),
      Text("hello"),
      Text("hello"),
      Icon(Icons.note_alt_sharp),
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return StickyHeadersTable(
      cellDimensions: const CellDimensions.variableColumnWidth(
        columnWidths: [100, 100, 100, 100, 100, 100, 100],
        contentCellHeight: 40,
        stickyLegendWidth: 100,
        stickyLegendHeight: 50,
      ),
      columnsLength: titleColumn.length,
      rowsLength: titleRow.length,
      columnsTitleBuilder: (columnIndex) {
        return Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(border: Border.all(), color: Colors.grey),
          padding: const EdgeInsets.all(6),
          child: Text(
            titleColumn[columnIndex],
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        );
      },
      rowsTitleBuilder: (rowIndex) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: Text(
            titleRow[rowIndex],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        );
      },
      contentCellBuilder: (columnIndex, rowIndex) {
        return Container(
            height: 18, width: 50, child: data[rowIndex][columnIndex]);
      },
      legendCell: const Text(
        'Room Details',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
