// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class DeparturePage extends StatefulWidget {
  Map<String, dynamic> arguements;
  DeparturePage({super.key, required this.arguements});

  @override
  State<DeparturePage> createState() => _DeparturePageState();
}

class _DeparturePageState extends State<DeparturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('${widget.arguements['day']} Departure',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: Center(
        child: Text("No departure for ${widget.arguements['day']}"),
      ),
    );
  }
}
