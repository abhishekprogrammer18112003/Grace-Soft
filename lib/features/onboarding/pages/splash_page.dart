import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_icons.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLogin = false;
  String Datetime = "";
  @override
  void initState() {
    super.initState();

    getLoginStatus();
  }

  void getLoginStatus() async {
    SharedPreferences user = await SharedPreferences.getInstance();

    setState(() {
      isLogin = user.getBool("isLogin") ?? false;
    });
    print(isLogin);
    if (isLogin) {
      setState(() {
        Datetime = user.getString("loginTime") ?? "";
      });
      String currDateTime = DateTime.now().toString();
      DateTime dateTime1 = DateTime.parse(Datetime);
      DateTime dateTime2 = DateTime.parse(currDateTime);

      Duration difference = dateTime2.difference(dateTime1);

      // Convert the difference to minutes
      int differenceInMinutes = difference.inMinutes;
      print("=======================================");
      print(differenceInMinutes);
      if (differenceInMinutes <= 720) {
        Timer(const Duration(seconds: 3), () {
          CustomNavigator.pushReplace(context, AppPages.navigationBar);
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          CustomNavigator.pushReplace(context, AppPages.login);
        });
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        CustomNavigator.pushReplace(context, AppPages.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: Get.height * 0.11,
        ),
        Image.asset(
          AppIcons.app_icon,
        ),
        SizedBox(
          height: Get.height * 0.15,
        ),
        const CircularProgressIndicator(
          color: AppColors.black,
        ),
      ]),
    ));
  }
}
