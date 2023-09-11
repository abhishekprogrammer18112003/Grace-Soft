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

class CheckedinPage extends StatefulWidget {
  Map<String, dynamic> arguements;
  CheckedinPage({super.key, required this.arguements});

  @override
  State<CheckedinPage> createState() => _CheckedinPageState();
}

class _CheckedinPageState extends State<CheckedinPage> {
  bool _loading = false;
  List<dynamic> CheckedInList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCheckedInList(widget.arguements['day']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('${widget.arguements['day']} CheckedIn',
            style: const TextStyle(
                fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: !_loading
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: CheckedInList.isNotEmpty
                  ? ListView.builder(
                      itemCount: CheckedInList.length,
                      itemBuilder: (context, index) {
                        return MemberDetailsCardWidget(
                          stayoverData: CheckedInList[index],
                          ArrivalData: null,
                        );
                      })
                  : Center(
                      child: Text('No Checked-In ${widget.arguements['day']}'),
                    ))
          : const Center(
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

  //=========================CheckedIn Api============================
  void getCheckedInList(String day) async {
    _loading = true;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = AppData.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "Property": {"PropertyID": AppData.propertyId},
      "ReportName": "Checked In",
      "Day": day.toString(),
    };

    http.Response response = await http.post(Uri.parse(STAYOVER_DATA),
        headers: headers, body: jsonEncode(body));

    print('============dashboard count ${day}=========');
    print(response.body);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      CheckedInList.addAll(data);
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
