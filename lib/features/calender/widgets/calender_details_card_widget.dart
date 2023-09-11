// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/calender/widgets/calender_personal_details_page.dart';
import 'package:gracesoft/features/reservations/pages/person_details_page.dart';

class CalenderDetailsCardWidget extends StatefulWidget {
  dynamic calenderData;
  dynamic roomsData;
  Color color;
  CalenderDetailsCardWidget(
      {super.key,
      required this.calenderData,
      required this.roomsData,
      required this.color});

  @override
  State<CalenderDetailsCardWidget> createState() =>
      _CalenderDetailsCardWidgetState();
}

class _CalenderDetailsCardWidgetState extends State<CalenderDetailsCardWidget> {
  String? ArrDate;
  String? DeptDate;
  // late String roomName;

  @override
  void initState() {
    super.initState();

    String arrival = widget.calenderData["ResArrDate"];
    List<String> arrDate = arrival.split('T');

    ArrDate = arrDate[0];

    String departure = widget.calenderData["ResDeptDate"];
    List<String> deptDate = departure.split('T');
    DeptDate = deptDate[0];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CalenderPersonDetailsPage(
                    data: widget.calenderData, roomsData: widget.roomsData)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: widget.calenderData['Status'] != ''
                ? Colors.white
                : const Color.fromARGB(255, 204, 204, 204),
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
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildResTag(),
                      SizedBox(width: Get.width * 0.03),
                      Container(
                        width: Get.width * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildNamePersonInfoRow(),
                            const SizedBox(height: 5),
                            _buildArrival(),
                            const SizedBox(height: 3),
                            _buildDates(),
                            SizedBox(height: Get.height * 0.007),
                            _buildRoomNumber(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                      child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  )),
                ),
                const SizedBox(height: 1),
                Container(
                  // color: Colors.blue,
                  child: _buildCardFooter(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildResTag() => Container(
        height: Get.height * 0.1,
        width: Get.width * 0.1,
        color: Colors.black54,
        child: RotatedBox(
          quarterTurns: -1,
          child: Center(
            child: RichText(
              text: TextSpan(
                text: widget.calenderData["ConfirmNum"].toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      );

  _buildNamePersonInfoRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: SizedBox(
                child: widget.calenderData['Status'] != ''
                    ? Text(
                        " ${widget.calenderData["FirstName"].toString()} ${widget.calenderData["LastName"].toString()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            fontSize: 17),
                      )
                    : const Text(
                        " Auto",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            fontSize: 17),
                      )),
          ),
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 2),
                Text(widget.calenderData["Guests"].toString())
              ],
            ),
          ))
        ],
      );
  _buildArrival() => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.share_arrival_time),
              SizedBox(width: 5),
              Text(
                "Arrival",
                style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Row(
              children: [
                Icon(Icons.departure_board),
                SizedBox(width: 5),
                Text(
                  "Departure",
                  style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      );

  _buildDates() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(),
          Text("  ${ArrDate}"),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text("${DeptDate}"),
          ),
        ],
      );

  _buildRoomNumber() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Icon(Icons.door_back_door_outlined),
              Text(
                "Room Name : ",
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
              ),
              Container(
                width: Get.width * 0.4,
                // color: AppColors.TOAST_ALERT,
                child: Text(
                  "${widget.roomsData['RoomName']}",
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Room Type : ",
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
              ),
              Container(
                width: Get.width * 0.4,
                // color: AppColors.TOAST_ALERT,
                child: Text(
                  " ${widget.roomsData['RoomType']}",
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ],
      );

  _buildCardFooter() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Post Tax Total: ",
                        style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w800)),
                    Text(widget.calenderData["PostTaxTotal"].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Amount Paid : ",
                        style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w800)),
                    Text(widget.calenderData["AmountPaid"].toString()),
                  ],
                ),
              ],
            ),

            // SizedBox(width: Get.width * 0.24),
            widget.calenderData['Status'] != ""
                ? Container(
                    height: 30,
                    width: 100,
                    color: widget.color,
                    child: Center(
                        child: Text(
                      widget.calenderData["Status"],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )),
                  )
                : Container(
                    height: 30,
                    width: 100,
                    color: widget.color,
                    child: const Center(
                        child: Text(
                      'Blocked',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )),
                  ),
          ],
        ),
      );
}
