import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/reservations/widgets/filter_search_bottomsheet.dart';
import 'package:gracesoft/features/reservations/widgets/reservation_details_card_widget.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';

class ReservationEntryPage extends StatefulWidget {
  const ReservationEntryPage({super.key});

  @override
  State<ReservationEntryPage> createState() => _ReservationEntryPageState();
}

class _ReservationEntryPageState extends State<ReservationEntryPage> {
  String? searchBySelectedItem = 'Reservation#';
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: const Icon(
          Icons.how_to_vote_outlined,
          color: Colors.white,
          size: 30,
        ),
        actions: [
          _buildAdd(),
          _buildSearch(),
        ],
        title: Text('Reservations',
            style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return const ReservationDetailsCardWidget();
          }),
    );
  }

  _buildAdd() => GestureDetector(
        onTap: () {
          CustomNavigator.pushTo(context, AppPages.addReservation);
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 22.0),
          child: Icon(
            Icons.add,
            size: 25,
          ),
        ),
      );
  _buildSearch() => GestureDetector(
        onTap: () {
          showModalBottomSheet<dynamic>(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              isScrollControlled: false,
              context: context,
              builder: (BuildContext bc) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                    child: FilterSearchBottomsheet());
              });
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: Icon(
            Icons.search,
            size: 25,
          ),
        ),
      );
}
