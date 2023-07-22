import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:gracesoft/features/reservations/widgets/filter_search_bottomsheet.dart';
import 'package:gracesoft/features/reservations/widgets/reservation_details_card_widget.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shimmer/shimmer.dart';

class ReservationEntryPage extends StatefulWidget {
  const ReservationEntryPage({super.key});

  @override
  State<ReservationEntryPage> createState() => _ReservationEntryPageState();
}

class _ReservationEntryPageState extends State<ReservationEntryPage> {
  String? searchBySelectedItem = 'Reservation#';
  TextEditingController searchController = TextEditingController();
  List<dynamic> reservationList = [];

  @override
  void initState() {
    super.initState();
    getReservationList();
  }

  bool _loadingReservationDetails = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: const Icon(
          Icons.how_to_vote_outlined,
          color: Colors.white,
          size: 30,
        ),
        actions: [
          _buildAdd(),
          _buildSearch(),
        ],
        title: Text('Reservations',
            style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),
      body: !_loadingReservationDetails
          ? _buildReservationList()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: _buildReservationList(),
    );
  }

  _buildReservationList() => ListView.builder(
      itemCount: reservationList.length,
      itemBuilder: (context, index) {
        return ReservationDetailsCardWidget(
          reservationData: reservationList[index],
        );
      });

  _buildAdd() => GestureDetector(
        onTap: () {
          CustomNavigator.pushTo(context, AppPages.addReservation);
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 22.0),
          child: Icon(
            Icons.add,
            size: 25,
          ),
        ),
      );
  _buildSearch() => GestureDetector(
        onTap: () {
          showModalBottomSheet<dynamic>(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              isScrollControlled: false,
              context: context,
              builder: (BuildContext bc) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                    child: FilterSearchBottomsheet());
              });
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: Icon(
            Icons.search,
            size: 25,
          ),
        ),
      );

  //=============================RESERVATION API CALL=============================

  void getReservationList() async {
    _loadingReservationDetails = true;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = AppData.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "PropertyId": AppData.propertyId,
      "FilterType": "ConfirmNum",
      "FilterValue": "",
      "StatusFilter": "ALL",
      "Offset": 0,
      "Rows": 50,
      "SortString": "ConfirmNum",
      "Ascending": false,
      "ReservationType": "Regular"
    };

    http.Response response = await http.post(Uri.parse(RESERVATION_LIST),
        headers: headers, body: jsonEncode(body));

    print('============Reservation List=========');
    print(response.body);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      reservationList.addAll(data);
      setState(() {
        _loadingReservationDetails = false;
      });
    } else {
      Get.snackbar('Something went wrong !',
          'Something went wrong . Please try again After sometime',
          backgroundColor: Colors.orange);
      setState(() {
        _loadingReservationDetails = false;
      });
    }
  }
}
