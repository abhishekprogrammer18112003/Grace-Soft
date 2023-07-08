import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class MemberDetailsCardWidget extends StatefulWidget {
  const MemberDetailsCardWidget({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildResTag(),
                  // SizedBox(width: Get.width * 0.04),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNamePersonInfoRow(),
                      const SizedBox(height: 5),
                      _buildArrivalDeparture(),
                      //icon for arrival and departure
                      const SizedBox(height: 3),

                      _buildDates(),
                      //dates

                      SizedBox(height: Get.height * 0.007),

                      //Rooom no.
                      _buildRoomNumber(),
                    ],
                  )
                ],
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
              _buildCardFooter(),
            ],
          ),
        ),
      ),
    );
  }

  _buildResTag() => Container(
        height: Get.height * 0.1,
        width: Get.width * 0.1,
        color: Colors.black87,
        child: RotatedBox(
          quarterTurns: -1,
          child: Center(
            child: RichText(
              text: const TextSpan(
                text: '4127',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      );

  _buildNamePersonInfoRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Mr. Manohar Mathew",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
                fontSize: 15),
          ),
          SizedBox(
            width: Get.width * 0.2,
          ),
          const Icon(Icons.person),
          const SizedBox(width: 2),
          const Text('1'),
        ],
      );
  _buildArrivalDeparture() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.share_arrival_time),
          const SizedBox(width: 8),
          const Text(
            "Arrival",
            style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: Get.width * 0.27,
          ),
          const Icon(Icons.departure_board),
          const SizedBox(width: 8),
          const Text(
            "Departure",
            style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ],
      );
  _buildDates() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          const Text("05/29/2023"),
          SizedBox(
            width: Get.width * 0.25,
          ),
          const SizedBox(width: 10),
          const Text("05/31/2023"),
        ],
      );

  _buildRoomNumber() => Row(
        children: [
          const Icon(Icons.door_back_door_outlined),
          Text(
            "  Country Inn Suite Type 54",
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
            Text("Referal : ",
                style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
            Text('AppWhizRes'),
            SizedBox(width: Get.width * 0.24),
            Container(
              height: 30,
              width: 70,
              color: Colors.green,
              child: const Center(
                  child: Text(
                "Booked",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )),
            )
          ],
        ),
      );
}
