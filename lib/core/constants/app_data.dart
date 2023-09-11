import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class AppData {
  static String appName = "Grace Soft";

  static int propertyId = 1885;
  static String accessToken =
      "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyIjoiSmVzc3UiLCJEZXNpZ25hdGlvbiI6IiIsIkdyb3VwSUQiOiI4IiwiUHJvcGVydHlJRCI6IjE4ODUiLCJVc2VyTmFtZSI6InByYWthc2giLCJpYXQiOjE2OTE2ODMyNjUsImV4cCI6MTY5MTcyNjQ2NSwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QifQ.vTBJ0jFD4R2zP3SVNcuJt9yWJXEFt2bEtkZPI4RSaqE";

  static List<String> daysItems = ['Today', 'Tomorrow'];

  static List<String> searchByItems = [
    'Confirm Num',
    'First Name',
    'Last Name',
    'Full Name',
    'City',
    'State',
    'Home Phone',
  ];

  static List<String> sortByItems = [
    'First Name',
    'Last Name',
    'Full Name',
    'City',
    'State',
    'Home Phone',
    'Confirm Num',
  ];
  static List<String> reservationTypeItems = [
    'All',
    'Regular',
    'Hourly',
    'Group',
    'Package'
  ];

  static List<Color> pieChartColors = [
    Colors.green,
    Colors.orange,
    Colors.blue,
    AppColors.primary,
    Colors.yellow
  ];
}
