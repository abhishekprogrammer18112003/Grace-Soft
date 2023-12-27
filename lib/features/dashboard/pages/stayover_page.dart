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

class StayoverPage extends StatefulWidget {
  Map<String, dynamic> arguements;
  StayoverPage({super.key, required this.arguements});

  @override
  State<StayoverPage> createState() => _StayoverPageState();
}

class _StayoverPageState extends State<StayoverPage> {
  bool _loading = false;
  List<dynamic> stayOverList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStayoverList(widget.arguements['day']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('${widget.arguements['day']} Stayover',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: !_loading
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: stayOverList.isNotEmpty
                  ? ListView.builder(
                      itemCount: stayOverList.length,
                      itemBuilder: (context, index) {
                        return MemberDetailsCardWidget(
                          stayoverData: stayOverList[index],
                          ArrivalData: null,
                        );
                      })
                  : Center(
                      child: Text('No Stayovers ${widget.arguements['day']}'),
                    ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildSatyoverShimmerPlaceholder() {
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

  //=========================StayOver Api============================
  void getStayoverList(String day) async {
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
      "ReportName": "Stayover",
      "Day": day.toString(),
    };

    http.Response response = await http.post(Uri.parse(STAYOVER_DATA),
        headers: headers, body: jsonEncode(body));

    print('============dashboard count ${day}=========');
    print(response.body);
    var data;
    if (response.body.isNotEmpty) {
      data = jsonDecode(response.body);
      try {
        if (response.statusCode == 200) {
          stayOverList.addAll(data);
          setState(() {
            _loading = false;
          });
        } else {
          _showErrorSnackbar(context,"Something went wrong ! Please try again");
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
      stayOverList.clear();
      setState(() {
          _loading = false;
        });

      
    }
  }
}
