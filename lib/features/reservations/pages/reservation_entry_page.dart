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
  String searchController = '';
  List<dynamic> reservationList = [];
  String? searchBySelectedItem = 'Confirm Num';
  String? reservationTypeSelectedItem = 'Regular';
  String? sortBySelectedItem = 'Confirm Num';
  bool isAscending = false;

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
          // leading: const Icon(
          //   Icons.how_to_vote_outlined,
          //   color: Colors.white,
          //   size: 30,
          // ),
          actions: [
            _buildAdd(),
            // _buildSort(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAscending = true;
                    });
                    getReservationList();
                  },
                  child: Icon(Icons.arrow_circle_up_outlined)),
            ),
          ],
          title: Text('Reservations',
              style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FilterWidget(
                ontap: (a, b, c, d) {
                  setState(() {
                    searchBySelectedItem = a;
                    reservationTypeSelectedItem = b;
                    sortBySelectedItem = c;
                    searchController = d;
                  });
                  getReservationList();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              !_loadingReservationDetails
                  ? reservationList.isNotEmpty
                      ? _buildReservationList()
                      : const Center(
                          child: Text(
                            'No Reservations are made !',
                            style: AppTextStyles
                                .textStyles_PTSans_16_400_Secondary,
                          ),
                        )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ));
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: _buildReservationList(),
    );
  }

  // _buildReservationList() => ListView.builder(
  //     itemCount: reservationList.length,
  //     itemBuilder: (context, index) {
  //       return ReservationDetailsCardWidget(
  //         reservationData: reservationList[index],
  //       );
  //     });

  _buildReservationList() => Column(
        children: [
          ...reservationList
              .map((e) => ReservationDetailsCardWidget(reservationData: e))
        ],
      );

  _buildAdd() => GestureDetector(
        onTap: () {
          // CustomNavigator.pushTo(context, AppPages.addReservation);
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 22.0),
          child: Icon(
            Icons.add,
            size: 25,
          ),
        ),
      );
  // _buildSearch() => GestureDetector(
  //       onTap: () {
  //         showModalBottomSheet<dynamic>(
  //             shape: const RoundedRectangleBorder(
  //                 borderRadius:
  //                     BorderRadius.vertical(top: Radius.circular(45))),
  //             isScrollControlled: false,
  //             context: context,
  //             builder: (BuildContext bc) {
  //               return const Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
  //                   child: FilterSearchBottomsheet());
  //             });
  //       },
  //       child: const Padding(
  //         padding: EdgeInsets.only(right: 25.0),
  //         child: Icon(
  //           Icons.search,
  //           size: 25,
  //         ),
  //       ),
  //     );

  //=============================RESERVATION API CALL=============================

  void getReservationList() async {
    reservationList.clear();
    _loadingReservationDetails = true;
    print(searchController);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String FilterType = 'ConfirmNum';
    String SortString = 'ConfirmNum';
    String reservationType = 'Regular';

    if (searchBySelectedItem == 'Confirm Num') {
      FilterType = 'ConfirmNum';
    }
    if (searchBySelectedItem == 'First Name') {
      FilterType = 'FirstName';
    }
    if (searchBySelectedItem == 'Last Name') {
      FilterType = 'LastName';
    }
    if (searchBySelectedItem == 'Full Name') {
      FilterType = 'FullName';
    }
    if (searchBySelectedItem == 'City') {
      FilterType = 'City';
    }
    if (searchBySelectedItem == 'State') {
      FilterType = 'State';
    }
    if (searchBySelectedItem == 'Home Phone') {
      FilterType = 'HomePhone';
    }

    //=================Sort by=======================
    if (sortBySelectedItem == 'Confirm Num') {
      SortString = 'ConfirmNum';
    }
    if (sortBySelectedItem == 'First Name') {
      SortString = 'FirstName';
    }
    if (sortBySelectedItem == 'Last Name') {
      SortString = 'LastName';
    }
    if (sortBySelectedItem == 'Full Name') {
      SortString = 'FullName';
    }
    if (sortBySelectedItem == 'City') {
      SortString = 'City';
    }
    if (sortBySelectedItem == 'State') {
      SortString = 'State';
    }
    if (sortBySelectedItem == 'Home Phone') {
      SortString = 'HomePhone';
    }
    String accessToken = AppData.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "PropertyId": AppData.propertyId,
      "FilterType": FilterType,
      "FilterValue": searchController,
      "StatusFilter": "ALL",
      "Offset": 0,
      "Rows": 50000,
      "SortString": SortString,
      "Ascending": isAscending,
      "ReservationType": reservationTypeSelectedItem
    };

    http.Response response = await http.post(Uri.parse(RESERVATION_LIST),
        headers: headers, body: jsonEncode(body));

    print('============Reservation List=========');
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);
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

class FilterWidget extends StatefulWidget {
  Function(String, String, String, String) ontap;
  FilterWidget({super.key, required this.ontap});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String? searchBySelectedItem = 'Confirm Num';
  String? reservationTypeSelectedItem = 'Regular';
  String? sortBySelectedItem = 'Confirm Num';

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Color.fromARGB(255, 246, 241, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildSearchFilter(),
              const SizedBox(height: 10),
              // _buildFromToDate(),
              // _buildReservationType(),
              _buildType(),
              const SizedBox(height: 10),
              _buildFindButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildSearchFilter() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search By',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                width: Get.width * 0.41,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: searchBySelectedItem,
                    onChanged: (newValue) {
                      setState(() {
                        searchBySelectedItem = newValue!;
                      });
                    },
                    items: AppData.searchByItems.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width * 0.46,
                height: 50,
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: '',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              )
            ],
          )
        ],
      );
  _buildType() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reservation Type',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                width: Get.width * 0.41,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: reservationTypeSelectedItem,
                    onChanged: (newValue) {
                      setState(() {
                        reservationTypeSelectedItem = newValue!;
                      });
                    },
                    items: AppData.reservationTypeItems.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort By',
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                width: Get.width * 0.46,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: sortBySelectedItem,
                    onChanged: (newValue) {
                      setState(() {
                        sortBySelectedItem = newValue!;
                      });
                    },
                    items: AppData.sortByItems.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  _buildFindButton() => GestureDetector(
        onTap: () {
          widget.ontap(searchBySelectedItem!, reservationTypeSelectedItem!,
              sortBySelectedItem!, searchController.text.toString());
        },
        child: Container(
            height: Get.height * 0.05,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.primary,
            ),
            child: Center(
              child: Text("Find",
                  style: AppTextStyles.textStyles_PlusJakartaSans_30_700_Primary
                      .copyWith(color: Colors.white, fontSize: 18)),
            )),
      );
}
