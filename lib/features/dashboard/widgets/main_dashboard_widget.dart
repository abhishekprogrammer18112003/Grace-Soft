import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_icons.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/dashboard/widgets/dashboard_card_widget.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';

class DashboardWidget extends StatefulWidget {
  String arrivalCount;
  String departureCount;
  String stayoverCount;
  String checkedinCount;

  String occupiedCount;
  String blockedCount;
  String vacantCount;
  String day;

  DashboardWidget(
      {super.key,
      required this.arrivalCount,
      required this.blockedCount,
      required this.checkedinCount,
      required this.day,
      required this.departureCount,
      required this.occupiedCount,
      required this.stayoverCount,
      required this.vacantCount});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
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
            _buildOccupiedBlockedVacant(),
            const SizedBox(height: 20),
            _buildArrivalDepartureRow(),
            const SizedBox(height: 20),
            _buildStayOverCheckedInRow(),
            const SizedBox(height: 30),
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
                    AppIcons.occupied_blocked_vacant,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.occupiedCount} / ${widget.blockedCount} / ${widget.vacantCount}",
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              )),
        ],
      );

  _buildStayOverCheckedInRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                CustomNavigator.pushTo(context, AppPages.stayover,
                    arguments: {'day': widget.day});
              },
              child: DashBoardCardWidget(
                  name: "Stayover",
                  image: AppIcons.stayover,
                  count: widget.stayoverCount,
                  colorname: Colors.blue)),
          GestureDetector(
            onTap: () {
              CustomNavigator.pushTo(context, AppPages.checkedin,
                  arguments: {'day': widget.day});
            },
            child: Container(
              width: Get.width * 0.42,
              // width: double.infinity,
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outlined,
                        color: AppColors.primary,
                        size: 49,
                      ),
                      Text(
                        widget.checkedinCount,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Checked-In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
