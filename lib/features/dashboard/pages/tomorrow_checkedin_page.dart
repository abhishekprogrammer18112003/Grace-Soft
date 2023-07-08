import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class TomorrowCheckedin extends StatefulWidget {
  const TomorrowCheckedin({super.key});

  @override
  State<TomorrowCheckedin> createState() => _TomorrowCheckedinState();
}

class _TomorrowCheckedinState extends State<TomorrowCheckedin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('Tomorrow Checked-In',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: Center(
        child: Text("No Checkedin for tomorrow"),
      ),
    );
  }
}
