import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_icons.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      CustomNavigator.pushReplace(context, AppPages.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.green,
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: Get.height * 0.11,
        ),
        Image.asset(
          AppIcons.app_icon,
          // fit: BoxFit.fill,
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
