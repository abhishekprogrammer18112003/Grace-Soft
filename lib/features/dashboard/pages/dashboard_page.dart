import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:gracesoft/features/dashboard/widgets/custom_switch_button.dart';
import 'package:gracesoft/features/dashboard/widgets/main_dashboard_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shimmer/shimmer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedButton = 'Today';
  int? arrivalCount;
  // int? tomorrowArrivalCount;

  int? departureCount;
  // int? tomorrowDepartureCount;

  int? bookedCount;
  int? vacantCount;
  int? blockedCount;
  int? stayoverCount;

  bool _countLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeCount();
  }

  _initializeCount() async {
    await getDashboardCounts("Today");
    await getCheckedInCounts("Today");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        // leading: const Icon(
        //   Icons.hotel,
        //   color: Colors.white,
        //   size: 30,
        // ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 13.0),
        //     child: Icon(Icons.refresh),
        //   ),
        // ],
        title: Text('Dashboard',
            style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  label: 'Today',
                  isSelected: _selectedButton == 'Today',
                  onPressed: () {
                    setState(() {
                      _selectedButton = 'Today';
                    });
                    getDashboardCounts("Today");
                    getCheckedInCounts("Today");
                  },
                ),
                CustomButton(
                  label: 'Tomorrow',
                  isSelected: _selectedButton == 'Tomorrow',
                  onPressed: () {
                    setState(() {
                      _selectedButton = 'Tomorrow';
                    });
                    getDashboardCounts("Tomorrow");
                    getCheckedInCounts("Tomorrow");
                  },
                ),
              ],
            ),
            !_countLoading
                ? DashboardWidget(
                    arrivalCount: arrivalCount!,
                    departureCount: departureCount!,
                    bookedCount: bookedCount!,
                    vacantCount: vacantCount!,
                    blockedCount: blockedCount!,
                    stayoverCount: stayoverCount!,
                    day: _selectedButton,
                    checkInCount: checkedInList.length,
                    checkedInData: checkedInList,
                  )
                : _buildCountShimmerPlaceholder(),
          ],
        ),
      ),
    );
  }

  Widget _buildCountShimmerPlaceholder() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: DashboardWidget(
          checkInCount: 0,
          arrivalCount: 0,
          blockedCount: 0,
          day: '',
          departureCount: 0,
          bookedCount: 0,
          stayoverCount: 0,
          vacantCount: 0,
          checkedInData: [],
        ));
  }

  //=============================Checkedin COUNTS API CALL=============================
  List<dynamic> checkedInList = [];
  getCheckedInCounts(String day) async {
    _countLoading = true;
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
    //checkin
    http.Response response = await http.post(Uri.parse(CHECKEDIN_DATA),
        headers: headers, body: jsonEncode(body));

    print('============CheckedIn count ${day}=========');
    print(response.body);
    var data = jsonDecode(response.body);
    // checkinCount = 0;

    if (response.statusCode == 200) {
      checkedInList.addAll(data);
      print(data);

      setState(() {
        _countLoading = false;
      });
    } else {
      Get.snackbar('Something went wrong !',
          'Something went wrong . Please try again After sometime',
          backgroundColor: Colors.orange);
      setState(() {
        _countLoading = false;
      });
    }
  }

  getDashboardCounts(String day) async {
    _countLoading = true;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = AppData.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "Property": {"PropertyID": AppData.propertyId},
      "ReportName": "CountDetails",
      "Day": day.toString(),
    };

    http.Response response = await http.post(Uri.parse(DASHBOARD_COUNTS),
        headers: headers, body: jsonEncode(body));

    print('============dashboard count ${day}=========');
    print(response.body);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      arrivalCount = data['Arrival'];
      departureCount = data['Depature'];
      bookedCount = data['Booked'];
      vacantCount = data['Vacant'];
      blockedCount = data['Blocked'];
      stayoverCount = data['StayOver'];

      print(arrivalCount);
      print(departureCount);
      print(bookedCount);
      print(vacantCount);
      print(blockedCount);

      setState(() {
        _countLoading = false;
      });
    } else {
      Get.snackbar('Something went wrong !',
          'Something went wrong . Please try again After sometime',
          backgroundColor: Colors.orange);
      setState(() {
        _countLoading = false;
      });
    }
  }
}
