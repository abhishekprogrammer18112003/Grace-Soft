import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class status_container extends StatelessWidget {
  status_container(
      {super.key,
      required this.stat,
      required this.stat_name,
      required this.stat_col});
  int stat = 0;
  String stat_name = "asd";
  Color stat_col;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.all(10),
      height: 35,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: stat_col,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stat_name,
            style: AppTextStyles.defaultTextStyle.copyWith(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Container(
            padding: EdgeInsets.all(6),
            width: 30,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 150, 147, 147)),
            child: Text(
              stat.toString(),
              style:
                  AppTextStyles.defaultTextStyle.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
