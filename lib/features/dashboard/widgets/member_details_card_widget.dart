import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class MemberDetailsCardWidget extends StatefulWidget {
  dynamic stayoverData;
  MemberDetailsCardWidget({super.key, required this.stayoverData});

  @override
  State<MemberDetailsCardWidget> createState() =>
      _MemberDetailsCardWidgetState();
}

class _MemberDetailsCardWidgetState extends State<MemberDetailsCardWidget> {
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
                text: widget.stayoverData["ConfirmNumber"].toString(),
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
          SizedBox(
            child: Text(
              " ${widget.stayoverData["GuestName"].toString()}",
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  fontSize: 17),
            ),
          ),
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 2),
                Text(widget.stayoverData["NoOfGuests"].toString())
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
          Text("  ${widget.stayoverData["ArrDate"]}"),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text("${widget.stayoverData["DeptDate"]}"),
          ),
        ],
      );

  _buildRoomNumber() => Row(
        children: [
          const Icon(Icons.door_back_door_outlined),
          Text(
            " ${widget.stayoverData["RoomName"]}",
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
            widget.stayoverData["Referral"] != ""
                ? Row(
                    children: [
                      Text("Referal : ",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w800)),
                      Text(widget.stayoverData["Referral"]),
                    ],
                  )
                : Container(
                    child: Text('No Referal'),
                  ),

            // SizedBox(width: Get.width * 0.24),
            Container(
              height: 30,
              width: 100,
              color: Colors.green,
              child: Center(
                  child: Text(
                widget.stayoverData["Status"],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              )),
            )
          ],
        ),
      );
}
