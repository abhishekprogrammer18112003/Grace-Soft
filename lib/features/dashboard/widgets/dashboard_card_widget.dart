import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class DashBoardCardWidget extends StatefulWidget {
  String image;
  String name;
  String count;
  Color colorname;
  DashBoardCardWidget(
      {super.key,
      required this.name,
      required this.image,
      required this.count,
      required this.colorname});

  @override
  State<DashBoardCardWidget> createState() => _DashBoardCardWidgetState();
}

class _DashBoardCardWidgetState extends State<DashBoardCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.42,
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
              Image.asset(widget.image),
              Text(
                widget.count,
                style: AppTextStyles.textStyles_Puritan_30_400_Secondary
                    .copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: widget.colorname),
              ),
              const SizedBox(height: 5),
              Text(
                widget.name,
                textAlign: TextAlign.center,
                style:
                    AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
