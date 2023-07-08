import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/dashboard/widgets/main_dashboard_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? selectedItem = 'Today';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          // back
          appBar: AppBar(
            backgroundColor: AppColors.primary,

            bottom: TabBar(
              // indicatorWeight: 10,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              indicatorWeight: 4,

              // indicator: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50), // Creates border
              //     color: appPrimarycolor),
              tabs: [
                Tab(
                  child: Text("Today",
                      style: AppTextStyles
                          .textStyles_PlusJakartaSans_30_700_Primary
                          .copyWith(
                              fontSize: 16,
                              color: Colors.yellow,
                              fontWeight: FontWeight.w400)),
                ),
                Tab(
                  child: Text("Tomorrow",
                      style: AppTextStyles
                          .textStyles_PlusJakartaSans_30_700_Primary
                          .copyWith(
                              fontSize: 16,
                              color: Colors.yellow,
                              fontWeight: FontWeight.w400)),
                )
              ],
            ),

            // leading: Icon(Icons.construction),
            automaticallyImplyLeading: false,
            leading: const Icon(
              Icons.hotel,
              color: Colors.white,
              size: 30,
            ),
            title: Text('Dashboard',
                style: AppTextStyles.textStyles_Puritan_30_400_Secondary
                    .copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildTodayWidget(),
              _buildTomorrowWidget(),
            ],
          )),
    );
  }

  _buildTodayWidget() => DashboardWidget(
      arrivalCount: "1",
      blockedCount: "0",
      checkedinCount: "0",
      day: "Today",
      departureCount: "0",
      occupiedCount: "2",
      stayoverCount: "1",
      vacantCount: "52");
  _buildTomorrowWidget() => DashboardWidget(
      arrivalCount: "2",
      blockedCount: "1",
      checkedinCount: "0",
      day: "Tomorrow",
      departureCount: "5",
      occupiedCount: "2",
      stayoverCount: "1",
      vacantCount: "51");

  _buildDropDownMenu() => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedItem,
            onChanged: (newValue) {
              setState(() {
                selectedItem = newValue!;
              });
            },
            items: AppData.daysItems.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),
        ),
      );
}
