import 'package:flutter/material.dart';

extension ExtensionContext on BuildContext {
  TextTheme getTextTheme() {
    return Theme.of(this).textTheme;
  }

  InputDecorationTheme getiInputDecorationTheme() {
    return Theme.of(this).inputDecorationTheme;
  }

  NavigatorState getNavigator() {
    return Navigator.of(this);
  }

  void popNav({Object? value}) {
    return Navigator.of(this).pop(value);
  }

  Future navPush(String routeName, {Object? arguments}) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }
}
