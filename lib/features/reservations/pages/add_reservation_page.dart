import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class AddReservationPage extends StatefulWidget {
  const AddReservationPage({super.key});

  @override
  State<AddReservationPage> createState() => _AddReservationPageState();
}

class _AddReservationPageState extends State<AddReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Reservation',
          style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
