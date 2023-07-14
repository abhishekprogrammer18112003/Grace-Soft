// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/reservations/pages/person_details_page.dart';


class ReservationDetailsCardWidget extends StatefulWidget {
  dynamic reservationData;
  ReservationDetailsCardWidget({super.key, required this.reservationData});

  @override
  State<ReservationDetailsCardWidget> createState() =>
      _ReservationDetailsCardWidgetState();
}

class _ReservationDetailsCardWidgetState
    extends State<ReservationDetailsCardWidget> {
  String? ArrDate;
  String? DeptDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String arrival = widget.reservationData["ArrDate"];
    List<String> arrDate = arrival.split('T');
    print(arrDate[0]);
    ArrDate = arrDate[0];

    String departure = widget.reservationData["DeptDate"];
    List<String> deptDate = departure.split('T');
    DeptDate = deptDate[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Get.width,
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
                text: widget.reservationData["ConfirmNum"].toString(),
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailsPage(data: widget.reservationData)));
            },
            child: SizedBox(
              child: Text(
                " ${widget.reservationData["FullName"].toString()}",
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    fontSize: 17),
              ),
            ),
          ),
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 2),
                Text(widget.reservationData["Guests"].toString())
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

  _buildRoomNumber() => Row(
        children: [
          const Icon(Icons.door_back_door_outlined),
          Text(
            " ${widget.reservationData["RoomNames"]}",
            style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
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
                    Text(widget.reservationData["PostTaxTotal"].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Amount Paid : ",
                        style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w800)),
                    Text(widget.reservationData["AmountPaid"].toString()),
                  ],
                ),
              ],
            ),

            // SizedBox(width: Get.width * 0.24),
            Container(
              height: 30,
              width: 100,
              color: widget.reservationData["Status"] == "CANCELLED"
                  ? Colors.red
                  : widget.reservationData["Status"] != "Confirmed"
                      ? Colors.blue
                      : Colors.green,
              child: Center(
                  child: Text(
                widget.reservationData["Status"],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              )),
            )
          ],
        ),
      );
}
