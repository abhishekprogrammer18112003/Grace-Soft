import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class TomorrowDeparture extends StatefulWidget {
  const TomorrowDeparture({super.key});

  @override
  State<TomorrowDeparture> createState() => _TomorrowDepartureState();
}

class _TomorrowDepartureState extends State<TomorrowDeparture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('Tomorrow Departure',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: Center(
        child: Text("No departure for tomorrow"),
      ),
    );
  }
}
