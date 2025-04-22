
import 'package:flutter/material.dart';

import 'dynamic_form_features/dynamic_form_presentation/ui/defaultPage.dart';
import 'dynamic_form_features/dynamic_form_presentation/ui/error.dart';
import 'dynamic_form_features/dynamic_form_presentation/ui/page_demo.dart';

class Routes {
  static const String demoPage = "/";
  static const String defaultPage = "/Demo";
}

class RouteGenerator {
  static RouteSettings? routeDefaultSettings;

  static Route<dynamic> generateRoute(
    RouteSettings routeSettings,
    Map<String, dynamic>? initData,
  ) {
    routeDefaultSettings = routeSettings;
    try {
      Map? args;
      if (routeSettings.arguments != null) {
        args = routeSettings.arguments as Map;
      }
      switch (routeSettings.name) {
        case Routes.demoPage:
          return MaterialPageRoute(
            builder: (_) => DemoPage(
              initData: initData,
            ),
          );
        case Routes.defaultPage:
          return MaterialPageRoute(
            builder: (_) => const DefaultPage(),
          );
        default:
          return errorRoute(routeSettings);
      }
    } catch (e) {
      return errorRoute(routeSettings);
    }
  }

  /// Method that calles the error screen when neccesary
  static Route<dynamic> errorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const ErrorScreen(),
    );
  }
}
