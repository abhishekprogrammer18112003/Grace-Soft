import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/features/onboarding/pages/splash_page.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: AppData.appName,
        initialRoute: AppPages.appEntry,
        onGenerateRoute: CustomNavigator.controller,
        theme: ThemeData(appBarTheme: AppBarTheme(color: AppColors.primary)),
        home: const SplashPage());
  }
}
