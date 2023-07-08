// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/features/calender/pages/calender_page.dart';
import 'package:gracesoft/features/dashboard/pages/dashboard_page.dart';
import 'package:gracesoft/features/housekeeping/pages/housekeeping_page.dart';
import 'package:gracesoft/features/reservations/pages/reservation_entry_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int initialIndex;
  const BottomNavigationBarWidget({Key? key, this.initialIndex = 0})
      : super(key: key);
  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    const DashboardPage(),
    const ReservationEntryPage(),
    const CalenderPage(),
    const HouseKeepingPage(),
  ];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.initialIndex;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pageController.jumpToPage(widget.initialIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.primary,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: AppColors.primary,
              icon: Icon(
                Icons.home,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.real_estate_agent_outlined),
              label: 'Reservations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calender',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'Housekeeping',
            ),
          ],
        ),
      ),
    );
  }
}
