// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/features/dashboard/widgets/member_details_card_widget.dart';

class StayoverPage extends StatefulWidget {
  Map<String, dynamic> arguements;
  StayoverPage({super.key, required this.arguements});

  @override
  State<StayoverPage> createState() => _StayoverPageState();
}

class _StayoverPageState extends State<StayoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('${widget.arguements['day']} Stayover',
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
