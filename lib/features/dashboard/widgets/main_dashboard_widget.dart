// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_icons.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/dashboard/widgets/dashboard_card_widget.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';
import 'package:pie_chart/pie_chart.dart';

class DashboardWidget extends StatefulWidget {
  int arrivalCount;
  int departureCount;
  int stayoverCount;
  int bookedCount;
  int blockedCount;
  int vacantCount;
  int checkInCount;
  String day;
  List<dynamic> checkedInData;

  DashboardWidget({
    super.key,
    required this.arrivalCount,
    required this.blockedCount,
    required this.checkInCount,
    required this.day,
    required this.departureCount,
    required this.bookedCount,
    required this.stayoverCount,
    required this.vacantCount,
    required this.checkedInData,
  });

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('========dashboard widget===========');
    print(widget.arrivalCount);
    print(widget.departureCount);
    print(widget.bookedCount);
    print(widget.vacantCount);
    print(widget.blockedCount);
    print(widget.stayoverCount);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            _buildCountDataWithPiechart(),
            const SizedBox(height: 20),
            _buildArrivalDepartureRow(),
            const SizedBox(height: 20),
            _buildStayoverChekedinRow(),
            const SizedBox(height: 30),
            _buildOccupiedBlockedVacant(),
          ],
        ),
      ),
    );
  }

  _buildOccupiedBlockedVacant() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: double.infinity,
          height: Get.height * 0.21,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(199, 158, 158, 158).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: Get.height * 0.13,
                  width: Get.width * 0.3,
                  child: Image.asset(
                    AppIcons.occupiedblockedvacant,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.bookedCount} / ${widget.blockedCount} / ${widget.vacantCount}",
                      style: AppTextStyles.textStyles_Puritan_30_400_Secondary
                          .copyWith(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: const Text(
                        "Occupied/ Blocked \n/ Vacant",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  _buildArrivalDepartureRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                CustomNavigator.pushTo(context, AppPages.arrival,
                    arguments: {'day': widget.day});
              },
              child: DashBoardCardWidget(
                  name: "Arrival",
                  image: AppIcons.arrival,
                  count: widget.arrivalCount,
                  colorname: Colors.green)),
          GestureDetector(
            onTap: () {
              CustomNavigator.pushTo(context, AppPages.departure,
                  arguments: {'day': widget.day});
            },
            child: DashBoardCardWidget(
              colorname: Colors.red,
              name: "Departure",
              count: widget.departureCount,
              image: AppIcons.departure,
            ),
          ),
        ],
      );
  _buildStayoverChekedinRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                CustomNavigator.pushTo(context, AppPages.stayover,
                    arguments: {'day': widget.day});
              },
              child: DashBoardCardWidget(
                  name: "StayOver",
                  image: AppIcons.stayover,
                  count: widget.stayoverCount,
                  colorname: Colors.blue)),
          GestureDetector(
            onTap: () {
              CustomNavigator.pushTo(context, AppPages.checkedin,
                  arguments: {'day': widget.day});
            },
            child: DashBoardCardWidget(
              colorname: Colors.black,
              name: "Checked In",
              count: widget.checkInCount,
              image: AppIcons.checkedins,
            ),
          ),
        ],
      );

  _buildCountDataWithPiechart() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          width: double.infinity,
          // height: Get.height * 0.21,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(199, 158, 158, 158).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Container(
                      width: Get.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Counts',
                            style: AppTextStyles
                                .textStyles_PTSans_16_400_Secondary
                                .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildCountData(widget.arrivalCount, 'Arrival'),
                          _buildCountData(widget.departureCount, 'Departure'),
                          _buildCountData(widget.stayoverCount, 'stayover'),
                          _buildCountData(widget.bookedCount, 'Occupied'),
                          _buildCountData(widget.blockedCount, 'Blocked'),
                          _buildCountData(widget.checkInCount, 'Check-In')
                        ],
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Accuracy',
                        style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                            .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PieChart(
                        dataMap: {
                          'Arrival':
                              double.parse(widget.arrivalCount.toString()),
                          'Departure':
                              double.parse(widget.departureCount.toString()),
                          'Stayover':
                              double.parse(widget.stayoverCount.toString()),
                          'Occupied':
                              double.parse(widget.bookedCount.toString()),
                          'Blocked':
                              double.parse(widget.blockedCount.toString()),
                          'Checked-In':
                              double.parse(widget.checkInCount.toString())
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValues: false,
                            showChartValuesInPercentage: false),
                        animationDuration: const Duration(milliseconds: 500),
                        legendOptions: const LegendOptions(
                            // showLegends: false,

                            legendTextStyle: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.w300),
                            legendPosition: LegendPosition.right),
                        chartType: ChartType.ring,
                        chartRadius: 48,
                        colorList: AppData.pieChartColors,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  _buildCountData(int data, String title) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title),
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 12,
                child: Center(
                  child: Text(
                    data.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
