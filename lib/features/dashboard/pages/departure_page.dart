// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:gracesoft/features/dashboard/widgets/member_details_card_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class DeparturePage extends StatefulWidget {
  Map<String, dynamic> arguements;
  DeparturePage({super.key, required this.arguements});

  @override
  State<DeparturePage> createState() => _DeparturePageState();
}

class _DeparturePageState extends State<DeparturePage> {
  bool _loading = false;
  List<dynamic> DepartureList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDepartureList(widget.arguements['day']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('${widget.arguements['day']} Departure',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: !_loading
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: ListView.builder(
                  itemCount: DepartureList.length,
                  itemBuilder: (context, index) {
                    return MemberDetailsCardWidget(
                      stayoverData: DepartureList[index],
                      ArrivalData: null,
                    );
                  }),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildDepartureShimmerPlaceholder() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: MemberDetailsCardWidget(
          stayoverData: {},
          ArrivalData: null,
        ));
  }

  //=========================Departure Api============================
  void getDepartureList(String day) async {
    _loading = true;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = AppData.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "Property": {"PropertyID": AppData.propertyId},
      "ReportName": "Departure",
      "Day": day.toString(),
    };

    http.Response response = await http.post(Uri.parse(STAYOVER_DATA),
        headers: headers, body: jsonEncode(body));

    print('============dashboard count ${day}=========');
    print(response.body);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      DepartureList.addAll(data);
      setState(() {
        _loading = false;
      });
    } else {
      Get.snackbar('Something went wrong !',
          'Something went wrong . Please try again After sometime',
          backgroundColor: Colors.orange);
      setState(() {
        _loading = false;
      });
    }
  }
}
