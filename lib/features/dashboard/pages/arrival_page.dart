// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/features/dashboard/widgets/member_details_card_widget.dart';

class ArrivalPage extends StatefulWidget {
  Map<String, dynamic> arguements;
  ArrivalPage({super.key, required this.arguements});

  @override
  State<ArrivalPage> createState() => _ArrivalPageState();
}

class _ArrivalPageState extends State<ArrivalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('${widget.arguements['day']} Arrivals',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return const MemberDetailsCardWidget();
            }),
      ),
    );
  }
}
