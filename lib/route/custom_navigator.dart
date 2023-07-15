import 'package:flutter/material.dart';
import 'package:gracesoft/features/calender/pages/calender_page.dart';
import 'package:gracesoft/features/dashboard/pages/arrival_page.dart';
import 'package:gracesoft/features/dashboard/pages/checkedin_page.dart';
import 'package:gracesoft/features/dashboard/pages/dashboard_page.dart';
import 'package:gracesoft/features/dashboard/pages/departure_page.dart';
import 'package:gracesoft/features/dashboard/pages/stayover_page.dart';
import 'package:gracesoft/features/housekeeping/pages/housekeeping_page.dart';
import 'package:gracesoft/features/onboarding/pages/login_page.dart';
import 'package:gracesoft/features/onboarding/pages/splash_page.dart';
import 'package:gracesoft/features/reservations/pages/add_reservation_page.dart';
import 'package:gracesoft/features/reservations/pages/person_details_page.dart';
import 'package:gracesoft/features/reservations/pages/reservation_entry_page.dart';
import 'package:gracesoft/nav_screen.dart';

import 'app_pages.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    //use settings.arguments to pass arguments in pages
    switch (settings.name) {
      case AppPages.appEntry:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
          settings: settings,
        );

      case AppPages.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      case AppPages.navigationBar:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationBarWidget(),
          settings: settings,
        );
      case AppPages.dashboard:
        return MaterialPageRoute(
          builder: (context) => const DashboardPage(),
          settings: settings,
        );

      //==================Today=============================
      case AppPages.arrival:
        return MaterialPageRoute(
          builder: (context) => ArrivalPage(
            arguements: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );
      case AppPages.departure:
        return MaterialPageRoute(
          builder: (context) => DeparturePage(
            arguements: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );
      case AppPages.checkedin:
        return MaterialPageRoute(
          builder: (context) => CheckedinPage(
            arguements: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );
      case AppPages.stayover:
        return MaterialPageRoute(
          builder: (context) => StayoverPage(
            arguements: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );
      // //===================Tomorrow==============================
      // case AppPages.tomorrowArrival:
      //   return MaterialPageRoute(
      //     builder: (context) => const TomorrowArrival(),
      //     settings: settings,
      //   );
      // case AppPages.tomorrowDeparture:
      //   return MaterialPageRoute(
      //     builder: (context) => const TomorrowDeparture(),
      //     settings: settings,
      //   );
      // case AppPages.tomorrowCheckedin:
      //   return MaterialPageRoute(
      //     builder: (context) => const TomorrowCheckedin(),
      //     settings: settings,
      //   );
      // case AppPages.tomorrowStayover:
      //   return MaterialPageRoute(
      //     builder: (context) => const TomorrowStayover(),
      //     settings: settings,
      //   );

      case AppPages.calender:
        return MaterialPageRoute(
          builder: (context) => const CalenderPage(),
          settings: settings,
        );
      case AppPages.reservation:
        return MaterialPageRoute(
          builder: (context) => const ReservationEntryPage(),
          settings: settings,
        );
      
      case AppPages.addReservation:
        return MaterialPageRoute(
          builder: (context) => const AddReservationPage(),
          settings: settings,
        );
      case AppPages.housekeeping:
        return MaterialPageRoute(
          builder: (context) => const HouseKeepingPage(),
          settings: settings,
        );

      default:
        throw ('This route name does not exit');
    }
  }

  // Pushes to the route specified
  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.of(context, rootNavigator: true)
        .pushNamed(strPageName, arguments: arguments);
  }

  // Pop the top view
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  // Pops to a particular view
  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.popAndPushNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (page) => page.isFirst);
  }

  static void popUntilRoute(BuildContext context, String route, {var result}) {
    Navigator.popUntil(context, (page) {
      if (page.settings.name == route && page.settings.arguments != null) {
        (page.settings.arguments as Map<String, dynamic>)["result"] = result;
        return true;
      }
      return false;
    });
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushReplacementNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }
}
