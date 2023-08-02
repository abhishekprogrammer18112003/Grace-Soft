import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class AppData {
  static String appName = "Grace Soft";

  static int propertyId = 1885;
  static String accessToken =
      "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyIjoiSmVzc3UiLCJEZXNpZ25hdGlvbiI6IiIsIkdyb3VwSUQiOiI4IiwiUHJvcGVydHlJRCI6IjE4ODUiLCJVc2VyTmFtZSI6InByYWthc2giLCJpYXQiOjE2OTA2MDU2NzUsImV4cCI6MTY5MDY0ODg3NSwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QifQ.26bB96v-a1VjppVwPuG0s4I6A7gwGEkoVvO723uGkc0";

  static List<String> daysItems = ['Today', 'Tomorrow'];

  static List<String> searchByItems = [
    'Reservation#',
    'First Name',
    'Last Name',
    'Full Name',
    'City',
    'State'
  ];

  static List<Color> pieChartColors = [
    Colors.green,
    Colors.orange,
    Colors.blue,
    AppColors.primary,
    Colors.yellow
  ];
}
