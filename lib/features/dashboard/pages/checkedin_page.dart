// ignore_for_file: must_be_immutable, use_build_context_synchronously

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

  
       void _showErrorSnackbar(BuildContext context , String error ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        duration: Duration(seconds: 3), // Adjust the duration as needed
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  //=========================CheckedIn Api============================
  void getCheckedInList(String day) async {
   setState(() {
     _loading = true;
   });
    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "Property": {"PropertyID": propertyID},
      "ReportName": "Checked In",
      "Day": day.toString(),
    };

    http.Response response = await http.post(Uri.parse(STAYOVER_DATA),
        headers: headers, body: jsonEncode(body));

    print('============Checked in count ${day}=========');
    print(response.body);
    var data;
    if (response.body.isNotEmpty) {
      data = jsonDecode(response.body);
      try {
        if (response.statusCode == 200) {
          CheckedInList.addAll(data);
          setState(() {
            _loading = false;
          });
        } else {
      _showErrorSnackbar(context, "Something Went Wrong ! Please Try Again.");
          setState(() {
            _loading = false;
          });
        }
      } catch (e) {
        _showErrorSnackbar(context, e.toString());
        setState(() {
          _loading = false;
        });
      }
    }
    else{
      CheckedInList.clear();
  
      setState(() {
          _loading = false;
        });

      
    }
  }
}
