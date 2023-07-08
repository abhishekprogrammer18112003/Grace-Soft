// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class CheckedinPage extends StatefulWidget {
  Map<String, dynamic> arguements;
  CheckedinPage({super.key, required this.arguements});

  @override
  State<CheckedinPage> createState() => _CheckedinPageState();
}

class _CheckedinPageState extends State<CheckedinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('${widget.arguements['day']} Checked-In',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: Center(
        child: Text("No Checkedin for ${widget.arguements['day']}"),
      ),
    );
  }
}
